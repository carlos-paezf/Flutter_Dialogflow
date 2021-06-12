// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_and_dialogflow/models_providers/theme_provider.dart';
import 'package:flutter_and_dialogflow/pages/chatbot.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashView extends StatefulWidget {
  SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final chatBot = MaterialPageRoute(builder: (context) => ChatBot());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //* Now we have access to the theme properties
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: width * 0.7,
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
                'Universidad Santo Tomás',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.08),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Seccional Tunja, Deep Learning',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.05),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Carlos David Páez Ferreira',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.05),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'https://github.com/carlos-paezf/Flutter_Dialogflow',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.05),
              ),
              Linkify(
                text: 'https://github.com/carlos-paezf/Flutter_Dialogflow',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.05),
                onOpen: _onOpen,
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
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.push(context, chatBot),
                        color: themeProvider.isLightTheme
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF35303f),
                        icon: Icon(
                          Icons.arrow_back,
                          color: themeProvider.isLightTheme
                              ? const Color(0xFF000000)
                              : const Color(0xFFFFFFFF),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                          buildDot(
                            width: width * 0.1,
                            height: width * 0.022,
                            color: themeProvider.isLightTheme
                                ? Colors.black
                                : Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(),
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

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
