part of 'utl.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool isDarkMode = false;

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    isDarkMode = mode == ThemeMode.dark ? true : false;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    notifyListeners();
  }
}
