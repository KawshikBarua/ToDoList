import 'package:flutter/material.dart';
import 'package:list_app/constant/const.dart';
import 'package:list_app/shared%20preference/shared_preference.dart';

class TaskDialog {
  final BuildContext context;
  final TextEditingController _textController = TextEditingController();
  TaskDialog({required this.context});

  Future<bool> taskDialog() async {
    ThemeData textTheme = Theme.of(context);
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text("Add New Task"),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Whats your task for today?",
                  style: textTheme.textTheme.bodyText2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _textController,
                    maxLength: 30,
                    decoration:
                        const InputDecoration(hintText: "Enter your task"),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    String task = _textController.text;
                    DataStore.addData(task, context);
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: darkOrange),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: accentDark),
                  )),
            ],
          );
        });
  }
}
