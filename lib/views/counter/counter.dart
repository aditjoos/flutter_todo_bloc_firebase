import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_firebase/bloc/color_bloc/color_bloc.dart';
import 'package:learn_bloc_firebase/bloc/color_bloc/color_state.dart';
import 'package:learn_bloc_firebase/bloc/counter_bloc/counter_bloc.dart';
import 'package:learn_bloc_firebase/bloc/counter_bloc/counter_event.dart';
import 'package:learn_bloc_firebase/bloc/counter_bloc/counter_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Counter BLOC Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ColorBloc, ColorState>(
              builder: (context, state) => Container(
                width: 200,
                height: 200,
                color: state.color,
              ),
            ),
            // BlocSelector<CounterBloc, CounterState, bool>(
            //   selector: (state) => state.counter >= 3 ? true : false,
            //   builder: (context, state) => Center(
            //     child: Container(
            //       color: state ? Colors.green : Colors.red,
            //       width: 200,
            //       height: 200,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 12),
            BlocConsumer<CounterBloc, CounterState>(
              builder: (context, state) => Text(
                state.counter.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              listener: (context, state) {
                if (state.counter >= 5) {
                  Flushbar(
                    title: "It Works!",
                    message: "Current number is: ${state.counter.toString()}",
                    duration: const Duration(seconds: 3),
                  ).show(context);
                }
              },
            ),
            const SizedBox(height: 12),
            // BlocListener<CounterBloc, CounterState>(
            //   listener: (context, state) {
            //     if (state.counter >= 5) {
            //       Flushbar(
            //         title: "It Works!",
            //         message: "Current number is: ${state.counter.toString()}",
            //         duration: const Duration(seconds: 3),
            //       ).show(context);
            //     }
            //   },
            //   child: const Text('Bloc Listener'),
            // ),
            // const SizedBox(height: 12),
            // BlocBuilder<CounterBloc, CounterState>(
            //   // buildWhen: (previous, current) {
            //   //   return current.counter >= 5;
            //   // },
            //   builder: (context, state) => Text(
            //     state.counter.toString(),
            //     style: Theme.of(context).textTheme.headlineMedium,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'fab_1',
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementEvent());
              context.read<ColorBloc>().add(CounterDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            heroTag: 'fab_2',
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
              context.read<ColorBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
