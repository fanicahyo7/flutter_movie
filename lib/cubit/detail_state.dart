part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailFailed extends DetailState {
  final String error;

  const DetailFailed(this.error);

  @override
  List<Object> get props => [error];
}

class DetailSuccess extends DetailState {
  final DetailModel detail;

  const DetailSuccess(this.detail);

  @override
  List<Object> get props => [detail];
}
