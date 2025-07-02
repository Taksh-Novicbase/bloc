import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_bloc_app/view/home/model/home_model.dart';

import '../../../data/cart_data.dart';
import '../../../data/data.dart';
import '../../../data/fav_data.dart';
import '../../cart/UI/cart.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FavNavigateEvent>(favNavigateEvent);
    on<CartNavigateEvent>(cartNavigateEvent);
    on<FavClickEvent>(favClickEvent);
    on<CartClickEvent>(cartClickEvent);
    on<HomeInitialEvent>(homeInitialEvent);
  }

  Future<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoaded(
        data:
            Data.data
                .map(
                  (e) => Product(
                    id: e['id'],
                    name: e['name'],
                    price: e['price'],
                    description: e['description'],
                    image: e['image'],
                  ),
                )
                .toList(),
      ),
    );
  }

  FutureOr<void> favNavigateEvent(
    FavNavigateEvent event,
    Emitter<HomeState> emit,
  ) {
    log("favNavigate Clicked");
    emit(FavNavigateState());
  }

  FutureOr<void> cartNavigateEvent(
    CartNavigateEvent event,
    Emitter<HomeState> emit,
  ) {
    log("CartNavigate Clicked");
    emit(CartNavigateState());
  }

  FutureOr<void> favClickEvent(FavClickEvent event, Emitter<HomeState> emit) {
    log("FavEvent Clicked");
    favData.add(event.favproduct);
    emit(ProductFavState());
  }

  FutureOr<void> cartClickEvent(CartClickEvent event, Emitter<HomeState> emit) {
    log("cart Clicked");
    cartData.add(event.cartproduct);
    emit(ProductCartState());
  }
}
