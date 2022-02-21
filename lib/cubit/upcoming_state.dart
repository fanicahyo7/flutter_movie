part of 'upcoming_cubit.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object> get props => [];
}

class UpcomingInitial extends UpcomingState {}

class UpcomingLoading extends UpcomingState {}

class UpcomingFailed extends UpcomingState {
  final String error;

  const UpcomingFailed(this.error);
  @override
  List<Object> get props => [error];
}

class UpcomingSuccess extends UpcomingState {
  final UpComingModel upcoming;

  const UpcomingSuccess(this.upcoming);
  @override
  List<Object> get props => [upcoming];
}
