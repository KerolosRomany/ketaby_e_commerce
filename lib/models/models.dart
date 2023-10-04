import 'dart:convert';

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
  final String discount;
  final String priceAfterDiscount;
  final String stock;
  final String bestSeller;
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
      discount: json['discount'].toString(),
      priceAfterDiscount: json['price_after_discount'].toString()== 'null' ? '${double.parse(json['price'])*double.parse(json['discount'])}' : json['price_after_discount'].toString(),
      stock: json['stock'].toString(),
      bestSeller: json['best_seller'].toString(),
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
class CartBookModel {
  int itemId;
  int itemProductId;
  String itemProductName;
  String itemProductImage;
  String itemProductPrice;
  String itemProductDiscount;
  String itemProductPriceAfterDiscount;
  String itemProductStock;
  int itemQuantity;
  String itemTotal;

  CartBookModel({
    required this.itemId,
    required this.itemProductId,
    required this.itemProductName,
    required this.itemProductImage,
    required this.itemProductPrice,
    required this.itemProductDiscount,
    required this.itemProductPriceAfterDiscount,
    required this.itemProductStock,
    required this.itemQuantity,
    required this.itemTotal,
  });

  factory CartBookModel.fromJson(Map<String, dynamic> json) => CartBookModel(
    itemId: json['item_id'],
    itemProductId: json['item_product_id'],
    itemProductName: json['item_product_name'],
    itemProductImage: json['item_product_image'],
    itemProductPrice: json['item_product_price'],
    itemProductDiscount: json['item_product_discount'].toString(),
    itemProductPriceAfterDiscount: json['item_product_price_after_discount'].toString(),
    itemProductStock: json['item_product_stock'].toString(),
    itemQuantity: json['item_quantity'],
    itemTotal: json['item_total'].toString(),
  );

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'item_product_id': itemProductId,
    'item_product_name': itemProductName,
    'item_product_image': itemProductImage,
    'item_product_price': itemProductPrice,
    'item_product_discount': itemProductDiscount,
    'item_product_price_after_discount': itemProductPriceAfterDiscount,
    'item_product_stock': itemProductStock,
    'item_quantity': itemQuantity,
    'item_total': itemTotal,
  };
}
class GovernorateModel {
  int id;
  String governorateNameEn;

  GovernorateModel({
    required this.id,
    required this.governorateNameEn,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) => GovernorateModel(
    id: json['id'],
    governorateNameEn: json['governorate_name_en'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'governorate_name_en': governorateNameEn,
  };
}

class OrderModel {
  int id;
  UserModel user;
  String total;
  List<CartItemModel> cartItems;

  OrderModel({
    required this.id,
    required this.user,
    required this.total,
    required this.cartItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'],
    user: UserModel.fromJson(json['user']),
    total: json['total'],
    cartItems: List<CartItemModel>.from(json['cart_items'].map((item) => CartItemModel.fromJson(item))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': user.toJson(),
    'total': total,
    'cart_items': cartItems.map((item) => item.toJson()).toList(),
  };
}

class UserModel {
  int userId;
  String userName;
  String userEmail;
  String address;
  String phone;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['user_id'],
    userName: json['user_name'],
    userEmail: json['user_email'],
    address: json['address'],
    phone: json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'user_name': userName,
    'user_email': userEmail,
    'address': address,
    'phone': phone,
  };
}

class CartItemModel {
  int itemId;
  int itemProductId;
  String itemProductName;
  String itemProductPrice;
  int itemQuantity;
  String itemTotal;

  CartItemModel({
    required this.itemId,
    required this.itemProductId,
    required this.itemProductName,
    required this.itemProductPrice,
    required this.itemQuantity,
    required this.itemTotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    itemId: json['item_id'],
    itemProductId: json['item_product_id'],
    itemProductName: json['item_product_name'],
    itemProductPrice: json['item_product_price'],
    itemQuantity: json['item_quantity'],
    itemTotal: json['item_total'],
  );

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'item_product_id': itemProductId,
    'item_product_name': itemProductName,
    'item_product_price': itemProductPrice,
    'item_quantity': itemQuantity,
    'item_total': itemTotal,
  };
}


class FavoriteModel {
  int id;
  String name;
  double price;
  String category;
  String image;
  int discount;
  int stock;
  String description;
  int bestSeller;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.discount,
    required this.stock,
    required this.description,
    required this.bestSeller,
  });

  factory FavoriteModel.fromJson( Map<String, dynamic> data) {
    // final Map<String, dynamic> data = jsonDecode(json);
    return FavoriteModel(
      id: data['id'],
      name: data['name'],
      price: double.parse(data['price']),
      category: data['category'],
      image: data['image'],
      discount: int.parse(data['discount']),
      stock: int.parse(data['stock']),
      description: data['description'],
      bestSeller: int.parse(data['best_seller']),
    );
  }

  String toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
      'discount': discount,
      'stock': stock,
      'description': description,
      'best_seller': bestSeller,
    };
    return jsonEncode(data);
  }
}