import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/components/Back_Button.dart';
import 'package:dukan/components/Round_Button.dart';
import 'package:dukan/provider/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

final _formkey = GlobalKey<FormState>();

class ForgotPassoward extends StatefulWidget {
  const ForgotPassoward({super.key});

  @override
  State<ForgotPassoward> createState() => _ForgotPassowardState();
}

class _ForgotPassowardState extends State<ForgotPassoward> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  void ResetPassoward() {
    auth.sendPasswordResetEmail(email: emailController.text.toString()).then(
      (value) {
        Utilis().ToastMessage('Send you a link through email ');
      },
    ).onError(
      (error, stackTrace) {
        Utilis().ToastMessage(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        leading: AppBar(
          leading: Back_Button(
            onpressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const Gap(31),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Forgot passoward?',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              const Gap(31),
              const Text(
                  'Enter email associated with your account and we’ll send and email with intructions to reset your password'),
              const Gap(51),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Enter your email ',
                    prefixIcon: Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
              const Gap(51),
              RoundButton(
                title: 'Verify',
                color: ISDark ? Colors.deepPurple : Colors.black,
                ontap: () {
                  if (_formkey.currentState!.validate()) {
                    ResetPassoward();
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
