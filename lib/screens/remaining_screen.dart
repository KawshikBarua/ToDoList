import 'package:flutter/material.dart';
import 'package:list_app/constant/const.dart';
import 'package:list_app/utils/vertical_space.dart';

class RemainingTask extends StatelessWidget {
  final List<String> allTasks;
  const RemainingTask({Key? key, required this.allTasks}) : super(key: key);

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
                "Remaining Tasks",
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
                child: allTasks.isEmpty
                    ? const Text("No Data To Show Yet")
                    : ListView.builder(
                        itemCount: allTasks.length,
                        itemBuilder: (context, index) {
                          return Text(allTasks[index]);
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
