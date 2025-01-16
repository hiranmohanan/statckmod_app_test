import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:statckmod_app/constants/constants.dart';
import 'package:statckmod_app/feature/auth%20login/provider/auth_login_provider.dart';

import '../../../widgets/widgets.dart';

class AuthLoginView extends StatefulWidget {
  const AuthLoginView({super.key});

  @override
  State<AuthLoginView> createState() => _AuthLoginViewState();
}

class _AuthLoginViewState extends State<AuthLoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() {
      Provider.of<AuthLoginProvider>(context, listen: false)
          .setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      Provider.of<AuthLoginProvider>(context, listen: false)
          .setPassword(_passwordController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final _provider = Provider.of<AuthLoginProvider>(context, listen: false);
    await _provider.login();

    if (_provider.isLogin == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(Kstrings.login),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child:
              Consumer<AuthLoginProvider>(builder: (context, provider, child) {
            provider = Provider.of<AuthLoginProvider>(context, listen: false);
            if (provider.loginerror != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(provider.loginerror!)),
                );
              });
            }
            return SingleChildScrollView(
              child: Column(
                spacing: 10.sp,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Kstrings.email),
                  appTextFields(
                    controller: _emailController,
                    hintText: Kstrings.email,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                    obscureText: false,
                    onChanged: (value) {
                      provider.setEmail(value);
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
                    onPressed: () {
                      provider.setIsObscure();
                    },
                    obscureText: provider.isObscure,
                    onChanged: (value) {
                      provider.setPassword(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  CheckboxListTile(
                    value: provider.isRememberMe,
                    onChanged: (value) {
                      provider.setIsRememberMe();
                    },
                    title: Text(Kstrings.rememberMe),
                  ),
                  TextButton(
                    onPressed: () {
                      provider.forgotPassword();
                    },
                    child: Text(Kstrings.forgotPassword),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: Text(Kstrings.loginButton),
                  ),
                  RichText(
                      text: TextSpan(
                    text: Kstrings.dontHaveAccount,
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: Kstrings.register,
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/signup');
                          },
                      ),
                    ],
                  ))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
