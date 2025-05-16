import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  String? _selectedPaymentMethod; // Método de pagamento selecionado
  String? _selectedPaymentDetails; // Detalhes do pagamento selecionado

  // Método de pagamento selecionado
  String? get selectedPaymentMethod => _selectedPaymentMethod;
  // Detalhes do pagamento selecionado
  String? get selectedPaymentDetails => _selectedPaymentDetails;

  // Método para selecionar o método de pagamento
  void selectPaymentMethod(String method, String details) {
    _selectedPaymentMethod =
        method; // Atualiza o método de pagamento selecionado
    _selectedPaymentDetails = details; // Detalhes do pagamento selecionado
    notifyListeners(); // Notifica os widgets dependentes
  }

  void clearSelectedPayment() {
    _selectedPaymentMethod = null; // Limpa o método de pagamento selecionado
    _selectedPaymentDetails =
        null; // Limpa os detalhes do pagamento selecionado
    notifyListeners(); // Notifica os widgets dependentes
  }
}
