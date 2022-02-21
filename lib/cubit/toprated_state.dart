part of 'toprated_cubit.dart';

abstract class TopratedState extends Equatable {
  const TopratedState();

  @override
  List<Object> get props => [];
}

class TopratedInitial extends TopratedState {}

class TopratedLoading extends TopratedState {}

class TopratedFailed extends TopratedState {
  final String error;

  const TopratedFailed(this.error);

  @override
  List<Object> get props => [error];
}

class TopratedSuccess extends TopratedState {
  final TopRatedModel toprated;

  const TopratedSuccess(this.toprated);

  @override
  List<Object> get props => [toprated];
}
