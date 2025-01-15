import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statckmod_app/constants/constants.dart';
import 'package:statckmod_app/feature/auth%20registraction/provider/auth_profile_reg_provider.dart';

import '../../../widgets/widgets.dart';

class AuthProfileReg extends StatelessWidget {
  const AuthProfileReg({super.key});

  void _profileReg(BuildContext context) async {
    final _provider =
        Provider.of<AuthProfileRegProvider>(context, listen: false);
    await _provider.profileReg();

    if (_provider.isProfileReg == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Registration'),
      ),
      body: Form(
        key: formKey,
        child: Consumer<AuthProfileRegProvider>(
            builder: (context, provider, child) {
          if (provider.profileRegError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(provider.profileRegError!)));
          }
          return ListView(
            children: [
              vSizedBox2,
              CircleAvatar(
                  radius: 50,
                  backgroundImage: provider.image?.image,
                  child: provider.image == null
                      ? IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            // provider.getImage();
                          },
                        )
                      : null),
              vSizedBox2,
              Text(Kstrings.provideYourName),
              vSizedBox1,
              appTextFields(
                hintText: Kstrings.name,
                keyboardType: TextInputType.text,
                icon: Icons.person,
                obscureText: false,
                onChanged: (value) {
                  provider.setName(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return Kstrings.nameIsEmpty;
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _profileReg(context);
                  },
                  child: Text(Kstrings.registerButton2))
            ],
          );
        }),
      ),
    );
  }
}
