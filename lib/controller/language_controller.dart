import 'package:get/get.dart';

class LanguageController extends GetxController {
  var isDropdownOpen = false.obs;
  var selectedLanguage = "Language".obs;

  final List<String> languages = [
    "English",
    "Arabic",
    "French",
    "Chinese",
    "Urdu",
  ];

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectLanguage(String language) {
    selectedLanguage.value = language;
    isDropdownOpen.value = false;
  }
}
