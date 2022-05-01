import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloc/page/login_page.dart';

import 'bloc/counter_cubit.dart';
import 'bloc/login/check_login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckLoginCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final CounterCubit counterCubit = CounterCubit();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Push The Button For Change the Number'),
            const SizedBox(height: 10),
            BlocBuilder<CounterCubit, int>(
              bloc: counterCubit,
              builder: (context, int state) {
                return Text(
                  state.toString(),
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            const SizedBox(height: 10),
            RaisedButton(onPressed: () => counterCubit.increment(), child: Text('Increment')),
            const SizedBox(height: 1),
            RaisedButton(onPressed: () => counterCubit.decrement(), child: Text('Decrement')),
          ],
        ),
      ),
    );
  }
}
