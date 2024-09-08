import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/models/ingredients.dart';
import 'package:my_project/screens/add_ingredient.dart';
import 'package:http/http.dart' as http;

const String fridgeApiUrl =
    'https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/fridge/66dc2b34b9d856669b5df4c1';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({super.key});

  @override
  _FridgeScreenState createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  File? _image;
  bool _isHovered = false;

  Future<List<FridgeIngredient>> fetchFridgeIngredients() async {
    try {
      final response = await http.get(Uri.parse(fridgeApiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['items'];
        return data.map((item) => FridgeIngredient.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load fridge ingredients');
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(_image!);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      _isHovered = true;
    });
    http.post(
      Uri.parse(
          'https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/recipe/fgvhjbnk/66dc2b34b9d856669b5df4c1'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    final uri = Uri.parse(
        'https://parmurger-4hh5r2wlaq-uc.a.run.app/api/v1/fridge/image/66dc2b34b9d856669b5df4c1');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path))
      ..headers['accept'] = 'application/json';

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully')),
      );
      setState(() {}); // Refresh the list after upload
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image')),
      );
    }
    setState(() {
      _isHovered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            FutureBuilder<List<FridgeIngredient>>(
              future: fetchFridgeIngredients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No ingredients found.'));
                } else {
                  final fridgeIngredients = snapshot.data!;
                  return ListView.builder(
                    itemCount: fridgeIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = fridgeIngredients[index];
                      return _buildFridgeIngredientCard(
                        ingredient.ingredient?.name ?? ingredient.name ?? '',
                        ingredient.quantity ?? '1',
                        ingredient.expiryDate ?? '',
                      );
                    },
                  );
                }
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Center(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _isHovered ? 70 : 60,
                    height: _isHovered ? 70 : 60,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.7),
                      shape: BoxShape.circle,
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ]
                          : [],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add New Item'),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(Icons.camera_alt, size: 40),
                                    onPressed: _openCamera,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 40),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddIngredientScreen()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFridgeIngredientCard(
      String title, String quantity, String expiryDate) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Quantity: $quantity',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Expiry Date: $expiryDate',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
