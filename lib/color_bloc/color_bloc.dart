import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_firebase/color_bloc/color_state.dart';
import 'package:learn_bloc_firebase/counter_bloc/counter_event.dart';

class ColorBloc extends Bloc<CounterEvent, ColorState> {
  ColorBloc() : super(ColorInitialState()) {
    on<CounterIncrementEvent>((event, emit) {
      emit(ColorIncrementState(Colors.green));
    });

    on<CounterDecrementEvent>((event, emit) {
      emit(ColorDecrementState(Colors.red));
    });
  }
}
