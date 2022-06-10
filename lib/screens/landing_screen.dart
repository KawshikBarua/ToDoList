import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_app/constant/const.dart';
import 'package:list_app/screens/completed_screen.dart';
import 'package:list_app/screens/remaining_screen.dart';
import 'package:list_app/shared%20preference/shared_preference.dart';
import 'package:list_app/utils/button.dart';
import 'package:list_app/utils/task_add_dialog.dart';
import 'package:list_app/utils/task_container.dart';
import 'package:list_app/utils/task_tiles.dart';
import 'package:list_app/utils/vertical_space.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<String> allTasks = [];
  final _animatedKey = GlobalKey<AnimatedListState>();

  String dateTime() {
    var today = DateTime.now();
    String date = DateFormat.d().format(today);
    String month = DateFormat.MMM().format(today);
    String time = DateFormat.Hm().format(today);
    return date + " " + month + " " + time;
  }

  @override
  void initState() {
    allTasks = DataStore.getTasks();
    super.initState();
  }

  void whenDeletePressed(int index, Size size) {
    DataStore.deleteTask(index);
    _animatedKey.currentState!.removeItem(
        index,
        (context, animation) => TaskTiles(
              height: 70,
              width: size.width * 0.9,
              text: allTasks[index],
              animation: animation,
              onPressed: () {},
            ));
  }

  void whenSubmitPressed() {
    _animatedKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData textTheme = Theme.of(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        backgroundColor: accentLight,
        elevation: 4,
        child: Container(),
      ),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  height: 50,
                  width: 50,
                  icon: Icons.apps_rounded,
                  onClick: () {},
                ),
                StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Text(
                        dateTime(),
                        style: textTheme.textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.bold),
                      );
                    }),
                Button(
                  height: 50,
                  width: 50,
                  icon: Icons.add,
                  onClick: () {
                    TaskDialog(context: context).taskDialog().then((value) {
                      if (value) {
                        setState(() {
                          allTasks = DataStore.getTasks();
                        });
                        whenSubmitPressed();
                      }
                    });
                  },
                )
              ],
            ),
            const VerticalSpace(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              child: Text(
                "Daily Task",
                style: textTheme.textTheme.headline1?.copyWith(color: darkBlue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Text(
                "${allTasks.length} tasks remaining",
                style: textTheme.textTheme.subtitle2
                    ?.copyWith(fontWeight: FontWeight.bold, color: grey),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  TaskContainer(
                    height: 210,
                    width: 200,
                    color: orange,
                    image: 'assets/images/remaining_task_img.png',
                    text: "Remaining Tasks",
                    task: DataStore.getTasks(),
                    navigate: RemainingTask(
                      allTasks: allTasks,
                    ),
                  ),
                  TaskContainer(
                    height: 210,
                    width: 200,
                    color: teal,
                    image: 'assets/images/completed_task_img.png',
                    text: "Completed Tasks",
                    task: DataStore.getCompData(),
                    navigate: const CompletedTask(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pending",
                    style: textTheme.textTheme.headline1
                        ?.copyWith(color: darkBlue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: allTasks.isEmpty
                    ? const Text("No Data To Show Yet")
                    : AnimatedList(
                        key: _animatedKey,
                        initialItemCount: allTasks.length,
                        itemBuilder: (context, index, animation) {
                          return TaskTiles(
                            height: 70,
                            width: size.width,
                            text: allTasks[index],
                            animation: animation,
                            onPressed: () {
                              whenDeletePressed(index, size);
                              setState(() {
                                allTasks = DataStore.getTasks();
                              });
                            },
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
