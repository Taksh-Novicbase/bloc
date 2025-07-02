part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartAction extends CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  late final List<Product> cartData;
  CartLoaded({required this.cartData});
}

class CartRemove extends CartAction {
  late final Product cartData;
  CartRemove({required this.cartData});
}

class CartError extends CartState {}
