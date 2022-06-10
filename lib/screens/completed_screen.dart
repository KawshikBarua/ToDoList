import 'package:flutter/material.dart';
import 'package:list_app/constant/const.dart';
import 'package:list_app/shared%20preference/shared_preference.dart';
import 'package:list_app/utils/vertical_space.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  late List<String> _compTask;

  @override
  void initState() {
    _compTask = DataStore.getCompData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData textTheme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Text(
                "Completed Tasks",
                style: textTheme.textTheme.headline1?.copyWith(color: darkBlue),
              ),
            ),
            const VerticalSpace(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: _compTask.isEmpty
                    ? const Text("No Data To Show Yet")
                    : ListView.builder(
                        itemCount: _compTask.length,
                        itemBuilder: (context, index) {
                          return Text(_compTask[index]);
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
