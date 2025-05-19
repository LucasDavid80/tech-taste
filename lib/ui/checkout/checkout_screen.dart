import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:techtaste/ui/checkout/widget/card_widget.dart';
import 'package:techtaste/ui/checkout/widget/pop_up_widget.dart';
import 'package:techtaste/ui/_core/providers/payment_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
    if (bagProvider.dishesOnBag.isEmpty) {
      // Limpa endereço e pagamento após o build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        addressProvider.clearSelectedAddress();
        paymentProvider.clearSelectedPayment();
      });
      return Scaffold(
        appBar: AppBar(title: const Text('Sacola'), centerTitle: true),
        body: Center(child: Text('Nenhum pedido na sacola.')),
      );
    }
    double enderecoEntrega = addressProvider.getDeliveryFee();
    double total = bagProvider.totalPrice() + enderecoEntrega;

    //Função para retornar um card modular
    Widget buildCard(String title, String subtitle, bool isPaymentCard) {
      if (isPaymentCard) {
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
                paymentProvider.selectedPaymentMethod ?? title,
                paymentProvider.selectedPaymentDetails ?? subtitle,
                'assets/others/visa.png',
                () {
                  showPopUpWidget(context: context, title: 'Pagamento');
                },
              );
            }
          },
        );
      } else {
        return Consumer<AddressProvider>(
          builder: (context, paymentProvider, child) {
            if (paymentProvider.selectedAddressDelivery == null) {
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
                paymentProvider.selectedAddressDelivery ?? title,
                paymentProvider.selectedAddressDetails ?? subtitle,
                '',
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
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sacola'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                bagProvider.clearBag();
                // Navigator.pop(context);
              },
              child: Text('Limpar'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pedidos',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                Column(
                  children: List.generate(
                    bagProvider.getMapByAmount().keys.length,
                    (index) {
                      Dish dish =
                          bagProvider.getMapByAmount().keys.toList()[index];
                      return ListTile(
                        onTap: () {},
                        leading: Image.asset(
                          'assets/dishes/default.png',
                          width: 48,
                        ),
                        title: Text(dish.name),
                        subtitle: Text('R\$ ${dish.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.0,
                          children: [
                            IconButton(
                              onPressed: () {
                                bagProvider.removeDish(dish);
                              },
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  AppColors.buttonColor,
                                ),
                              ),
                            ),
                            Text(
                              bagProvider.getMapByAmount()[dish].toString(),
                              style: TextStyle(fontSize: 22.0),
                            ),
                            IconButton(
                              onPressed: () {
                                bagProvider.addAllDishes([dish]);
                              },
                              icon: Icon(
                                Icons.arrow_drop_up,
                                color: Colors.black,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  AppColors.buttonColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  'Pagamentos',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                buildCard(
                  '',
                  '',
                  true,
                ), // Card de pagamento, favor não apagar :)
                Text(
                  'Entregar no endereço',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                buildCard(
                  '',
                  '',
                  false,
                ), // Card de endereço, favor não apagar :)
                Text(
                  'Confirmar',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        title: Text(
                          'Pedido:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          'R\$ ${bagProvider.totalPrice().toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Entrega:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          'R\$ ${addressProvider.getDeliveryFee().toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          'R\$ ${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textHighlightColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Pedido Confirmado',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        'Seu pedido foi confirmado com sucesso!',
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Total: R\$ ${total.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => {Navigator.of(context).pop()},
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text('CANCELAR'),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => {
                                            bagProvider.clearBag(),
                                            addressProvider
                                                .clearSelectedAddress(),
                                            paymentProvider
                                                .clearSelectedPayment(),

                                            Navigator.of(context).pop(),
                                          },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            textStyle: TextStyle(fontSize: 18.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8.0,
                            children: [
                              Icon(Icons.account_balance_wallet, size: 28.0),
                              Text(
                                'Pedir',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
