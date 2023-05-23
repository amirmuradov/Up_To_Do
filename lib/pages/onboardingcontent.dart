import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
// если хотите испоьзуйте это
class OnboardingPage extends StatelessWidget {
  OnboardingPage(
      {super.key,
      required this.title,
      required this.description,
      required this.image});
  String title;
  String description;
  String image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
              child: Image(
                image: AssetImage(image),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: const Color(0x57FFFFFF), fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
