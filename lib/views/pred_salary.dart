import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salary_predict/models/salary.dart';
import 'package:salary_predict/views/about.dart';

class SalaryPred extends StatefulWidget {
  const SalaryPred({super.key});

  @override
  State<SalaryPred> createState() => _SalaryPredState();
}

class _SalaryPredState extends State<SalaryPred> {
  TextEditingController salaryCont = TextEditingController();
  Salary? salary;
  var isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Prediction'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AboutApp()));
              },
              icon: const Icon(Icons.question_mark_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Text('Enter Year of Experience:'),
            TextField(
              controller: salaryCont,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '0'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  submitData();
                },
                child: const Text('Predict Salary')),
            const SizedBox(
              height: 10,
            ),
            const Text('The predicted salary based on year experience:'),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: salary == null
                  ? const Text('No val')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${salary!.year} years = ${salary!.prdValue}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  final client = http.Client();
  //Send Data using Form Request
  Future<void> submitData() async {
    final salaryStr = salaryCont.text;
    final body = {'experience': salaryStr};

    const url = 'http://karlmacas.pythonanywhere.com/salary';

    final uri = Uri.parse(url);
    //this is form instead of json
    try {
      final response = await client.post(uri,
          body: body,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});

      if (response.statusCode == 200) {
        var json = response.body;
        final salaryjson = salaryFromJson(json);
        setState(() {
          salary = salaryjson;
          isLoaded = true;
        });
        showSnackbarMessage('Success ${response.statusCode}');
      } else {
        showSnackbarMessage('Failed Connection ${response.statusCode}');
      }
    } catch (e) {
      showSnackbarMessage('Error: $e');
    }
  }

  void showSnackbarMessage(String message) {
    final snc = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snc);
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
}
