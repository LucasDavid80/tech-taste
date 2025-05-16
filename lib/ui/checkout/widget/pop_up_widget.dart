import 'package:flutter/material.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/checkout/widget/card_widget.dart';
import 'package:techtaste/ui/_core/providers/payment_provider.dart';
import 'package:provider/provider.dart';

int entrega = 0;
double showPopUpWidget({
  required BuildContext context,
  required String title,
  // required List<Widget> contentWidgets,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              title == 'Pagamento'
                  ? buildPaymentOptions(context)
                  : title == 'Endereço de Entrega'
                  ? buildAddressOptions(context)
                  : [Text('Nenhum Endereço ou Pagamento disponível')],
        ),
      );
    },
  );

  return entrega.toDouble();
}

List<Widget> buildPaymentOptions(BuildContext context) {
  return [
    getCardWidget(
      'Cartão de Crédito',
      '**** **** **** 1234',
      'assets/others/visa.png',
      () {
        Provider.of<PaymentProvider>(
          context,
          listen: false,
        ).selectPaymentMethod('Cartão de Crédito', '**** **** **** 1234');

        Navigator.of(context).pop();
      },
    ),
    getCardWidget(
      'Cartão de Débito',
      '**** **** **** 5678',
      'assets/others/visa.png',
      () {
        Provider.of<PaymentProvider>(
          context,
          listen: false,
        ).selectPaymentMethod('Cartão de Débito', '**** **** **** 5678');
        Navigator.of(context).pop();
      },
    ),
  ];
}

List<Widget> buildAddressOptions(BuildContext context) {
  return [
    Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text('Casa'),
        subtitle: Text('Rua A, 123 - Bairro'),
        leading: Icon(Icons.home),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(1200.0),
          ),
          child: IconButton(
            onPressed: () {
              Provider.of<AddressProvider>(
                context,
                listen: false,
              ).selectAddressDelivery('Casa', 'Rua A, 123 - Bairro');
              entrega = 7;
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
        ),
      ),
    ),
    Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text('Trabalho'),
        subtitle: Text('Avenida Central, 456'),
        leading: Icon(Icons.work),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(1200.0),
          ),
          child: IconButton(
            onPressed: () {
              Provider.of<AddressProvider>(
                context,
                listen: false,
              ).selectAddressDelivery('Trabalho', 'Avenida Central, 456');
              entrega = 5;
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
        ),
      ),
    ),
  ];
}
