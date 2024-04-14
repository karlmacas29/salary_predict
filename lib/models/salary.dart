// To parse this JSON data, do
//
//     final salary = salaryFromJson(jsonString);

import 'dart:convert';

Salary salaryFromJson(String str) => Salary.fromJson(json.decode(str));

String salaryToJson(Salary data) => json.encode(data.toJson());

class Salary {
  double prdValue;
  String year;

  Salary({
    required this.prdValue,
    required this.year,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        prdValue: json["prdValue"]?.toDouble(),
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "prdValue": prdValue,
        "year": year,
      };
}
