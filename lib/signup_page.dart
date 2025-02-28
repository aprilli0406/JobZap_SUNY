import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController(); 
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  
/*
  Future<void> sendEmail(String userEmail) async {
    final String apiUrl = "https://email-api.example.com/send"; // Replace with your AWS Lambda API Gateway URL

      Map<String, dynamic> emailData = {
        "email": userEmail,
        "subject": "Welcome to Our App!",
        "message": "Hello, you have successfully signed up! 🎉\n\nThank you for joining us."
      };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(emailData),
      );

      if (response.statusCode == 200) {
        print("✅ Email sent successfully to $userEmail");
      } else {
        print("❌ Failed to send email: ${response.body}");
      }
    } catch (error) {
      print("❌ Error sending email: $error");
    }
}

*/

  Future<void> signUpUser() async {
  final String apiUrl = "https://1wi36szbei.execute-api.us-east-1.amazonaws.com/prod/signup";
 // ✅ Check if passwords match before making API request
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Passwords do not match!")),
      );
      return;
    }  
    Map<String, dynamic> userData = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        // 🎯 Send confirmation email
//        await sendEmail(userData["email"]);

        // 🎯 Navigate back to login page

        // 🎯 Show Alert Dialog on Success
        

        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Successfully signed up! Go to login."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close alert
                      Navigator.pop(context); // Go back to login page
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        });

        
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed: ${response.body}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
}


@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700, // ✅ Matches your screenshot background
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ White background container
                    borderRadius: BorderRadius.circular(20), // ✅ Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // First Name Field
                      Text("First Name"),
                      SizedBox(height: 5),
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Last Name Field
                      Text("Last Name"),
                      SizedBox(height: 5),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Email Field
                      Text("Email"),
                      SizedBox(height: 5),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Password Field
                      Text("Password"),
                      SizedBox(height: 5),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 12),

                      // Confirm Password Field
                      Text("Confirm Password"),
                      SizedBox(height: 5),
                      TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => signUpUser(),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Sign Up"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}