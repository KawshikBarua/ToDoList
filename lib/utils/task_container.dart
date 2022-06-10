import 'package:flutter/material.dart';
import 'package:list_app/constant/const.dart';
import 'package:list_app/utils/vertical_space.dart';

class TaskContainer extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  final String image;
  final String text;
  final dynamic navigate;
  final List<String> task;
  const TaskContainer(
      {Key? key,
      required this.height,
      required this.width,
      required this.color,
      required this.image,
      required this.text,
      required this.task,
      required this.navigate})
      : super(key: key);

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isClicked = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isClicked = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.navigate));
      },
      onTapCancel: () {
        setState(() {
          _isClicked = false;
        });
      },
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1000),
        height: _isClicked ? widget.height - 20 : widget.height,
        width: _isClicked ? widget.width - 10 : widget.width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(2.0, 3.0))
            ],
            borderRadius: BorderRadius.circular(35),
            gradient: LinearGradient(
                colors: [accentLight, widget.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(widget.image),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        widget.text,
                        style: themeData.textTheme.headline5
                            ?.copyWith(color: Colors.white),
                      ),
                      const VerticalSpace(height: 10),
                      Text(
                        "${widget.task.length} total tasks",
                        style: themeData.textTheme.bodyText2
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                      color: accentLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Check",
                      style: themeData.textTheme.subtitle1?.copyWith(
                        color: widget.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
