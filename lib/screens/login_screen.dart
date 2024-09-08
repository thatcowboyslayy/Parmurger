import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:my_project/screens/home_screen.dart';
import 'package:my_project/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart'; // Import dart:convert for JSON handling
// import 'recipe_recommendation_page.dart'; // Import the RecipeRecommendationPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String apiUrl =
      "https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/users/login";
  bool isLoading = false;

  Future<void> loginUser(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    // Create the body of the request

    try {
      // Make the HTTP POST request
      final response = await post(
        Uri.parse(
        apiUrl+    "?email=$email&password=$password"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Successful request, print the response body
        print("Login successful: ${response.body}");

        // You can decode the JSON if needed
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data); // Handle the response data as needed
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => ProfileScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.reasonPhrase}")));
        // If the server did not return a 200 response code
        print("Failed to login. Status code: ${response.request}");
      }
    } catch (e) {
      // Handle any errors (e.g., network issues)
      print("Error occurred during login: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 300.0; // Set the width for input fields and button

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
                  width: buttonWidth,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.green, width: 0.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: buttonWidth,
                  child: TextField(
                    style: TextStyle(color: AppTheme.green),
                    controller: _passwordController,
                    obscureText: true, // Hide the password text
                    decoration: InputDecoration(
                      fillColor: AppTheme.green,
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
                        width: buttonWidth,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF014e28), Color(0xFF87dc1b)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            await loginUser(_emailController.text.trim(),
                                _passwordController.text.trim());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,

                            shadowColor: Colors.transparent, // Remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            minimumSize: Size(
                                buttonWidth, 50), // Ensure button size matches
                            foregroundColor:
                                Colors.white, // Set text color to white
                          ),
                          child: const Text('Login'),
                        ),
                      ),
           
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ProfileScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          color: AppTheme.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
