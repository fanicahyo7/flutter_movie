import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/search_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> search(String query) async {
    try {
      emit(SearchLoading());
      SearchModel search = await Service().searchVideo(query);
      emit(SearchSuccess(search));
    } catch (e) {
      emit(SearchFailed(e.toString()));
    }
  }
}
