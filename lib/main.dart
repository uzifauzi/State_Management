import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/counter_bloc.dart';
import 'package:flutter_state_management/cubit/coba_cubit.dart';
import 'package:flutter_state_management/cubit/counter_bloc_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = CounterBloc();
  final cubit = CounterBlocCubit();
  final cobaCubit = CobaCubit();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit,
        ),
        BlocProvider(
          create: (context) => bloc,
        ),
        BlocProvider(
          create: (context) => cobaCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CounterBlocCubit, int>(
            listener: (context, state) {
              if (state % 5 == 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Ini angka kelipatan 5',
                )));
              }
            },
          ),
          BlocListener<CobaCubit, CobaState>(
            listener: (context, state) {
              if (state is CobaFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.message,
                )));
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              children: [
                BlocBuilder<CounterBloc, int>(
                  builder: (context, state) {
                    return Text(
                      state.toString(),
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                ),
                BlocBuilder<CounterBlocCubit, int>(
                  builder: (context, state) {
                    return Text(
                      state.toString(),
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                ),
                BlocBuilder<CobaCubit, CobaState>(
                  builder: (context, state) {
                    if (state is CobaLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is CobaSuccess) {
                      return Column(
                          children: state.news
                              .map((data) => Text(data.title))
                              .toList());
                    }
                    return const SizedBox();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    cobaCubit.getNews(200);
                  },
                  child: const Text(
                    'Sukses',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    cobaCubit.getNews(400);
                  },
                  child: const Text(
                    'Gagal',
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(onPressed: () {
                //bloc.add(CounterIncrement());
                cubit.increment();
              }),
              FloatingActionButton(onPressed: (() {
                bloc.add(CounterDecrement());
              }))
            ],
          ),
        ),
      ),
    );
  }
}
