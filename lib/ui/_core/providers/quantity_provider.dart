import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier {
  int _quantity = 1;

  int get quantity => _quantity;

  void increment() {
    _quantity++;
    notifyListeners(); // Notifica os widgets que dependem deste estado
  }

  void decrement() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners(); // Notifica os widgets que dependem deste estado
    }
  }

  void setQuantity(int quantity) {
    if (quantity >= 0) {
      _quantity = quantity;
      notifyListeners(); // Notifica os widgets que dependem deste estado
    }
  }
}
