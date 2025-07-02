import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_app/data/fav_data.dart';
import 'package:my_bloc_app/view/favourite/bloc/fav_bloc.dart';

class Fav extends StatefulWidget {
  Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

final FavBloc favBloc = FavBloc();

class _FavState extends State<Fav> {
  @override
  void initState() {
    super.initState();
    favBloc.add(CreateFavInitialState());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavBloc, FavState>(
      listenWhen: (previous, current) => current is FavActionState,
      buildWhen: (previous, current) => current is! FavActionState,
      bloc: favBloc,
      listener: (context, state) {
        if (state is FavRemove) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Removed to FavList ")));
        }
      },
      builder: (context, state) {
        if (state is FavLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              backgroundColor: Colors.teal,
              title: Text("Favourite", style: TextStyle(color: Colors.white)),
            ),
            body: ListView.builder(
              itemCount: favData.length,
              itemBuilder: (context, index) {
                final product = favData[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 60),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "₹${product.price}",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        favBloc.add(RemoveFavEvent(favproduct: favData[index]));
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is FavLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(appBar: AppBar(title: Text("Favourite")));
      },
    );
  }
}
