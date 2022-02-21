import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());

  Future<void> getPopular() async {
    try {
      emit(PopularLoading());
      PopularModel nowplaying = await Service().getPopular();
      emit(PopularSuccess(nowplaying));
    } catch (e) {
      emit(PopularFailed(e.toString()));
    }
  }
}
