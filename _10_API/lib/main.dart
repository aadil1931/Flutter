import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

Future<Course> fetchCourse() async {
  try {
    final response = await http.get(
      Uri.parse('https://dhruvin.pythonanywhere.com/showdata/CA102'),
    );



    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Data!');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

class Course {
  final String coursecode;
  final String coursename;
  final String cincharge;

  const Course({
    required this.coursecode,
    required this.coursename,
    required this.cincharge,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      coursecode: json['coursecode'] as String,
      coursename: json['coursename'] as String,
      cincharge: json['cincharge'] as String,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Course> futureCourse;

  @override
  void initState() {
    super.initState();
    futureCourse = fetchCourse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetching Data',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('W3TechBlog'),
        ),
        body: Center(
          child: FutureBuilder<Course>(
            future: futureCourse,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Text('In-Charge: ${snapshot.data!.cincharge}');
              } else {
                return const Text('No Data Available');
              }
            },
          ),
        ),
      ),
    );
  }
}
