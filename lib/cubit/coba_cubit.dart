import 'package:bloc/bloc.dart';
import 'package:flutter_state_management/dummy/news_data.dart';
import 'package:meta/meta.dart';

part 'coba_state.dart';

class CobaCubit extends Cubit<CobaState> {
  CobaCubit() : super(CobaInitial());

  void getNews(int statusCode) {
    emit(CobaLoading());
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (statusCode == 200) {
        emit(CobaSuccess(berita));
      } else {
        emit(CobaFailed('gagal'));
      }
    });
  }
}
