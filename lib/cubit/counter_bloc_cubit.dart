import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_bloc_state.dart';

class CounterBlocCubit extends Cubit<int> {
  CounterBlocCubit() : super(0);

  void increment() => emit(state + 1);
}
