part of 'nowplaying_cubit.dart';

abstract class NowplayingState extends Equatable {
  const NowplayingState();

  @override
  List<Object> get props => [];
}

class NowplayingInitial extends NowplayingState {}

class NowplayingLoading extends NowplayingState {}

class NowplayingFailed extends NowplayingState {
  final String error;

  const NowplayingFailed(this.error);

  @override
  List<Object> get props => [error];
}

class NowplayingSuccess extends NowplayingState {
  final NowPlayingModel nowplaying;

  const NowplayingSuccess(this.nowplaying);

  @override
  List<Object> get props => [nowplaying];
}
