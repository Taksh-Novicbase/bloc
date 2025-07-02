part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  List<Product> data = [];
  HomeLoaded({required this.data});
}

class HomeError extends HomeState {}

class FavNavigateState extends HomeActionState {}

class CartNavigateState extends HomeActionState {}

class ProductFavState extends HomeActionState {}

class ProductCartState extends HomeActionState {}
