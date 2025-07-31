import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/providers/payment_provider.dart';
import 'package:techtaste/ui/checkout/cards/card_widget.dart';
import 'package:techtaste/ui/checkout/widget/pop_up_widget.dart';

Widget paymentCard() {
  return Consumer<PaymentProvider>(
    builder: (context, paymentProvider, child) {
      if (paymentProvider.selectedPaymentMethod == null) {
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text('Selecione uma forma de pagamento'),
            trailing: Container(
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(1200.0),
              ),
              child: IconButton(
                key: Key('Pagamento'),
                onPressed: () {
                  showPopUpWidget(context: context, title: 'Pagamento');
                },
                icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ),
          ),
        );
      } else {
        return getCardWidget(
          '',
          paymentProvider.selectedPaymentMethod ?? '',
          paymentProvider.selectedPaymentDetails ?? '',
          'assets/others/visa.png',
          () {
            showPopUpWidget(context: context, title: 'Pagamento');
          },
        );
      }
    },
  );
}
