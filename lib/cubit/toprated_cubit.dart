import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/toprated_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'toprated_state.dart';

class TopratedCubit extends Cubit<TopratedState> {
  TopratedCubit() : super(TopratedInitial());

  Future<void> getTopRated() async {
    try {
      emit(TopratedLoading());
      TopRatedModel toprated = await Service().getTopRated();
      emit(TopratedSuccess(toprated));
    } catch (e) {
      emit(TopratedFailed(e.toString()));
    }
  }
}
