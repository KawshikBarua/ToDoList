import 'package:flutter/material.dart';
import 'package:list_app/constant/const.dart';

class Button extends StatelessWidget {
  final double height;
  final double width;
  final IconData icon;
  final dynamic onClick;
  const Button(
      {Key? key,
      required this.height,
      required this.width,
      required this.icon,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialButton(
        splashColor: orange,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: onClick,
        hoverColor: transparant,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(color: grey.shade300, width: 3),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Icon(icon),
          ),
        ),
      );
}
