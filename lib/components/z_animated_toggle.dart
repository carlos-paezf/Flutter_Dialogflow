// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_and_dialogflow/models_providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ZAnimatedToggle extends StatefulWidget {
  final List<String> value;
  final ValueChanged onToggleCallback;
  ZAnimatedToggle({Key key, this.value, this.onToggleCallback})
      : super(key: key);

  @override
  _ZAnimatedToggleState createState() => _ZAnimatedToggleState();
}

class _ZAnimatedToggleState extends State<ZAnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      width: width * 0.7,
      height: width * 0.15,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => widget.onToggleCallback(1),
            child: Container(
              alignment: Alignment.center,
              width: width * 0.7,
              height: width * 0.3,
              decoration: ShapeDecoration(
                color: themeProvider.themeMode().toogleBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.value.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: width * 0.05,
                    ),
                    child: Text(
                      widget.value[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            alignment: themeProvider.isLightTheme
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease,
            child: Container(
              alignment: Alignment.center,
              width: width * 0.35,
              height: width * 0.5,
              decoration: ShapeDecoration(
                color: themeProvider.themeMode().toogleButtonColor,
                shadows: themeProvider.themeMode().shadow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.5)),
              ),
              child: Text(
                themeProvider.isLightTheme ? widget.value[0] : widget.value[1],
                style: TextStyle(fontSize: width * 0.05),
              ),
            ),
          )
        ],
      ),
    );
  }
}
