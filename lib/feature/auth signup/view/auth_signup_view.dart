import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statckmod_app/constants/constants.dart';
import 'package:statckmod_app/feature/auth%20signup/provider/auth_signup_provider.dart';

import '../../../widgets/widgets.dart';

class AuthSignupView extends StatefulWidget {
  const AuthSignupView({super.key});

  @override
  State<AuthSignupView> createState() => _AuthSignupViewState();
}

class _AuthSignupViewState extends State<AuthSignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() {
      Provider.of<AuthSignupProvider>(context, listen: false)
          .setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      Provider.of<AuthSignupProvider>(context, listen: false)
          .setPassword(_passwordController.text);
    });
    _confirmPasswordController.addListener(() {
      Provider.of<AuthSignupProvider>(context, listen: false)
          .setConfirmPassword(_confirmPasswordController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final _provider = Provider.of<AuthSignupProvider>(context, listen: false);
    await _provider.signup();

    if (_provider.isSignup == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(Kstrings.register),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Consumer<AuthSignupProvider>(
                builder: (context, _provider, child) {
              debugPrint('Signup Provider Called ${_provider.isSignup}');
              // if (_provider.isSignup == true) {
              //   debugPrint('Signup Success');
              //   Navigator.pushNamedAndRemoveUntil(
              //       context, '/profile', (route) => false);
              // }
              return Column(
                children: [
                  Text(Kstrings.email),
                  appTextFields(
                    controller: _emailController,
                    hintText: Kstrings.email,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                    obscureText: false,
                    onChanged: (value) {
                      _provider.setEmail(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Kstrings.emailIsEmpty;
                      }
                      if (!value.contains('@')) {
                        return Kstrings.emailNotValid;
                      }

                      if (!value.contains('.')) {
                        return Kstrings.emailNotValid;
                      }
                      return null;
                    },
                  ),
                  Text(Kstrings.password),
                  appPasswordTextFields(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      _provider.setPassword(value);
                    },
                    onPressed: () {
                      _provider.setIsObscure();
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Text(Kstrings.confirmPassword),
                  appPasswordTextFields(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      _provider.setConfirmPassword(value);
                    },
                    onPressed: () {
                      _provider.setIsObscureConfirm();
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  CheckboxListTile(
                    value: _provider.isRememberMe,
                    onChanged: (value) {
                      _provider.setIsRememberMe();
                    },
                    title: Text(Kstrings.rememberMe),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _signup();
                      }
                    },
                    child: Text(Kstrings.registerButton),
                  ),
                  RichText(
                    text: TextSpan(
                      text: Kstrings.alreadyHaveAccount,
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: Kstrings.login,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
