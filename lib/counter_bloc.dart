import 'package:bloc/bloc.dart';

//abstract kelas counter
abstract class CounterEvent {}

//bikin event counter penjumlahan angka
class CounterIncrement extends CounterEvent {}

//bikin event counter penjumlahan angka
class CounterDecrement extends CounterEvent {}

//bikin class yang mengextends bloc
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrement>(((event, emit) => emit(state + 1)));
    on<CounterDecrement>((event, emit) => emit(state - 1));
  }
}
