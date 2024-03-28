import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_firebase/bloc/counter_bloc/counter_event.dart';
import 'package:learn_bloc_firebase/bloc/counter_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc():super(CounterInitialState()) {
    on<CounterIncrementEvent>((event, emit) {
      emit(CounterIncrementState(state.counter + 1));
    });

    on<CounterDecrementEvent>((event, emit) {
      emit(CounterDecrementState(state.counter - 1));
    });
  }
}