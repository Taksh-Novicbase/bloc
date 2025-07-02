import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_bloc_app/data/fav_data.dart';
import 'package:my_bloc_app/view/home/model/home_model.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    on<CreateFavInitialState>(createFavInitialState);
    on<RemoveFavEvent>(removeFavEvent);
  }

  FutureOr<void> createFavInitialState(
    CreateFavInitialState event,
    Emitter<FavState> emit,
  ) {
    log("FavEvent running....");
    emit(FavLoaded(favDataList: favData));
  }

  FutureOr<void> removeFavEvent(RemoveFavEvent event, Emitter<FavState> emit) {
    favData.remove(event.favproduct);
    emit(FavLoaded(favDataList: favData));
    emit(FavRemove(favDataList: event.favproduct));
  }
}
