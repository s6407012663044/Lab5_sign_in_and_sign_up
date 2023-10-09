import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/components/my_button.dart';
import 'package:onboarding_screen/components/my_textbutton.dart';
import 'package:onboarding_screen/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();

  final dateController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final re_passwordController = TextEditingController();

  void _showMyDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: const Text('AlertDialog Title'),
            content: Text(txtMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _showMyDialog('Register Success');
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);

      if (e.code == 'invalid-email') {
        _showMyDialog('No user found for that email.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        _showMyDialog('Wrong password provided for that user.');
      }
    }
  }

  void signUpUser() async {
    if (emailController.text != "" &&
        passwordController.text != "" &&
        emailController.text != "" &&
        passwordController.text == re_passwordController.text) {
      print('It s ok');
    } else {
      print('Please input your email and password.');
    }
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );

    if (_picked != null) {
      setState(() {
        dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Form(
            child: Column(
              children: [
                // const Spacer(),

                Text(
                  "Please register your account.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Please Enter your Information.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displaySmall,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: nameController,
                  hintText: 'Please input your name',
                  obscureText: false,
                  labelText: 'name',
                ),

                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: dateController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'Enter your date birth',
                      filled: true,
                      prefixIcon: Icon(Icons.date_range_sharp),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                        gapPadding: 10,
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: 'Please input your email',
                  obscureText: false,
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: re_passwordController,
                  hintText: 'Please Enter your password',
                  obscureText: true,
                  labelText: 'Confirm password',
                ),
                const SizedBox(height: 30),
                MyButton(
                    onTap: createUserWithEmailAndPassword, hinText: 'Sign up'),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have a member?',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.displayMedium,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const MyTextButton(
                        labelText: 'Login now',
                        pageRoute: 'login',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
