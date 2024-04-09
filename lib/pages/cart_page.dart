import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/colors.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
        backgroundColor: pageBackground,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: pageBackground,
          title: Text(
            'Cart Page',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: cart.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Cart is empty',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final product = cart[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          product['imageUrl'],
                          width: 85,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                product['title'],
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'Price: \$${product['price']} / day',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Delete Product',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: const Text(
                                    'Are you sure you want to remove the product from your cart?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .removeProduct(product);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
