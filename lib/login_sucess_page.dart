import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/components/stream_note.dart';
import 'package:onboarding_screen/todolist/add_note_screen.dart';
import 'package:onboarding_screen/todolist/todolist.dart';

//import 'main.dart';

class LoginSuccessPage extends StatefulWidget {
  LoginSuccessPage({super.key});

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  final user = FirebaseAuth.instance.currentUser;

  bool show = true;

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    // const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Task Management',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontStyle: FontStyle.normal,
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: const Icon(
              Icons.login,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [
              StreamNote(false),
              const Text(
                'IsDone >_<',
                style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 28, 28, 28)),
              ),  
              StreamNote(true),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
