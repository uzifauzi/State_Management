part of 'coba_cubit.dart';

@immutable
abstract class CobaState {}

class CobaInitial extends CobaState {}

class CobaLoading extends CobaState {}

class CobaFailed extends CobaState {
  final String message;

  CobaFailed(this.message);
}

class CobaSuccess extends CobaState {
  final List<NewsModel> news;
  CobaSuccess(this.news);
}
