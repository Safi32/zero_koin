import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdMobController extends GetxController {
  // Home screen banner ad
  BannerAd? _homeBannerAd;
  final RxBool _isHomeBannerAdReady = false.obs;
  final RxBool _isHomeAdLoading = false.obs;

  // Learn & Earn screen banner ad
  BannerAd? _learnEarnBannerAd;
  final RxBool _isLearnEarnBannerAdReady = false.obs;
  final RxBool _isLearnEarnAdLoading = false.obs;

  // Ad Unit IDs - using the provided unit IDs
  static const String _homeBannerAdUnitId = 'ca-app-pub-4772862931194867/5154609350';
  static const String _learnEarnBannerAdUnitId = 'ca-app-pub-4772862931194867/5356939275';

  // Home screen ad getters
  bool get isHomeBannerAdReady => _isHomeBannerAdReady.value;
  bool get isHomeAdLoading => _isHomeAdLoading.value;
  BannerAd? get homeBannerAd => _homeBannerAd;

  // Learn & Earn screen ad getters
  bool get isLearnEarnBannerAdReady => _isLearnEarnBannerAdReady.value;
  bool get isLearnEarnAdLoading => _isLearnEarnAdLoading.value;
  BannerAd? get learnEarnBannerAd => _learnEarnBannerAd;

  // Legacy getters for backward compatibility (home screen)
  bool get isBannerAdReady => _isHomeBannerAdReady.value;
  bool get isAdLoading => _isHomeAdLoading.value;
  BannerAd? get bannerAd => _homeBannerAd;

  @override
  void onInit() {
    super.onInit();
    _initializeAds();
  }

  Future<void> _initializeAds() async {
    // Initialize the Mobile Ads SDK
    await MobileAds.instance.initialize();
    _loadHomeBannerAd();
    _loadLearnEarnBannerAd();
  }

  void _loadHomeBannerAd() {
    _isHomeAdLoading.value = true;

    _homeBannerAd = BannerAd(
      adUnitId: _homeBannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('Home banner ad loaded successfully');
          }
          _isHomeBannerAdReady.value = true;
          _isHomeAdLoading.value = false;
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('Home banner ad failed to load: $error');
          }
          _isHomeBannerAdReady.value = false;
          _isHomeAdLoading.value = false;
          ad.dispose();
          _homeBannerAd = null;

          // Retry loading after a delay
          Future.delayed(const Duration(seconds: 5), () {
            if (!_isHomeBannerAdReady.value) {
              _loadHomeBannerAd();
            }
          });
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            print('Home banner ad opened');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            print('Home banner ad closed');
          }
        },
        onAdImpression: (ad) {
          if (kDebugMode) {
            print('Home banner ad impression recorded');
          }
        },
      ),
    );

    _homeBannerAd!.load();
  }

  void _loadLearnEarnBannerAd() {
    _isLearnEarnAdLoading.value = true;

    _learnEarnBannerAd = BannerAd(
      adUnitId: _learnEarnBannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('Learn & Earn banner ad loaded successfully');
          }
          _isLearnEarnBannerAdReady.value = true;
          _isLearnEarnAdLoading.value = false;
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('Learn & Earn banner ad failed to load: $error');
          }
          _isLearnEarnBannerAdReady.value = false;
          _isLearnEarnAdLoading.value = false;
          ad.dispose();
          _learnEarnBannerAd = null;

          // Retry loading after a delay
          Future.delayed(const Duration(seconds: 5), () {
            if (!_isLearnEarnBannerAdReady.value) {
              _loadLearnEarnBannerAd();
            }
          });
        },
        onAdOpened: (ad) {
          if (kDebugMode) {
            print('Learn & Earn banner ad opened');
          }
        },
        onAdClosed: (ad) {
          if (kDebugMode) {
            print('Learn & Earn banner ad closed');
          }
        },
        onAdImpression: (ad) {
          if (kDebugMode) {
            print('Learn & Earn banner ad impression recorded');
          }
        },
      ),
    );

    _learnEarnBannerAd!.load();
  }

  void reloadHomeBannerAd() {
    if (_homeBannerAd != null) {
      _homeBannerAd!.dispose();
      _homeBannerAd = null;
    }
    _isHomeBannerAdReady.value = false;
    _loadHomeBannerAd();
  }

  void reloadLearnEarnBannerAd() {
    if (_learnEarnBannerAd != null) {
      _learnEarnBannerAd!.dispose();
      _learnEarnBannerAd = null;
    }
    _isLearnEarnBannerAdReady.value = false;
    _loadLearnEarnBannerAd();
  }

  // Legacy method for backward compatibility (home screen)
  void reloadBannerAd() {
    reloadHomeBannerAd();
  }

  @override
  void onClose() {
    _homeBannerAd?.dispose();
    _learnEarnBannerAd?.dispose();
    super.onClose();
  }
}
