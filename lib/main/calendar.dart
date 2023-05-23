import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todlist/database/database.dart';
import 'package:intl/intl.dart';
import 'package:todlist/services/notification_service.dart';
import '../controllers/taskccontroller.dart';
import '../themes/theme.dart';
import '../widgets/task_tile.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
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

  /* void _toggleButton() {
    setState(() {
      _isButtonEnabled = true;
      _isButtonEnabled2 = false;
    });
  }

  void _toggleButton2() {
    setState(() {
      _isButtonEnabled = false;
      _isButtonEnabled2 = true;
    });
  }*/
  //bool _isButtonEnabled = true;
  //bool _isButtonEnabled2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _datePicker(),
          _showTasks(),

          /*Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5),
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 378,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          right: 10,
                          bottom: 15,
                          left: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 3500),
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _toggleButton();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    backgroundColor: _isButtonEnabled
                                        ? const Color.fromARGB(255, 0, 140, 255)
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    "Today",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 3500),
                              height: 60,
                              width: 170,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _toggleButton2();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    backgroundColor: _isButtonEnabled2
                                        ? const Color.fromARGB(255, 0, 140, 255)
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    "Completed",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/
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
                    'assets/Calendarphoto.svg',
                    height: 280,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 75,
                  ),
                  child: Text(
                    "Here you can see for which task for what date you planned",
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
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                print(task.toJson());
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                print(myTime);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);
                print("WORKS");
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(
                              task,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _showBottomSheet(context, task),
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _datePicker() {
    return SizedBox(
      height: 74,
      child: DatePicker(
        DateTime.now(),
        width: 72,
        height: 74,
        initialSelectedDate: DateTime.now(),
        selectionColor: const Color.fromARGB(255, 89, 92, 255),
        selectedTextColor: Colors.white,
        deactivatedColor: Colors.white,
        daysCount: 360,
        dateTextStyle: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        monthTextStyle: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
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
}


//bool _isButtonEnabled = true;
//bool _isButtonEnabled2 = false;



