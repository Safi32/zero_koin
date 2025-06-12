import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';

class AuthService extends GetxController {
  static AuthService get instance => Get.find();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  // Observable user state
  Rxn<User> user = Rxn<User>();
  
  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    user.bindStream(_auth.authStateChanges());
  }
  
  // Check if user is signed in
  bool get isSignedIn => user.value != null;
  
  // Get current user
  User? get currentUser => user.value;
  
  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Show loading
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        Get.back(); // Close loading dialog
        return null;
      }
      
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Sync user data to MongoDB
      await _syncUserToMongoDB();

      Get.back(); // Close loading dialog

      // Show success message
      Get.snackbar(
        'Success',
        'Successfully signed in with Google!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF086F8A),
        colorText: Colors.white,
      );

      return userCredential;
      
    } catch (e) {
      Get.back(); // Close loading dialog if open
      
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to sign in with Google: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      
      // Log error for debugging
      if (Get.isLogEnable) {
        print('Google Sign-In Error: $e');
      }
      return null;
    }
  }
  
  // Sign out
  Future<void> signOut() async {
    try {
      // Show loading
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      
      // Sign out from Google
      await _googleSignIn.signOut();
      
      // Sign out from Firebase
      await _auth.signOut();
      
      Get.back(); // Close loading dialog
      
      // Show success message
      Get.snackbar(
        'Success',
        'Successfully signed out!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF086F8A),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.back(); // Close loading dialog if open
      
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to sign out: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      
      // Log error for debugging
      if (Get.isLogEnable) {
        print('Sign Out Error: $e');
      }
    }
  }
  
  // Get user display name
  String? get userDisplayName => currentUser?.displayName;
  
  // Get user email
  String? get userEmail => currentUser?.email;
  
  // Get user photo URL
  String? get userPhotoURL => currentUser?.photoURL;
  
  // Get user ID
  String? get userId => currentUser?.uid;
  
  // Get formatted user creation date
  String? get userCreationDate {
    final creationTime = currentUser?.metadata.creationTime;
    if (creationTime == null) return null;
    
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(creationTime);
  }
  
  // Get formatted last sign-in time
  String? get userLastSignInTime {
    final lastSignInTime = currentUser?.metadata.lastSignInTime;
    if (lastSignInTime == null) return null;
    
    final now = DateTime.now();
    final difference = now.difference(lastSignInTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      final formatter = DateFormat('dd MMM yyyy');
      return formatter.format(lastSignInTime);
    }
  }
  
  // Reauthenticate user (useful for sensitive operations)
  Future<bool> reauthenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return false;
      }
      
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await currentUser?.reauthenticateWithCredential(credential);
      return true;
      
    } catch (e) {
      // Log error for debugging
      if (Get.isLogEnable) {
        print('Reauthentication Error: $e');
      }
      return false;
    }
  }
  
  // Sync user data to MongoDB
  Future<void> _syncUserToMongoDB() async {
    try {
      final result = await ApiService.syncFirebaseUser();
      if (result != null) {
        if (Get.isLogEnable) {
          print('User synced to MongoDB: ${result['message']}');
        }
      } else {
        if (Get.isLogEnable) {
          print('Failed to sync user to MongoDB');
        }
      }
    } catch (e) {
      if (Get.isLogEnable) {
        print('Error syncing user to MongoDB: $e');
      }
    }
  }

  // Delete user account
  Future<bool> deleteAccount() async {
    try {
      // Reauthenticate first for security
      final reauthenticated = await reauthenticateWithGoogle();
      
      if (!reauthenticated) {
        Get.snackbar(
          'Error',
          'Reauthentication failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        return false;
      }
      
      // Delete the user account
      await currentUser?.delete();
      
      // Sign out from Google as well
      await _googleSignIn.signOut();
      
      Get.snackbar(
        'Success',
        'Account deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return true;
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete account: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      
      // Log error for debugging
      if (Get.isLogEnable) {
        print('Delete Account Error: $e');
      }
      return false;
    }
  }
}