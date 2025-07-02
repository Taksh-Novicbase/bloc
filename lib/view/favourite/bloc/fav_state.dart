part of 'fav_bloc.dart';

@immutable
sealed class FavState {}

sealed class FavActionState extends FavState {}

final class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavLoaded extends FavState {
  late final List favDataList;
  FavLoaded({required this.favDataList});
}

class FavRemove extends FavActionState {
  late final Product favDataList;
  FavRemove({required this.favDataList});
}

class FavError extends FavState {}
