import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todlist/pages/loginpage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPages extends StatefulWidget {
  const IntroPages({Key? key}) : super(key: key);

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  PageController pageController = PageController();
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seenOnboarding') ?? false);

    if (_seen) {
      // Если Onboarding экран уже был показан ранее, переходим на другой экран (например, LoginPage).
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      // Если Onboarding экран не был показан ранее, устанавливаем флаг 'seenOnboarding' и продолжаем отображение Onboarding экрана.
      await prefs.setBool('seenOnboarding', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                activePage = value;
              });
            },
            children: [
              buildPage(
                assetName: 'assets/Group1.svg',
                title: 'Manage your tasks',
                description:
                    'You can easily manage all of your daily tasks in UpToDo for free',
              ),
              buildPage(
                assetName: 'assets/Frame2.svg',
                title: 'Create daily routine',
                description:
                    'In UpToDo you can create your personalized routine to stay productive.',
              ),
              buildPage(
                assetName: 'assets/Frame3.svg',
                title: 'Organize your tasks',
                description:
                    'You can organize your daily tasks by adding your tasks into separate categories.',
              ),
            ],
          ),
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activePage,
              count: 3,
              effect: const WormEffect(
                activeDotColor: Colors.white,
                dotColor: Color(0x64AFAFAF),
                dotHeight: 6,
                dotWidth: 42,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: CupertinoButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                onPressed: () {
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.ease,
                  );
                },
                child: Text(
                  "SKIP",
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: SafeArea(
                child: CupertinoButton(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Text(
                    "BACK",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 60,
                  child: CupertinoButton(
                    onPressed: () {
                      if (activePage == 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return const LoginPage();
                            }),
                          ),
                        );
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    color: const Color.fromARGB(255, 135, 117, 255),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      activePage == 2 ? "GET STARTED" : "NEXT",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String assetName,
    required String title,
    required String description,
  }) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetName,
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 150),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
