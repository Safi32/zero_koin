import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_koin/services/api_service.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  
  // Observable user data
  final Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // Error state
  final RxString error = ''.obs;
  
  // Invite code (for easy access)
  final RxString inviteCode = ''.obs;
  
  // Recent amount (for easy access)
  final RxInt recentAmount = 0.obs;
  
  // Balance (for easy access)
  final RxInt balance = 0.obs;

  // Wallet addresses (for easy access)
  final RxString metamaskAddress = ''.obs;
  final RxString trustWalletAddress = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Initial loading of user data
    _loadUserData();
    
    // Listen to auth state changes to reload data when user signs in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _loadUserData();
      } else {
        // Clear user data when signed out
        userData.value = {};
        inviteCode.value = '';
        recentAmount.value = 0;
        balance.value = 0;
        metamaskAddress.value = '';
        trustWalletAddress.value = '';
      }
    });
  }
  
  // Helper method to load user data with fallback
  Future<void> _loadUserData() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    
    try {
      // First try syncing to ensure we have the most up-to-date data
      final syncSuccess = await syncUserData();
      
      // If sync fails, try fetching the profile as a fallback
      if (!syncSuccess) {
        await fetchUserProfile();
      }
    } catch (e) {
      print('Error in _loadUserData: $e');
      error.value = 'Failed to load user data: ${e.toString()}';
    }
  }
  
  // Fetch user profile from the backend
  Future<void> fetchUserProfile() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return; // Not signed in
    }
    
    try {
      isLoading.value = true;
      error.value = '';
      
      final data = await ApiService.getUserProfile();
      
      if (data != null && data['user'] != null) {
        userData.value = data['user'];
        
        // Extract commonly used values for easy access
        inviteCode.value = data['user']['inviteCode'] ?? '';
        recentAmount.value = data['user']['recentAmount'] ?? 0;
        balance.value = data['user']['balance'] ?? 0;

        // Extract wallet addresses
        final walletAddresses = data['user']['walletAddresses'] ?? {};
        metamaskAddress.value = walletAddresses['metamask'] ?? '';
        trustWalletAddress.value = walletAddresses['trustWallet'] ?? '';
        
        print('User profile loaded: ${userData.value}');
      } else {
        print('Profile data missing, trying to sync first...');
        await syncUserData();
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
      print('Error fetching user profile: $e');
      
      // If profile fetch fails (like 404), try syncing
      print('Attempting to sync user data after profile fetch failed');
      await syncUserData();
    } finally {
      isLoading.value = false;
    }
  }
  
  // Sync user data with the backend
  Future<bool> syncUserData() async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final result = await ApiService.syncFirebaseUser();
      
      if (result != null && result['user'] != null) {
        // Extract user data directly from sync response
        userData.value = result['user'];
        inviteCode.value = result['user']['inviteCode'] ?? '';
        recentAmount.value = result['user']['recentAmount'] ?? 0;
        balance.value = result['user']['balance'] ?? 0;

        // Extract wallet addresses
        final walletAddresses = result['user']['walletAddresses'] ?? {};
        metamaskAddress.value = walletAddresses['metamask'] ?? '';
        trustWalletAddress.value = walletAddresses['trustWallet'] ?? '';
        
        print('User data synced successfully: ${userData.value}');
        return true;
      } else {
        error.value = 'Failed to sync user data';
        return false;
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
      print('Error syncing user data: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Get user's display name
  String get name {
    return userData.value['name'] ?? 
           FirebaseAuth.instance.currentUser?.displayName ?? 
           'User';
  }
  
  // Get user's email
  String get email {
    return userData.value['email'] ?? 
           FirebaseAuth.instance.currentUser?.email ?? 
           '';
  }
  
  // Get user's creation date
  String get createdAt {
    return userData.value['createdAt'] ?? '';
  }
  
  // Check if user data is loaded
  bool get isUserDataLoaded {
    return userData.value.isNotEmpty && inviteCode.value.isNotEmpty;
  }
  
  // Get user's Firebase UID
  String get firebaseUid {
    return userData.value['firebaseUid'] ?? 
           FirebaseAuth.instance.currentUser?.uid ?? 
           '';
  }
  
  // Get referrer's invite code
  String get referredBy {
    return userData.value['referredBy'] ?? '';
  }

  // Update wallet address
  Future<bool> updateWalletAddress(String walletType, String address) async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await ApiService.updateWalletAddress(walletType, address);

      if (result != null) {
        // Update local state
        if (walletType == 'metamask') {
          metamaskAddress.value = address;
        } else if (walletType == 'trustWallet') {
          trustWalletAddress.value = address;
        }

        // Update userData with new wallet addresses
        final currentWalletAddresses = userData.value['walletAddresses'] ?? {};
        currentWalletAddresses[walletType] = address;
        userData.value['walletAddresses'] = currentWalletAddresses;
        userData.refresh(); // Notify observers

        print('✅ Wallet address updated locally: $walletType = $address');
        return true;
      } else {
        error.value = 'Failed to update wallet address';
        return false;
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
      print('Error updating wallet address: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Get wallet address by type
  String getWalletAddress(String walletType) {
    if (walletType == 'metamask') {
      return metamaskAddress.value;
    } else if (walletType == 'trustWallet') {
      return trustWalletAddress.value;
    }
    return '';
  }

  // Check if wallet is connected
  bool isWalletConnected(String walletType) {
    return getWalletAddress(walletType).isNotEmpty;
  }
}