class FridgeIngredient {
  Ingredient? ingredient;
  String? quantity;
  String? expiryDate;
  String? name;

  FridgeIngredient({this.ingredient, this.quantity, this.expiryDate});

  FridgeIngredient.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'] != null
        ? new Ingredient.fromJson(json['ingredient'])
        : null;
    quantity = json['quantity'];
    name = json['name'];
    expiryDate = json['expiry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ingredient != null) {
      data['ingredient'] = this.ingredient!.toJson();
    }
    data['quantity'] = this.quantity;
    data['expiry_date'] = this.expiryDate;
    return data;
  }
}

class Ingredient {
  int? id;
  String? name;
  String? imageUrl;
  String? foodType;

  Ingredient({this.id, this.name, this.imageUrl, this.foodType});

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    foodType = json['food_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['food_type'] = this.foodType;
    return data;
  }
}
