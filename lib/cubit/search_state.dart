part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchFailed extends SearchState {
  final String error;

  const SearchFailed(this.error);

  @override
  List<Object> get props => [error];
}

class SearchSuccess extends SearchState {
  final SearchModel search;

  const SearchSuccess(this.search);

  @override
  List<Object> get props => [search];
}
