import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zero_koin/view/guide_screen.dart';
import 'package:zero_koin/view/bottom_bar.dart';

import 'package:zero_koin/widgets/app_bar_container.dart';
import 'package:zero_koin/widgets/my_drawer.dart';
import 'package:zero_koin/widgets/pop_up_button.dart';
import 'package:zero_koin/widgets/wallet_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zero_koin/widgets/wallet_web3_popup.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_koin/controllers/user_controller.dart';
import 'package:zero_koin/widgets/gradient_circular_progress_painter.dart';

// Mock class for demonstration purposes
class MockSessionStatus {
  final List<String> accounts;
  final int chainId;

  MockSessionStatus({required this.accounts, required this.chainId});
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with WidgetsBindingObserver {
  // Wallet connection variables
  late WalletConnect connector;
  dynamic _session; // Can be SessionStatus or MockSessionStatus
  bool _isConnecting = false;
  bool _waitingForWalletReturn = false;
  String _currentWalletType = ''; // Track which wallet is being connected
  final TextEditingController _walletAddressController = TextEditingController();

  // User controller for persistent storage
  final UserController _userController = UserController.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeWalletConnect();
    _loadExistingWalletAddresses();
  }

  void _loadExistingWalletAddresses() {
    // Load existing wallet addresses from user data
    final metamaskAddr = _userController.getWalletAddress('metamask');
    final trustWalletAddr = _userController.getWalletAddress('trustWallet');

    // If we have a saved address, show it in the input field
    if (metamaskAddr.isNotEmpty) {
      _walletAddressController.text = metamaskAddr;
      _session = _createMockSession();
      _currentWalletType = 'metamask';
    } else if (trustWalletAddr.isNotEmpty) {
      _walletAddressController.text = trustWalletAddr;
      _session = _createMockSession();
      _currentWalletType = 'trustWallet';
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _walletAddressController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Handle when user returns to the app from MetaMask
    if (state == AppLifecycleState.resumed && _waitingForWalletReturn) {
      _handleWalletReturn();
    }
  }

  void _initializeWalletConnect() {
    // Note: WalletConnect v1 has been deprecated. This is a placeholder for future WalletConnect v2 implementation
    // For now, we'll implement a mock connection flow to demonstrate the UI
    try {
      connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          name: 'ZeroKoin',
          description: 'ZeroKoin Wallet Integration',
          url: 'https://zerokoin.com',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      );

      // Subscribe to connection events
      connector.on('connect', (session) {
        if (session is SessionStatus) {
          setState(() {
            _session = session;
            _isConnecting = false;
            if (session.accounts.isNotEmpty) {
              _walletAddressController.text = session.accounts[0];
            }
          });
        }
      });

      connector.on('session_update', (payload) {
        if (payload is SessionStatus) {
          setState(() {
            _session = payload;
            if (payload.accounts.isNotEmpty) {
              _walletAddressController.text = payload.accounts[0];
            }
          });
        }
      });

      connector.on('disconnect', (payload) {
        setState(() {
          _session = null;
          _walletAddressController.clear();
          _isConnecting = false;
        });
      });
    } catch (e) {
      // Handle WalletConnect initialization error gracefully
      print('WalletConnect initialization failed: $e');
    }
  }

