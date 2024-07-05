import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Function to add item to the cart
Future<void> addToCart(Map<String, dynamic> item) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? cart = pref.getStringList("cart") ?? [];
    cart.add(json.encode(item));
    await pref.setStringList("cart", cart);
    print('Item added: $item');
  } catch (e) {
    print('Error adding item: $e');
    throw Exception('Failed to add item');
  }
}

// Function to get cart items
Future<List<Map<String, dynamic>>> getCartList() async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? cart = pref.getStringList("cart") ?? [];
    List<Map<String, dynamic>> decodedCart =
        cart.map((item) => json.decode(item) as Map<String, dynamic>).toList();
    print('Cart retrieved: $decodedCart');
    return decodedCart;
  } catch (e) {
    print('Error retrieving cart: $e');
    throw Exception('Failed to retrieve cart');
  }
}

// Function to remove item from the cart
Future<void> removeFromCart(Map<String, dynamic> item) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? cart = pref.getStringList("cart") ?? [];
    cart.remove(json.encode(item));
    await pref.setStringList("cart", cart);
    print('Item removed: $item');
  } catch (e) {
    print('Error removing item: $e');
    throw Exception('Failed to remove item');
  }
}
