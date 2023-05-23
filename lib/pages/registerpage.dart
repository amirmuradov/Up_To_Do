import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todlist/pages/loginpage.dart';
import 'package:todlist/pages/intropage1.dart';
import 'package:todlist/pages/loginpage1.dart';
import 'ontapscaleandfade.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _obscuretext = true;
  bool _obscureText2 = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  // used to check
  /*void registerNewUser() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference users = database.ref("users");
    await users.child("user1").set({"name": "Amir", "password": "1234"});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Column(
              children: <Widget>[
                Stack(
                  children: [
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
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            bottom: 30,
                            top: 70,
                          ),
                          child: Text(
                            "Register",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            "Username",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            style: GoogleFonts.lato(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter a Username";
                              } else if (value.length < 8) {
                                return "Username must be atleast 8 characters long";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your Username",
                              hintStyle: GoogleFonts.lato(
                                color: const Color(0x57FFFFFF),
                                fontSize: 17,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x641D1D1D),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x64979797),
                                ),
                              ),
                              fillColor: const Color(0x64535353),
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            "Password",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _form,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscuretext,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter a Password";
                                } else if (value.length < 6) {
                                  return "Password must be atleast 6 characters long";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  child: Icon(
                                    _obscuretext
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0x57FFFFFF),
                                    size: 30,
                                  ),
                                ),
                                hintText: "Enter your Password",
                                hintStyle: GoogleFonts.lato(
                                    color: const Color(0x57FFFFFF),
                                    fontSize: 17),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x641D1D1D),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x64979797),
                                  ),
                                ),
                                fillColor: const Color(0x64535353),
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            "Confirm Password",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: form,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureText2,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a Password";
                                }
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  return "Password do not much";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0x57FFFFFF),
                                    size: 30,
                                  ),
                                ),
                                hintText: "Confirm your password",
                                hintStyle: GoogleFonts.lato(
                                    color: const Color(0x57FFFFFF),
                                    fontSize: 17),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x641D1D1D),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x64979797),
                                  ),
                                ),
                                fillColor: const Color(0x64535353),
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        OnTapScaleAndFade(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: ((context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    backgroundColor: Colors.grey.shade900,
                                    child: Container(
                                      height: 170,
                                      width: 500,
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Unfortunately, this function is temporarily unavailable, sorry for the problems, it will be available a little later.",
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            style: TextButton.styleFrom(
                                              fixedSize: const Size(290, 45),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 89, 92, 255),
                                            ),
                                            child: Text(
                                              "OK",
                                              style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          },
                          child: Container(
                            height: 55,
                            width: 400,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 135, 117, 255),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "REGISTER",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                indent: 15,
                                color: Color(0x64979797),
                              ),
                            ),
                            Text(
                              "Or continue with",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0x64979797),
                                endIndent: 15,
                              ),
                            ),
                          ],
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
                                  return const IntroPages();
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 55,
                            width: 400,
                            padding: const EdgeInsets.all(13),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 135, 117, 255),
                                  width: 2.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/google.svg"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Register with Google",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OnTapScaleAndFade(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: ((context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      backgroundColor: Colors.grey.shade900,
                                      child: Container(
                                        height: 170,
                                        width: 500,
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Text(
                                              "The application is currently in test mode, unfortunately this function is temporarily not working, we apologize for temporary problems.",
                                              style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              style: TextButton.styleFrom(
                                                fixedSize: const Size(290, 45),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 89, 92, 255),
                                              ),
                                              child: Text(
                                                "OK",
                                                style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )));
                          },
                          child: Container(
                            height: 55,
                            width: 400,
                            padding: const EdgeInsets.all(13),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color.fromARGB(255, 135, 117, 255),
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/apple.svg",
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Register with Apple",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return const LoginUI();
                                    }),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.lato(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
