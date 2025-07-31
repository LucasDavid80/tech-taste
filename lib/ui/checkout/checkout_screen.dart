import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:techtaste/ui/checkout/cards/address_card_widget.dart';
import 'package:techtaste/ui/checkout/widget/order_confirm_dialog.dart';
import 'package:techtaste/ui/checkout/cards/payment_card_widget.dart';
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
    Widget buildCard(bool isPaymentCard) {
      if (isPaymentCard) {
        return paymentCard();
      } else {
        return addressCard(enderecoEntrega);
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
                          'assets/${dish.imagePath}',
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
                buildCard(true), // Card de pagamento, favor não apagar :)
                Text(
                  'Entregar no endereço',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                buildCard(false), // Card de endereço, favor não apagar :)
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
                          key: Key('ConfirmarPedido'),
                          onPressed: () {
                            showOrderConfirmDialog(
                              context: context,
                              total: total,
                              bagProvider: bagProvider,
                              addressProvider: addressProvider,
                              paymentProvider: paymentProvider,
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
