import 'dart:convert';

import 'package:expandable_search_bar/expandable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_project/models/recipe.dart';
import 'package:my_project/screens/fridge_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tcard/tcard.dart';
import 'package:http/http.dart' as http;

// Define the URL
const String apiUrl =
    'https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/recipe/66dc2b34b9d856669b5df4c1';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// Define your Recipe and Ingredients classes here (as you provided)
  Future<List<Recipe>?> fetchRecipe() async {
    try {
      // Make the HTTP GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['recipe'];
        // Create a list of Recipe instances from the parsed data
        return data.map((item) => Recipe.fromJson(item)).toList();
      } else {
        // Handle errors if the status code is not 200
        print('Failed to load recipe. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any network or parsing errors
      print('Error occurred: $e');
      return null;
    }
  }

  late final function;
  @override
  void initState() {
    function = fetchRecipe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TCardController _controller = TCardController();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Pamurger",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ExpandableSearchBar(
              onTap: () {
                print(searchController.text);
              },
              hintText: "search something",
              editTextController: searchController,
            ),
            const SizedBox(
              height: 15,
              width: 40,
            ),
            Expanded(
              child: FutureBuilder<List<Recipe>?>(
                future: function(), // Call the fetchRecipe method
                builder: (BuildContext context,
                    AsyncSnapshot<List<Recipe>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Show an error message if an error occurred
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Show a message if no data is found
                    return const Center(child: Text('No recipes found.'));
                  } else {
                    // Build the UI for the list of recipes
                    final recipes = snapshot.data!;
                    return TCard(
                      controller: _controller,
                      cards: recipes.map((recipe) {
                        return _buildProfileCard(
                            recipe.imageUrl ?? '', recipe.name ?? 'No Name');
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    color: Colors.black,
                    size: 20,
                    onPressed: () {
                      _controller.back();
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.food_bank,
                    color: Colors.green,
                    size: 40,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FridgeScreen()),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.thumb_up,
                    color: Colors.black,
                    size: 20,
                    onPressed: () {
                      _controller.forward();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String imageUrl, String name) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildTag("Cuisine"),
                      const SizedBox(width: 10),
                      _buildTag("Recette"),
                      const SizedBox(width: 10),
                      _buildTag("Rapide"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.7),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Colors.white, size: size),
      ),
    );
  }
}
