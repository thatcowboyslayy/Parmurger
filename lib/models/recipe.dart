class Recipe {
  String? name;
  bool? isLike;
  Null? description;
  String? imageUrl;
  Null? category;
  Null? cookingTime;
  List<Ingredients>? ingredients;

  Recipe(
      {this.name,
      this.isLike,
      this.description,
      this.imageUrl,
      this.category,
      this.cookingTime,
      this.ingredients});

  Recipe.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isLike = json['is_like'];
    description = json['description'];
    imageUrl = json['image_url'];
    category = json['category'];
    cookingTime = json['cooking_time'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['is_like'] = this.isLike;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['category'] = this.category;
    data['cooking_time'] = this.cookingTime;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  int? id;
  String? name;
  Null? imageUrl;
  Null? foodType;

  Ingredients({this.id, this.name, this.imageUrl, this.foodType});

  Ingredients.fromJson(Map<String, dynamic> json) {
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
