// @dart=2.9
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_dialogflow/pages/splash_view.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_and_dialogflow/models_providers/theme_provider.dart';
import 'package:flutter_and_dialogflow/pages/theme_prefence.dart';

class ChatBot extends StatefulWidget {
  ChatBot({Key key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final themePreference =
      MaterialPageRoute(builder: (context) => ThemePreference());
  final splashPage = MaterialPageRoute(builder: (context) => SplashView());
  final messageController = TextEditingController();
  List<Map> messages = [];

  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/dialogflow/materias-ghuf-dc7aa8b181dc.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "messages": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                    top: height * 0.02,
                    bottom: height * 0.01,
                  ),
                  child: Text(
                    "Today, ${DateFormat("Hm").format(DateTime.now())}",
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                ),
              ),
              Flexible(
                  child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => chat(
                          messages[index]["message"].toString(),
                          messages[index]["data"]))),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 5.0,
                color: Colors.purple,
              ),
              Container(
                child: ListTile(
                  title: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.05),
                      ),
                      color: themeProvider.isLightTheme
                          ? Colors.black12
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: themeProvider.isLightTheme
                              ? Colors.black12
                              : Colors.grey,
                          offset: Offset(0, 5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter a message',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: themeProvider.isLightTheme
                          ? Colors.red
                          : Colors.purple,
                    ),
                    onPressed: () {
                      if (messageController.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          messages.insert(
                            0,
                            {"data": 1, "message": messageController.text},
                          );
                        });
                        response(messageController.text);
                        messageController.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.04,
                ),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.push(context, themePreference),
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
                      children: [
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
                      onPressed: () => Navigator.push(context, splashPage),
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

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0
                    ? Color.fromRGBO(23, 157, 139, 1)
                    : Colors.orangeAccent,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
