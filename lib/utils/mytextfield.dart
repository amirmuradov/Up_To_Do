import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget widget;
  const MyTextField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.white,
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: widget,
                      hintText: hint,
                      hintStyle: GoogleFonts.lato(
                        color: const Color(0x57FFFFFF),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x64979797),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x641D1D1D),
                        ),
                      ),
                      fillColor: const Color(0x64535353),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
