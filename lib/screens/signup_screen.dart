import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:my_project/screens/home_screen.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_project/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart'; // Import dart:convert for JSON handling

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String apiUrl =
      "https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/users/create";
  bool isLoading = false;

// Function to sign up a new user
  Future<void> signUpUser(
      BuildContext context, String name, String email, String password) async {
    // API URL for creating a new user
    final String apiUrl =
        "https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/users/create";

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "password": password
    };

    try {
      setState(() {
        isLoading = true;
      });

      // Make the HTTP POST request
      final response = await post(
        Uri.parse(apiUrl),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody), // Encode the request body to JSON
      );

      // Check the status of the request
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Successful request, parse and print the response body
        print("Sign-up successful: ${response.body}");

        // Decode the response if necessary
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data); // Handle the response data as needed
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => ProfileScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.reasonPhrase}")));
        // Handle errors, if status code is not 201 (Created)
        print("Failed to sign up. Status code: ${response.statusCode}");
        print("Error message: ${response.body}");
      }
    } catch (e) {
      // Handle any network or other errors
      print("Error occurred during sign-up: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 300.0; // Define the width for consistency

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Pamurger',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppTheme.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png', // Ensure the path is correct
                  width: 250, // Set the width of the logo
                  height: 250, // Set the height of the logo
                ),
                SizedBox(
                  width: buttonWidth, // Match the width of the button
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: buttonWidth, // Match the width of the button
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: buttonWidth, // Match the width of the button
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true, // Hide the password text
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.green,
                        ),
                      )
                    : Container(
                        width: buttonWidth, // Match the width of the button
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF014e28), Color(0xFF87dc1b)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            await signUpUser(
                                context,
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent, // No shadow
                            minimumSize:
                                const Size(double.infinity, 50), // Button size
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
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