  Future<void> _connectWallet(String walletType) async {
    setState(() {
      _isConnecting = true;
      _currentWalletType = walletType;
    });

    try {
      // First try to create a WalletConnect session to get the real wallet address
      if (!connector.connected) {
        try {
          var session = await connector.createSession(
            onDisplayUri: (uri) async {
              // Launch the appropriate wallet with the WalletConnect URI
              String walletUri;
              String walletName;

              if (walletType == 'metamask') {
                walletUri = 'metamask://wc?uri=${Uri.encodeComponent(uri)}';
                walletName = 'MetaMask';
              } else if (walletType == 'trustwallet') {
                walletUri = 'trust://wc?uri=${Uri.encodeComponent(uri)}';
                walletName = 'Trust Wallet';
              } else {
                throw Exception('Unsupported wallet type');
              }

              bool canLaunch = await launchUrl(
                Uri.parse(walletUri),
                mode: LaunchMode.externalApplication,
              );

              if (!canLaunch) {
                // Fallback to generic wallet launch
                String fallbackUri = walletType == 'metamask' ? 'metamask://' : 'trust://';
                await launchUrl(
                  Uri.parse(fallbackUri),
                  mode: LaunchMode.externalApplication,
                );
              }

              // Set flag to indicate we're waiting for wallet return
              setState(() {
                _waitingForWalletReturn = true;
              });

              // Show user that wallet is opening
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening $walletName... Please approve the connection and return to the app'),
                    backgroundColor: Colors.blue,
                    duration: Duration(seconds: 4),
                  ),
                );
              }
            },
          );

          // If we get here, the connection was successful
          setState(() {
            _session = session;
            _isConnecting = false;
            _waitingForWalletReturn = false;
            if (session.accounts.isNotEmpty) {
              _walletAddressController.text = session.accounts[0];
            }
          });

          if (mounted) {
            String walletName = walletType == 'metamask' ? 'MetaMask' : 'Trust Wallet';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$walletName connected successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }

        } catch (walletConnectError) {
          // If WalletConnect fails, fall back to simple wallet launch
          // This is expected since WalletConnect v1 is deprecated
          await _fallbackWalletConnection(walletType);
        }
      }
    } catch (exp) {
      setState(() {
        _isConnecting = false;
        _waitingForWalletReturn = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to connect: $exp'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _fallbackWalletConnection(String walletType) async {
    String walletUri = walletType == 'metamask' ? 'metamask://' : 'trust://';
    String walletName = walletType == 'metamask' ? 'MetaMask' : 'Trust Wallet';

    // Launch wallet and wait for user to return
    bool canLaunch = await launchUrl(
      Uri.parse(walletUri),
      mode: LaunchMode.externalApplication,
    );

    if (canLaunch) {
      setState(() {
        _waitingForWalletReturn = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $walletName... Please connect your wallet and return to the app'),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } else {
      throw Exception('$walletName app not found. Please install $walletName.');
    }
  }

  // Legacy method for backward compatibility
  Future<void> _connectMetaMask() async {
    await _connectWallet('metamask');
  }

  // New method for Trust Wallet
  Future<void> _connectTrustWallet() async {
    await _connectWallet('trustwallet');
  }

  Future<void> _handleWalletReturn() async {
    // Reset the waiting flag
    setState(() {
      _waitingForWalletReturn = false;
    });

    // Add a small delay to ensure the app has fully resumed
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if we already have a session from WalletConnect
    if (_session != null && _session is SessionStatus) {
      // Real WalletConnect session - use the actual address
      setState(() {
        _isConnecting = false;
        if (_session.accounts.isNotEmpty) {
          _walletAddressController.text = _session.accounts[0];
        }
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Welcome back! MetaMask connected successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Fallback: Prompt user to enter their wallet address
      await _promptForWalletAddress();
    }
  }

  Future<void> _promptForWalletAddress() async {
    final TextEditingController addressController = TextEditingController();
    String walletName = _currentWalletType == 'metamask' ? 'MetaMask' : 'Trust Wallet';

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1E1E1E),
          title: Text(
            'Enter Your Wallet Address',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please copy your wallet address from $walletName and paste it below:',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: addressController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '0x...',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0682A2)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a wallet address';
                  }
                  if (!value.startsWith('0x') || value.length != 42) {
                    return 'Please enter a valid Ethereum address';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final address = addressController.text.trim();
                if (address.isNotEmpty && address.startsWith('0x') && address.length == 42) {
                  Navigator.of(context).pop(address);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0682A2),
              ),
              child: Text('Connect', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (result != null) {
      // User entered a wallet address - save it to MongoDB
      final success = await _userController.updateWalletAddress(_currentWalletType, result);

      if (success) {
        setState(() {
          _session = _createMockSession();
          _isConnecting = false;
          _walletAddressController.text = result;
        });

        if (mounted) {
          String walletName = _currentWalletType == 'metamask' ? 'MetaMask' : 'Trust Wallet';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$walletName wallet connected and saved successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save wallet address. Please try again.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } else {
      // User cancelled
      setState(() {
        _isConnecting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connection cancelled'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Mock session for demonstration purposes
  dynamic _createMockSession() {
    return MockSessionStatus(
      accounts: ['0x742d35Cc6634C0532925a3b8D4C9db96590c6C87'],
      chainId: 80001, // Mumbai Testnet
    );
  }

  void _disconnectWallet() async {
    try {
      if (connector.connected) {
        connector.killSession();
      }
    } catch (e) {
      // Handle disconnect error gracefully
    }

    // Clear the saved wallet address from MongoDB
    if (_currentWalletType.isNotEmpty) {
      await _userController.updateWalletAddress(_currentWalletType, '');
    }

    setState(() {
      _session = null;
      _walletAddressController.clear();
      _currentWalletType = '';
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallet disconnected and removed'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }







  void _handleWithdraw() {
    final userBalance = _userController.balance.value;

    if (userBalance < 4000) {
      _showBalanceRequirementDialog();
      return;
    }

    // Proceed with withdrawal of full balance
    _showWithdrawalSuccessDialog(userBalance);
  }

  void _showBalanceRequirementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1E1E1E),
          title: Text(
            'Minimum Balance Required',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'You need a minimum balance of 4000 ZeroKoin to withdraw. Your current balance is ${_userController.balance.value} ZeroKoin.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0682A2),
              ),
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showWithdrawalSuccessDialog(int amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: WalletPopup(),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Image.asset(
            'assets/Background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBarContainer(
                  color: Colors.black.withValues(alpha: 0.6),
                  showTotalPosition: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.offAll(() => const BottomBar(initialIndex: 0));
                            },
                            child: Image(
                              image: AssetImage("assets/arrow_back.png"),
                            ),
                          ),
                          SizedBox(width: 40),
                          Text(
                            "Wallet",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ZeroKoin Withdrawal Pool",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(() {
                                          final userBalance = _userController.balance.value;
                                          return SizedBox(
                                            width: screenWidth * 0.6,
                                            height: screenHeight * 0.06,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2,
                                                ),
                                                color: Colors.transparent,
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Image.asset(
                                                      "assets/zerokoingold.png",
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      userBalance.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          final userBalance = _userController.balance.value;
                                          final maxBalance = 4000;
                                          final percentage = userBalance >= maxBalance
                                              ? 100
                                              : (userBalance / maxBalance * 100).round();
                                          final progress = userBalance >= maxBalance
                                              ? 1.0
                                              : userBalance / maxBalance;

                                          return SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                // Background circle
                                                SizedBox(
                                                  width: 60,
                                                  height: 60,
                                                  child: CircularProgressIndicator(
                                                    value: 1.0,
                                                    strokeWidth: 8,
                                                    backgroundColor: Colors.transparent,
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                      Colors.grey.withValues(alpha: 0.3),
                                                    ),
                                                  ),
                                                ),
                                                // Progress circle with gradient effect
                                                SizedBox(
                                                  width: 60,
                                                  height: 60,
                                                  child: CustomPaint(
                                                    painter: GradientCircularProgressPainter(
                                                      progress: progress,
                                                      strokeWidth: 8,
                                                      startColor: Color(0xFF0682A2), // Cyan/Teal
                                                      endColor: Color(0xFFC5C113), // Yellow-Green
                                                      backgroundColor: Colors.grey.withValues(alpha: 0.3),
                                                    ),
                                                  ),
                                                ),
                                                // Percentage text
                                                Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '$percentage%',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "How to Withdraw Zero Coin?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text:
                                                "When the Withdrawal Pool is 100% you can withdraw your full wallet balance. Please connect your Zerokoin (Web 3) wallet ",
                                          ),
                                          WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(() => GuideScreen());
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 4,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/Info Icon.svg",
                                                  colorFilter: ColorFilter.mode(
                                                    Color(0xFF0682A2),
                                                    BlendMode.srcIn,
                                                  ),
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.4,
                                          height: screenHeight * 0.06,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor: Color(
                                                0xFF0682A2,
                                              ),
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: _isConnecting ? null : () {
                                              if (_session != null) {
                                                _disconnectWallet();
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                        sigmaX: 5.0,
                                                        sigmaY: 5.0,
                                                      ),
                                                      child: Dialog(
                                                        backgroundColor: Colors.transparent,
                                                        child: WalletWeb3Popup(
                                                          onMetaMaskConnect: _connectMetaMask,
                                                          onTrustWalletConnect: _connectTrustWallet,
                                                          isConnecting: _isConnecting,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: _isConnecting
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 14,
                                                        height: 14,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                        ),
                                                      ),
                                                      SizedBox(width: 6),
                                                      Flexible(
                                                        child: Text(
                                                          "Connecting...",
                                                          style: TextStyle(fontSize: screenHeight * 0.018),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Text(
                                                    _session != null ? "Disconnect" : "Wallet Web3",
                                                    style: TextStyle(fontSize: screenHeight * 0.018),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.4,
                                          height: screenHeight * 0.06,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Color(0xFF9247FB),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Exchange",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFF4D4D4D),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ZeroKoin Wallet Address",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _walletAddressController,
                                    style: TextStyle(color: Colors.white),
                                    readOnly: _session != null,
                                    decoration: InputDecoration(
                                      hintText: _session != null
                                          ? "Connected wallet address"
                                          : "Enter Zerokoin Wallet Address",
                                      hintStyle: TextStyle(color: Colors.white70),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: _session != null ? Colors.green : Colors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: _session != null ? Colors.green : Colors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      suffixIcon: _session != null
                                          ? Icon(Icons.check_circle, color: Colors.green)
                                          : null,
                                    ),
                                  ),
                                  if (_session != null) ...[
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle, color: Colors.green, size: 16),
                                        SizedBox(width: 5),
                                        Text(
                                          'Wallet Connected',
                                          style: GoogleFonts.roboto(
                                            color: Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: PopUpButton(
                          buttonText: "WithDraw",
                          buttonColor: Color(0xFF0682A2),
                          onPressed: _handleWithdraw,
                          textColor: Colors.white,
                          borderColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
