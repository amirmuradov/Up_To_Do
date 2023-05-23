import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todlist/controllers/taskccontroller.dart';
import 'package:todlist/database/database.dart';
import 'package:todlist/themes/theme.dart';
import '../services/notification_service.dart';
import '../widgets/task_tile.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

DateTime _selectedDate = DateTime.now();
final _taskController = Get.put(TaskController());

class _IndexState extends State<Index> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    setState(() {
      print("I am here");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build method called");
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          if (_taskController.taskList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: SvgPicture.asset(
                    'assets/mainscaffoldphoto.svg',
                    height: 280,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 75,
                  ),
                  child: Text(
                    "What do you want to do today? tap + to add your task",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            );
          }
          return ListView.builder(
              itemCount: _taskController.taskList.length,
              itemBuilder: (_, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context, _taskController.taskList[index]);
                            },
                            child: TaskTile(
                              _taskController.taskList[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

_showBottomSheet(BuildContext context, Task task) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Colors.black,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              _taskController.delete(task);
              Get.back();
            },
            clr: primaryClr,
            context: context,
          ),
          const SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            clr: primaryClr,
            isClose: true,
            context: context,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}

_bottomSheetButton(
    {required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose == true ? Colors.red : clr,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClose == true ? Colors.transparent : clr,
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.lato(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
