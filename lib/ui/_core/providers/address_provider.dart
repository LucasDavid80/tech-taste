import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  String? _selectedAddressDelivery;
  String? _selectedAddressDetails;
  double _restaurantDistance = 0;

  String? get selectedAddressDelivery => _selectedAddressDelivery;
  String? get selectedAddressDetails => _selectedAddressDetails;
  double get restaurantDistance => _restaurantDistance;

  void selectAddressDelivery(String method, String details) {
    _selectedAddressDelivery = method;
    _selectedAddressDetails = details;
    notifyListeners(); // Notifica os widgets dependentes
  }

  void clearSelectedAddress() {
    _selectedAddressDelivery = null;
    _selectedAddressDetails = null;
    notifyListeners(); // Notifica os widgets dependentes
  }

  double getDeliveryFee() {
    if (_selectedAddressDelivery == 'Casa') {
      return _restaurantDistance * .80;
    } else if (_selectedAddressDelivery == 'Trabalho') {
      return _restaurantDistance * .50;
    } else {
      return 0.00;
    }
  }

  void setRestaurantDistance(int distance) {
    _restaurantDistance = _restaurantDistance + distance.toDouble();
    notifyListeners();
  }
}
