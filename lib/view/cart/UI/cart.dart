import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/view/cart/bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

final CartBloc cartBloc = CartBloc();

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        title: Text("Cart", style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        buildWhen: (previous, current) => current is! CartAction,
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartAction,
        listener: (context, state) {
          if (state is CartRemove) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Deleted to Cart ")));
          }
        },
        builder: (context, state) {
          if (state is CartLoaded) {
            final successState = state;

            if (successState.cartData.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            }

            final totalPrice = successState.cartData.fold<int>(
              0,
              (sum, item) => sum + item.price,
            );
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: successState.cartData.length,
                    itemBuilder: (context, index) {
                      final item = successState.cartData[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Image.network(
                            item.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 60),
                          ),
                          title: Text(item.name),
                          subtitle: Text("₹${item.price}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              log("Button clicked");
                              log(successState.cartData[index].name);
                              cartBloc.add(
                                CartRemoveEvent(successState.cartData[index]),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ₹$totalPrice",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        onPressed: () {
                          // TODO: Handle checkout logic
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text("Error"));
          } else if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
