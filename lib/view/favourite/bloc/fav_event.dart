part of 'fav_bloc.dart';

@immutable
sealed class FavEvent {}

class CreateFavInitialState extends FavEvent {}

class RemoveFavEvent extends FavEvent {
  final Product favproduct;
  RemoveFavEvent({required this.favproduct});
}
