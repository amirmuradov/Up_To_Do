import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todlist/pages/intropage1.dart';
import 'package:todlist/pages/loginpage1.dart';
import 'package:todlist/pages/ontapscaleandfade.dart';
import 'package:todlist/pages/registerpage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Column(
              children: <Widget>[
                Stack(children: [
                  Positioned(
                    top: 10,
                    left: 15,
                    child: CupertinoButton(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return const IntroPages();
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                          top: 90,
                          bottom: 0,
                        ),
                        child: Text(
                          "Welcome to UpTodo",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Please login to your account or create new account to continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 420,
                      ),
                      OnTapScaleAndFade(
                        onTap: (() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return const LoginUI();
                              }),
                            ),
                          );
                        }),
                        child: Container(
                          height: 50,
                          width: 400,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 135, 117, 255),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "LOGIN",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      OnTapScaleAndFade(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 55,
                          width: 400,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: const Color.fromARGB(255, 135, 117, 255),
                                width: 5.0),
                          ),
                          child: Text(
                            "CREATE ACCOUNT",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
