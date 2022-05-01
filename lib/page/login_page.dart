import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/check_login_cubit.dart';
import '../bloc/login/check_login_event.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: BlocConsumer<CheckLoginCubit, CheckLoginEvent>(
          listener: (context, CheckLoginEvent state) {
            if (state is CheckLoginFetched) {
              if (state.isLogin) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            }
          },
          builder: (context, CheckLoginEvent state) {
            if (state is CheckLoginLoading) {
              return const CircularProgressIndicator();
            } else {

              return RaisedButton(
                onPressed: () {
                  context.read<CheckLoginCubit>().signIn();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.login),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Login'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
