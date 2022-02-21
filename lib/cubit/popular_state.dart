part of 'popular_cubit.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularFailed extends PopularState {
  final String error;

  const PopularFailed(this.error);

  @override
  List<Object> get props => [error];
}

class PopularSuccess extends PopularState {
  final PopularModel popular;

  const PopularSuccess(this.popular);

  @override
  List<Object> get props => [popular];
}
