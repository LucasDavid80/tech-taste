import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/checkout/cards/card_widget.dart';
import 'package:techtaste/ui/checkout/widget/pop_up_widget.dart';

Widget addressCard(double enderecoEntrega) {
  return Consumer<AddressProvider>(
    builder: (context, paymentProvider, child) {
      if (paymentProvider.selectedAddressDelivery == null) {
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text('Selecione o Endereço de Entrega'),
            trailing: Container(
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(1200.0),
              ),
              child: IconButton(
                key: Key('Entrega'),
                onPressed: () {
                  showPopUpWidget(
                    context: context,
                    title: 'Endereço de Entrega',
                  );
                },
                icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ),
          ),
        );
      } else {
        return getCardWidget(
          'Entrega',
          paymentProvider.selectedAddressDelivery ?? '',
          paymentProvider.selectedAddressDetails ?? '',
          null,
          () {
            enderecoEntrega = showPopUpWidget(
              context: context,
              title: 'Endereço de Entrega',
            );
          },
        );
      }
    },
  );
}
