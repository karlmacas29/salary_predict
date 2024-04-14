import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About this app'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Made by Karl R. Macas'),
          SizedBox(
            height: 10,
          ),
          Text(
              'It is use Machine learning prediction from python linear regression.'),
          SizedBox(
            height: 10,
          ),
          Text('Run on Pythonanyware.')
        ],
      ),
    );
  }
}
