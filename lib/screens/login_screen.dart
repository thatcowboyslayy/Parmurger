import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert'; // Import dart:convert for JSON handling
// import 'recipe_recommendation_page.dart'; // Import the RecipeRecommendationPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // This method will be called when the login button is pressed
  Future<void> _fetchDataAndNavigate(BuildContext context) async {
    // Extract email and password from the TextEditingController
    final email = _emailController.text;
    final password = _passwordController.text;

    // Create the request body
    final requestBody = jsonEncode({
      'email': email,
      'password': password,
    });

    // try {
    //   final response = await http.post(
    //     Uri.parse(
    //         'https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/users/login?email=$email&password=$password'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: requestBody,
    //   );

    //   if (response.statusCode == 200) {
    //     // Successfully received a response
    //     final data = json.decode(response.body);
    //     print(data); // Just printing to console for now

    //     // Navigate to RecipeRecommendationPage after successful fetch
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => RecipeRecommendationPage()),
    //     );
    //   } else {
    //     // Handle the error if the response status is not 200
    //     throw Exception('Failed to load data');
    //   }
    // } catch (error) {
    //   // Handle any errors that occurred during the request
    //   print('Error: $error');
    //   // Optionally, show an error message to the user
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Failed to load data')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 300.0; // Set the width for input fields and button

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: buttonWidth,
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
                width: buttonWidth,
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
              Container(
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
                  onPressed: () {
                    // Call _fetchDataAndNavigate when the button is pressed
                    _fetchDataAndNavigate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,

                    shadowColor: Colors.transparent, // Remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize:
                        Size(buttonWidth, 50), // Ensure button size matches
                    foregroundColor: Colors.white, // Set text color to white
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
                      // Handle sign-up navigation here
                      // For example, Navigator.pushNamed(context, '/signUp');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
