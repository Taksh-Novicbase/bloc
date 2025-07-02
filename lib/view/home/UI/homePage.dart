import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/view/home/bloc/home_bloc.dart';

import '../../../data/data.dart';
import '../../../routes/routes.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  final HomeBloc homeBloc = HomeBloc();

  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (context, state) => state is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is FavNavigateState) {
          Navigator.pushNamed(context, Routes.fav);
        } else if (state is CartNavigateState) {
          Navigator.pushNamed(context, Routes.cart);
        } else if (state is ProductFavState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Added to Favourite")));
        } else if (state is ProductCartState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Added to Cart ")));
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeLoaded) {
          final successState = state as HomeLoaded;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text(
                "Grocery Shop",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    homeBloc.add(FavNavigateEvent());
                  },
                  icon: Icon(Icons.favorite_border, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    homeBloc.add(CartNavigateEvent());
                  },
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: successState.data.length,
              itemBuilder: (context, index) {
                final product = successState.data[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 60),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${product.price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.favorite_border),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          // Add to favorite
                                          homeBloc.add(
                                            FavClickEvent(
                                              favproduct:
                                                  successState.data[index],
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_shopping_cart,
                                        ),
                                        color: Colors.teal,
                                        onPressed: () {
                                          // Add to cart
                                          homeBloc.add(
                                            CartClickEvent(
                                              cartproduct:
                                                  successState.data[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is HomeError) {
          return Scaffold(body: Text("Error"));
        }
        return SizedBox();
      },
    );
  }
}
