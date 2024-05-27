import 'dart:convert';

class Food {
  
  
  String name;
  String description;
  String type;
  bool available;
  String restaurant;
  String geo;
  String? picture;


  String? id;
  
  Food(
      {required this.available,
      required this.name,
      this.picture,
      required this.type,
      required this.geo,
      required this.description,
      required this.restaurant,
      this.id});

  get Urlimage {
    if (this.picture != null) {
      return picture;
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

 
  factory Food.fromJson(String str) => Food.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Food.fromMap(Map<String, dynamic> json) => Food(
        
        name: json["nom"],
        description: json["descripcio"],
        type: json["tipus"],
        available: json["disponible"],
        restaurant: json["restaurant"],
        geo: json["geo"],
        picture: json["foto"],
      );

  Map<String, dynamic> toMap() => {
        "disponible": available,
        "nom": name,
        "foto": picture,
        "restaurant": restaurant,
        "geo": geo,
        "descripcio": description,
        "tipus": type,
      };


  Food copy() => Food(
      available: this.available,
      name: this.name,
      description: this.description,
      restaurant: this.restaurant,
      type: this.type,
      geo: this.geo,
      picture: this.picture,
      id: this.id);
}

