import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      final result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('✅ Sign-in successful: $result');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-in successful!")),
      );
      // Navigate to Home Screen after Login
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      print('❌ Error signing in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-in failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: signIn, child: Text("Log In")),
          ],
        ),
      ),
    );
  }
}
