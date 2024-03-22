import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_firebase/counter_bloc/counter_bloc.dart';
import 'package:learn_bloc_firebase/counter_bloc/counter_event.dart';
import 'package:learn_bloc_firebase/counter_bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter BLOC & Firebase',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocSelector<CounterBloc, CounterState, bool>(
              selector: (state) => state.counter >= 3 ? true : false,
              builder: (context, state) => Center(
                child: Container(
                  color: state ? Colors.green : Colors.red,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
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
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
