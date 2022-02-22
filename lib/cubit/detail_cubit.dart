import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/models/detail_model.dart';
import 'package:flutter_movie/services/service.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());

  Future<void> getDetail(String id) async {
    try {
      emit(DetailLoading());
      DetailModel detail = await Service().getDetail(id);
      emit(DetailSuccess(detail));
    } catch (e) {
      emit(DetailFailed(e.toString()));
    }
  }
}
