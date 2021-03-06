import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplebloc/page/second_page.dart';
import '../bloc/counter_cubit.dart';
import '../bloc/login/check_login_cubit.dart';
import '../bloc/login/check_login_event.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckLoginCubit, CheckLoginEvent>(
      listener: (context, CheckLoginEvent state) {
        if (state is CheckLoginFetched) {
          if (!state.isLogin) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false,
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
          leading: IconButton(
            onPressed: () => context.read<CheckLoginCubit>().signOut(),
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('با دکمه های پایین میتونی عدد رو کم و زیاد کنی'),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder(
                bloc: _counterCubit,
                builder: (context, int state) {
                  return Text(
                    state.toString(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  child: const Center(
                    child: Text('go to second page'),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _counterCubit,
                          child: SecondPage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => _counterCubit.increment(),
              backgroundColor: Colors.green,
              heroTag: null,
              child: const Center(
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () => _counterCubit.decrement(),
              backgroundColor: Colors.red,
              heroTag: null,
              child: const Center(
                child: Icon(
                  Icons.remove,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}
