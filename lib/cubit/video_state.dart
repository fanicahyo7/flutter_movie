part of 'video_cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoFailed extends VideoState {
  final String error;

  const VideoFailed(this.error);

  @override
  List<Object> get props => [error];
}

class VideoSuccess extends VideoState {
  final VideoModel video;

  const VideoSuccess(this.video);

  @override
  List<Object> get props => [video];
}
