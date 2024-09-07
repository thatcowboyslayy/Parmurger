import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert'; // Import dart:convert for JSON handling

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // This method will be called when the sign-up button is pressed
  // Future<void> _signUp(BuildContext context) async {
  //   final url = Uri.parse(
  //       'https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/users/create');

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         'name': _nameController.text,
  //         'email': _emailController.text,
  //         'password': _passwordController.text,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       // Successfully received a response
  //       final data = json.decode(response.body);
  //       print(data); // Just printing to console for now

  //       // Navigate to the login page or another page after successful sign-up
  //       Navigator.pushReplacementNamed(context, '/login');
  //     } else {
  //       // Handle the error if the response status is not 200
  //       throw Exception('Failed to sign up');
  //     }
  //   } catch (error) {
  //     // Handle any errors that occurred during the request
  //     print('Error: $error');
  //     // Optionally, show an error message to the user
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to sign up')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 300.0; // Define the width for consistency

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
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
              Container(
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
              Container(
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
              Container(
                width: buttonWidth, // Match the width of the button
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
                    // Call _signUp when the button is pressed
                    // _signUp(context);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent, // No shadow
                    minimumSize: Size(double.infinity, 50), // Button size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
