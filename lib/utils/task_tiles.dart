import 'package:flutter/material.dart';
import 'package:list_app/constant/const.dart';

class TaskTiles extends StatelessWidget {
  final double height, width;
  final String text;
  final VoidCallback onPressed;
  final Animation<double> animation;
  const TaskTiles(
      {Key? key,
      required this.height,
      required this.width,
      required this.text,
      required this.animation,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ListTile(
          contentPadding: const EdgeInsets.all(7),
          title: Text(
            text,
            style: const TextStyle(
                color: darkBlue, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: orange,
          trailing: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.delete,
                color: darkBlue,
              )),
        ),
      ),
    );
  }
}
