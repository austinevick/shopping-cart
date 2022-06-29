import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screen/home_screen.dart';
import 'package:shoppy/screen/signin_form.dart';

import '../services/authentication_service.dart';

class AuthStateChangeScreen extends StatelessWidget {
  const AuthStateChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthenticationService().auth,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const SignInForm();
        }));
  }
}
