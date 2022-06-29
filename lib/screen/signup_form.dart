import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screen/home_screen.dart';
import 'package:shoppy/widget/custom_loader.dart';
import '../../../constant.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';
import '../model/user.dart';
import '../services/authentication_service.dart';
import '../services/firestore_service.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formkey = GlobalKey<FormState>();
  final fname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPass = TextEditingController();
  final auth = AuthenticationService();
  final db = FirestoreService();
  bool obscureText = true;
  void get onIconToggle => setState(() => obscureText = !obscureText);
  IconData get icon => !obscureText ? Icons.visibility : Icons.visibility_off;
  bool isLoading = false;

  Future<User?> signUp() async {
    final userInfo = UserModel(fullname: fname.text, email: email.text);
    try {
      setState(() => isLoading = true);
      final user = await auth.signup(email.text, password.text);
      if (user != null) {
        await db.saveUserInfo(userInfo);
      }
      return user;
    } on SocketException catch (_) {
      setState(() => isLoading = false);
      showSnackbar(context, noConnection);
      rethrow;
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
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Material(
                    shape: textFieldDecoration,
                    child: CustomTextfield(
                        controller: fname,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: lightGreen,
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Field is required' : null,
                        hintText: 'Full name'),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    shape: textFieldDecoration,
                    child: CustomTextfield(
                        controller: email,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: lightGreen,
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Field is required' : null,
                        hintText: 'Email'),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    shape: textFieldDecoration,
                    child: CustomTextfield(
                        controller: phone,
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                          color: lightGreen,
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Field is required' : null,
                        hintText: 'Phone number'),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    shape: textFieldDecoration,
                    child: CustomTextfield(
                      controller: password,
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: lightGreen),
                      suffixIcon: IconButton(
                          onPressed: () => onIconToggle, icon: Icon(icon)),
                      obscureText: obscureText,
                      validator: (val) =>
                          val!.isEmpty ? 'Field is required' : null,
                      onChanged: (val) => setState(() {}),
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    shape: textFieldDecoration,
                    child: CustomTextfield(
                        controller: confirmPass,
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: lightGreen),
                        suffixIcon: IconButton(
                            onPressed: () => onIconToggle, icon: Icon(icon)),
                        obscureText: obscureText,
                        validator: (val) => !val!.contains(password.text)
                            ? 'Password does not match'
                            : null,
                        hintText: 'Confirm password'),
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: CustomButton(
                      onPressed: () => signUp().then((user) {
                        if (user != null) {
                          pushReplacement(context, const HomeScreen());
                        }
                      }),
                      child:
                          CustomLoader(isLoading: isLoading, text: 'Sign up'),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
