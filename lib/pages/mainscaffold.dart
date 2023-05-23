import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todlist/main/calendar.dart';
import 'package:todlist/main/focuse.dart';
import 'package:todlist/main/index.dart';
import 'package:todlist/main/profile.dart';
import 'package:todlist/services/notification_service.dart';
import 'package:todlist/themes/theme_services.dart';
import 'package:todlist/widgets/category.dart';
import 'package:todlist/controllers/taskccontroller.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  int currentIndex = 0;
  final List<Widget> screens = [
    const Index(),
    const Calendar(),
    const Focuse(),
    const Profile(),
  ];
  final titles = [
    "Index",
    "Calendar",
    "Focuse Mode",
    "Profile",
  ];

  final _taskController = Get.put(TaskController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  bool _isVisible = true;
  double _scrollPosition = 0;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      double currentPosition = _scrollController.position.pixels;
      if (currentPosition > _scrollPosition) {
        _isVisible = false;
      } else {
        _isVisible = true;
      }
      _scrollPosition = currentPosition;
    });
  }

  Widget currentScreen = const Index();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              backgroundColor: Colors.black,
              child: Container(
                height: 130,
                width: 320,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Are you sure you want to leave?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: TextButton.styleFrom(
                            fixedSize: const Size(135, 55),
                            backgroundColor:
                                const Color.fromARGB(255, 89, 92, 255),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          style: TextButton.styleFrom(
                            fixedSize: const Size(135, 55),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 0, 0),
                          ),
                          child: Text(
                            "Exit",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: Center(
            child: Text(
              "Soon!",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  ThemeService().switchTheme();
                  notifyHelper.displayNotification(
                      title: "Theme Changed",
                      body: Get.isDarkMode
                          ? "Unfortunately that doesn't work right now."
                          : "Unfortunately that doesn't work right now.");
                  // notifyHelper.scheduledNotification();
                },
                child: const Icon(
                  Icons.nightlight_round_outlined,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Image.network(user.photoURL!),
              ),
            ),
          ],
          leading: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 5,
                  child: IconButton(
                    iconSize: 23,
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
          ),
          title: Text(titles[currentIndex]),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        floatingActionButton: currentIndex == 0 && _isVisible
            ? SizedBox(
                height: 65,
                width: 65,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        elevation: 5,
                        backgroundColor: const Color.fromARGB(255, 89, 92, 255),
                        onPressed: () async {
                          await Get.to(() => const Category());
                          _taskController.getTasks();
                        },
                        child: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            selectedFontSize: 15,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            backgroundColor: Colors.black,
            onTap: (index) => setState(
              () {
                currentIndex = index;
              },
            ),
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color(0x62FFFFFF),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 25,
                ),
                label: "Index",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                  size: 25,
                ),
                label: "Calendar",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time_filled_outlined,
                  size: 25,
                ),
                label: "Focuse",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
