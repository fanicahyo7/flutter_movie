import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/nowplaying_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'nowplaying_state.dart';

class NowplayingCubit extends Cubit<NowplayingState> {
  NowplayingCubit() : super(NowplayingInitial());

  Future<void> getNowPlaying() async {
    try {
      emit(NowplayingLoading());
      NowPlayingModel nowplaying = await Service().getNowPlaying();
      emit(NowplayingSuccess(nowplaying));
    } catch (e) {
      emit(NowplayingFailed(e.toString()));
    }
  }
}
