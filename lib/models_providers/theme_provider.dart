// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider(this.isLightTheme);

  //? The code below is to manage the status bar color when the theme changes
  getCurrentStatusNavigationBarColor() {
    isLightTheme
        ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xFFFFFFFF),
            systemNavigationBarIconBrightness: Brightness.dark,
          ))
        : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFF26242e),
            systemNavigationBarIconBrightness: Brightness.light,
          ));
  }

  //? Use the toogle theme
  toogleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  //? Global theme data we're always check if the light theme is enable
  ThemeData themeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: isLightTheme ? Colors.white : Color(0xFF1E1F28),
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFF26242e),
      scaffoldBackgroundColor:
          isLightTheme ? Color(0xFFFFFFFFF) : Color(0xFF26242e),
    );
  }

  //? Theme mode to display unique propierties not cover in the theme data
  ThemeColor themeMode() {
    return ThemeColor(
        gradient: [
          if (isLightTheme) ...[
            Colors.yellowAccent,
            Colors.yellow,
            Colors.orangeAccent,
            Colors.orange,
            Colors.deepOrange,
            Colors.red,
            Colors.red[700],
            Colors.red[900]
          ],
          if (!isLightTheme) ...[
            Colors.blue[100],
            Colors.blue[300],
            Colors.blue,
            Colors.blue[700],
            Colors.blue[800],
            Colors.blue[900],
            Colors.indigo[900],
            Colors.black87
          ]
        ],
        textColor: isLightTheme ? Color(0xFF000000) : Color(0xFFFFFFFF),
        toogleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
        toogleBackgroundColor:
            isLightTheme ? Color(0xFFe7e7e8) : Color(0xFF222029),
        shadow: [
          if (isLightTheme)
            BoxShadow(
              color: Color(0xFFd8d7da),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          if (!isLightTheme)
            BoxShadow(
              color: Color(0x66000000),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
        ]);
  }
}

//? A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toogleButtonColor;
  Color toogleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    this.gradient,
    this.backgroundColor,
    this.toogleButtonColor,
    this.toogleBackgroundColor,
    this.textColor,
    this.shadow,
  });
}
