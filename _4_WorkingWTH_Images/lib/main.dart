import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Working with Images'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https://nuv.ac.in/wp-content/uploads/Website-Logo.png',
                    width: 400,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        size: 50,
                        color: Colors.red,
                      ); // Display an error icon if the image fails to load
                    },
                  ),
                  const SizedBox(height: 20), // Add some spacing
                  const Image(
                    image: AssetImage('assets/VistorLogo.png'),
                    width: 400,
                    height: 200,
                  ),
                  const SizedBox(height: 20), // Add more spacing
                  const Text(
                    'Welcome to NUV',
                    style: TextStyle(fontSize: 50.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
