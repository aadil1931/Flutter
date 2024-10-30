import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState(); // Generic type added
}

class _MyAppState extends State<MyApp> {
  List<dynamic>? users; // Store the list of users

  Future<void> loadJsonAsset() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/JsonFile.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      setState(() {
        users = data['users']; // Extract the 'users' list
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadJsonAsset();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Loading Data'),
        ),
        body: Center(
          child: users != null
              ? ListView.builder(
            itemCount: users!.length,
            itemBuilder: (context, index) {
              final user = users![index];
              return ListTile(
                title: Text(user['name'] ?? 'Name not available'),
                subtitle: Text(user['email'] ?? 'Email not available'),
              );
            },
          )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
