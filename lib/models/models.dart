class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String address;
  final String city;
  final String phone;
  final bool emailVerified;
  final String image;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.phone,
    required this.emailVerified,
    required this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] != null ? json['id'] : "null",
      name: json['name'] != null ? json['name'] : "null",
      email: json['email'] != null ? json['email'] : "null",
      address: json['address'] != null ? json['address'] : "null",
      city: json['city'] != null ? json['city'] : "null",
      phone: json['phone'] != null ? json['phone'] : "null",
      emailVerified: json['email_verified'] != null ? json['email_verified'] : "null",
      image: json['image'] != null ? json['image'] : "null",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'city': city,
      'phone': phone,
      'email_verified': emailVerified,
      'image': image,
    };
  }
}

class SliderModel {
  final String image;

  SliderModel({
    required this.image,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'image': image,
  };
}
class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int discount;
  final double priceAfterDiscount;
  final int stock;
  final int bestSeller;
  final String image;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.stock,
    required this.bestSeller,
    required this.image,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      priceAfterDiscount: json['price_after_discount'],
      stock: json['stock'],
      bestSeller: json['best_seller'],
      image: json['image'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'price_after_discount': priceAfterDiscount,
      'stock': stock,
      'best_seller': bestSeller,
      'image': image,
      'category': category,
    };
  }
}
class CategoryModel {
  final int id;
  final String name;
  final int productsCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      productsCount: json['products_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'products_count': productsCount,
    };
  }
}