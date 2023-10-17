import 'package:flutter/material.dart';
import 'package:lekbeshimuneservices/widgets/appbar.dart';

class MyBubbles extends StatefulWidget {
  const MyBubbles({super.key});

  @override
  State<MyBubbles> createState() => _MyBubblesState();
}

class _MyBubblesState extends State<MyBubbles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble,
              size: 50,
              color: Colors.blueAccent,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Share your thoughts on bubble',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            )
          ],
        ),
      )),
    );
  }
}
