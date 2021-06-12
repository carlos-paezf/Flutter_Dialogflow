// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_and_dialogflow/components/z_animated_toggle.dart';
import 'package:flutter_and_dialogflow/models_providers/theme_provider.dart';
import 'package:flutter_and_dialogflow/pages/chatbot.dart';
import 'package:provider/provider.dart';

class ThemePreference extends StatefulWidget {
  @override
  _ThemePreferenceState createState() => _ThemePreferenceState();
}

class _ThemePreferenceState extends State<ThemePreference>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final chatbot = MaterialPageRoute(builder: (context) => ChatBot());

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    super.initState();
  }

  // Function to toggle circle animation
  changeThemeMode(bool theme) {
    theme
        ? _animationController.reverse(from: 1.0)
        : _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //* Now we have access to the theme properties
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: width * 0.35,
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: themeProvider.themeMode().gradient,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 0),
                    child: ScaleTransition(
                      scale: _animationController.drive(
                        Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).chain(
                          CurveTween(
                            curve: Curves.decelerate,
                          ),
                        ),
                      ),
                      alignment: Alignment.topRight,
                      child: Container(
                        width: width * 0.3,
                        height: width * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeProvider.isLightTheme
                              ? Colors.transparent
                              : Color(0xFF26242e),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                'Chatbot in Flutter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.1),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Choose a Style',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.08),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Customize your interface. Day or Night',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.05),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              ZAnimatedToggle(
                value: ['Light', 'Dark'],
                onToggleCallback: (v) async {
                  await themeProvider.toogleThemeData();
                  setState(() {});
                  changeThemeMode(themeProvider.isLightTheme);
                },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                    horizontal: width * 0.04,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildDot(
                            width: width * 0.1,
                            height: width * 0.022,
                            color: themeProvider.isLightTheme
                                ? Colors.black
                                : Colors.white,
                          ),
                          buildDot(
                            width: width * 0.022,
                            height: width * 0.022,
                            color: themeProvider.isLightTheme
                                ? Colors.black38
                                : Colors.white38,
                          ),
                          buildDot(
                            width: width * 0.022,
                            height: width * 0.022,
                            color: themeProvider.isLightTheme
                                ? Colors.black38
                                : Colors.white38,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(context, chatbot),
                        color: themeProvider.isLightTheme
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF35303f),
                        icon: Icon(
                          Icons.arrow_forward,
                          color: themeProvider.isLightTheme
                              ? const Color(0xFF000000)
                              : const Color(0xFFFFFFFF),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot({double width, double height, Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
      ),
    );
  }
}
