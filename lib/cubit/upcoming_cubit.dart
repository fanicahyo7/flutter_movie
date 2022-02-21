import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/upcoming_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingInitial());
  Future<void> getUpComing() async {
    try {
      emit(UpcomingLoading());
      UpComingModel nowplaying = await Service().getUpComing();
      emit(UpcomingSuccess(nowplaying));
    } catch (e) {
      emit(UpcomingFailed(e.toString()));
    }
  }
}
