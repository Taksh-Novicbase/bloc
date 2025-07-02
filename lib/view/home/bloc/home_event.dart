part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class FavNavigateEvent extends HomeEvent {}

class CartNavigateEvent extends HomeEvent {}

class FavClickEvent extends HomeEvent {
  late final Product favproduct;
  FavClickEvent({required this.favproduct});
}

class CartClickEvent extends HomeEvent {
  late final Product cartproduct;
  CartClickEvent({required this.cartproduct});
}
