import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  String? _selectedAddressDelivery;
  String? _selectedAddressDetails;

  String? get selectedAddressDelivery => _selectedAddressDelivery;
  String? get selectedAddressDetails => _selectedAddressDetails;

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
      return 7.00;
    } else if (_selectedAddressDelivery == 'Trabalho') {
      return 5.00;
    } else {
      return 0.00;
    }
  }
}
