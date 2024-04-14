import 'package:flutter/material.dart';
import 'package:salary_predict/views/pred_salary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(
        useMaterial3: false,
      ),
      home: const SalaryPred(),
    );
  }
}
