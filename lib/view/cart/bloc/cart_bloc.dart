import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_bloc_app/data/cart_data.dart';
import 'package:my_bloc_app/view/cart/UI/cart.dart';
import 'package:my_bloc_app/view/home/model/home_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveEvent>(cartRemoveEvent);
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) {
    log("CartEvent running....");
    emit(CartLoaded(cartData: cartData));
  }

  FutureOr<void> cartRemoveEvent(
    CartRemoveEvent event,
    Emitter<CartState> emit,
  ) {
    cartData.remove(event.cartData);
    emit(CartLoaded(cartData: cartData));
    emit(CartRemove(cartData: event.cartData));
  }
}
