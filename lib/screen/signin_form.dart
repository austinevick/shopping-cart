import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screen/home_screen.dart';
import 'package:shoppy/widget/custom_loader.dart';
import '../../../constant.dart';
import '../../../model/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/firestore_service.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final password = TextEditingController();
  final email = TextEditingController();
  final auth = AuthenticationService();
  final db = FirestoreService();

  bool obscureText = true;
  void get onIconToggle => setState(() => obscureText = !obscureText);
  IconData get icon => !obscureText ? Icons.visibility : Icons.visibility_off;
  bool isLoading = false;

  Future<User?> signIn() async {
    try {
      setState(() => isLoading = true);
      final user = await auth.login(email.text, password.text);
      if (user != null) {
        ///
      }
      return user;
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      showSnackbar(context, e.message!);
      rethrow;
    } catch (_) {
      setState(() => isLoading = false);
      showSnackbar(context, somethingWentWrong);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign in')),
        body: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Material(
                  shape: textFieldDecoration,
                  child: CustomTextfield(
                      controller: email,
                      prefixIcon:
                          const Icon(Icons.person_outline, color: lightGreen),
                      hintText: 'Email'),
                ),
                const SizedBox(height: 16),
                Material(
                  shape: textFieldDecoration,
                  child: CustomTextfield(
                    controller: password,
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: lightGreen),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () => onIconToggle, icon: Icon(icon)),
                    obscureText: obscureText,
                  ),
                ),
                const SizedBox(height: 70),
                Center(
                  child: CustomButton(
                      onPressed: () => signIn().then((user) {
                            if (user != null) {
                              push(context, const HomeScreen());
                            }
                          }),
                      child: CustomLoader(isLoading: isLoading, text: 'Login')),
                )
              ],
            ))));
  }
}
