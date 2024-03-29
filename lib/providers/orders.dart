import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> orders = [];
  final String authToken;

  Orders(this.authToken, this.orders);

  List<OrderItem> get ordini {
    return [...orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
        'progetto2-33ec6-default-rtdb.europe-west1.firebasedatabase.app',
        'orders.json',
        {'auth': authToken});
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData;
    try {
      extractedData = json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      return;
    }
    /* if (extractedData == null) {
      return;
    } */

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(
        'progetto2-33ec6-default-rtdb.europe-west1.firebasedatabase.app',
        'orders.json',
        {'auth': authToken});
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
