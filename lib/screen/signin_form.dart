import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/model/user.dart';
import 'package:shoppy/screen/home_screen.dart';
import 'package:shoppy/widget/custom_loader.dart';
import '../../../constant.dart';
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
  final fullname = TextEditingController();
  final confirmPass = TextEditingController();
  final signInEmail = TextEditingController();
  final signUpEmail = TextEditingController();
  final signInPassword = TextEditingController();
  final signUpPassword = TextEditingController();
  final auth = AuthenticationService();
  final firestore = FirestoreService();
  final key = GlobalKey<FormState>();

  int selectedIndex = 0;
  Color getColor(int i) => selectedIndex == i ? primaryColor : Colors.grey;
  bool obscureText = true;
  void get onIconToggle => setState(() => obscureText = !obscureText);
  IconData get icon => !obscureText ? Icons.visibility : Icons.visibility_off;
  bool isLoading = false;

  Future<User?> authenticateUser() async {
    try {
      setState(() => isLoading = true);
      if (selectedIndex == 0) {
        return await auth.login(signInEmail.text, signInPassword.text);
      } else {
        final user = await auth.signup(signUpEmail.text, signUpPassword.text);
        await firestore.saveUserInfo(UserModel(
            id: user!.uid,
            fullname: fullname.text,
            email: signUpEmail.text,
            isAdmin: true));
        return user;
      }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
              minimum: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                  child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              padding: 0,
                              text: 'SIGN IN',
                              onPressed: () =>
                                  setState(() => selectedIndex = 0),
                              color: getColor(0),
                              height: 45,
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              padding: 0,
                              text: 'CREATE ACCOUNT',
                              onPressed: () =>
                                  setState(() => selectedIndex = 1),
                              color: getColor(1),
                              height: 45,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    selectedIndex == 0 ? buildLoginForm() : buildSignUpForm(),
                    const SizedBox(height: 70),
                    Center(
                      child: CustomButton(
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              await authenticateUser().then((user) {
                                if (user != null) {
                                  push(context, const HomeScreen());
                                }
                              });
                            }
                          },
                          child: CustomLoader(
                              isLoading: isLoading,
                              text: selectedIndex == 0
                                  ? 'Login'
                                  : 'Create Account')),
                    )
                  ],
                ),
              )))),
    );
  }

  Widget buildLoginForm() => Column(
        children: [
          Material(
            shape: textFieldDecoration,
            child: CustomTextfield(
                key: ValueKey(signInEmail),
                controller: signInEmail,
                validator: (val) => val!.isEmpty ? 'Field is required' : null,
                prefixIcon:
                    const Icon(Icons.person_outline, color: primaryColor),
                hintText: 'Email'),
          ),
          const SizedBox(height: 16),
          Material(
            shape: textFieldDecoration,
            child: CustomTextfield(
              key: ValueKey(signInPassword),
              controller: signInPassword,
              prefixIcon: const Icon(Icons.lock_outline, color: primaryColor),
              validator: (val) => val!.isEmpty ? 'Field is required' : null,
              hintText: 'Password',
              suffixIcon:
                  IconButton(onPressed: () => onIconToggle, icon: Icon(icon)),
              obscureText: obscureText,
            ),
          ),
        ],
      );
  Widget buildSignUpForm() => Column(
        children: [
          Material(
            shape: textFieldDecoration,
            child: CustomTextfield(
                key: ValueKey(fullname),
                controller: fullname,
                prefixIcon:
                    const Icon(Icons.person_outline, color: primaryColor),
                validator: (val) => val!.isEmpty ? 'Field is required' : null,
                hintText: 'Full name'),
          ),
          const SizedBox(height: 16),
          Material(
            shape: textFieldDecoration,
            child: CustomTextfield(
                key: ValueKey(signUpEmail),
                controller: signUpEmail,
                prefixIcon:
                    const Icon(Icons.person_outline, color: primaryColor),
                validator: (val) => val!.isEmpty ? 'Field is required' : null,
                hintText: 'Email'),
          ),
          const SizedBox(height: 16),
          Material(
            shape: textFieldDecoration,
            child: CustomTextfield(
              key: ValueKey(signUpPassword),
              controller: signUpPassword,
              prefixIcon: const Icon(Icons.lock_outline, color: primaryColor),
              hintText: 'Password',
              validator: (val) => val!.isEmpty ? 'Field is required' : null,
              suffixIcon:
                  IconButton(onPressed: () => onIconToggle, icon: Icon(icon)),
              obscureText: obscureText,
            ),
          ),
          const SizedBox(height: 16),
          Material(
            shape: textFieldDecoration,
            child: CustomTextfield(
              key: ValueKey(confirmPass),
              controller: confirmPass,
              prefixIcon: const Icon(Icons.lock_outline, color: primaryColor),
              hintText: 'Confirm password',
              validator: (val) => !val!.contains(signUpPassword.text)
                  ? 'Password does not match'
                  : null,
              suffixIcon:
                  IconButton(onPressed: () => onIconToggle, icon: Icon(icon)),
              obscureText: obscureText,
            ),
          ),
        ],
      );
}
