import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/video_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  Future<void> getVideo(String id) async {
    try {
      emit(VideoLoading());
      VideoModel video = await Service().getVideo(id);
      emit(VideoSuccess(video));
    } catch (e) {
      emit(VideoFailed(e.toString()));
    }
  }
}
