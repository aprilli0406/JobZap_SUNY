import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // Ensures the navigation happens AFTER the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content to extend behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Makes the AppBar transparent
      ),
      backgroundColor: const Color.fromARGB(255, 95, 235, 147), // Background color of the screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'JobZap',
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
