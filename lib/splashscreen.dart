import 'package:echo_note/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  void pusher(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => pusher(context));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 179, 16),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset("assets/images/news.json",width: 150,height: 150,fit: BoxFit.cover)),
          RichText(
          text: TextSpan(
            text: "Echo",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: Colors.white),
            children: <TextSpan>[
              TextSpan(
                text: " Note",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}
