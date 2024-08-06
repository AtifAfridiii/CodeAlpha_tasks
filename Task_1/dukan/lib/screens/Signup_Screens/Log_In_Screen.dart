import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/components/Round_Button.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/HomeScreens/Home_Screen.dart';
import 'package:dukan/screens/passoward/Forgot_Passoward.dart';
import 'package:dukan/screens/seller_Screens/seller_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FFormkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passowardController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  void dispose() {
    emailController.dispose();
    passowardController.dispose();
    super.dispose();
  }

  void _LoginUser() async {
    if (FFormkey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
      );
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passowardController.text.trim(),
        );

        DataSnapshot userSnapshot = await FirebaseDatabase.instance
            .ref('Account type')
            .child('users')
            .child(userCredential.user!.uid)
            .get();

        if (userSnapshot.value != null) {
          Map<dynamic, dynamic> userData =
              userSnapshot.value as Map<dynamic, dynamic>;
          String role = userData['role'] as String;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userRole', role);

          Navigator.of(context).pop();

          if (role == 'buyer') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (role == 'seller') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Seller_Screen()),
            );
          }

          Utilis().ToastMessage('Login Successfully');
        } else {
          Navigator.of(context).pop();
          Utilis().ToastMessage('User data not found.');
        }
      } on FirebaseAuthException catch (error) {
        Navigator.of(context).pop();
        Utilis().ToastMessage(error.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Form(
              key: FFormkey,
              child: Column(
                children: [
                  const Gap(41),
                  Row(
                    children: [
                      const Gap(31),
                      Text(
                        'Log into',
                        style: GoogleFonts.aboreto(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Gap(11),
                  Row(
                    children: [
                      const Gap(31),
                      Text(
                        'your  account',
                        style: GoogleFonts.aboreto(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Gap(31),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email adress',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Email ';
                      }
                      return null;
                    },
                  ),
                  const Gap(51),
                  Consumer<Loading>(
                    builder: (context, val, child) {
                      return TextFormField(
                        obscureText: val.toggle,
                        controller: passowardController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: 'Passoward',
                            suffixIcon: InkWell(
                                onTap: () {
                                  val.settoggle();
                                },
                                child: val.toggle
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Passoward';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const Gap(21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassoward(),
                                ));
                          },
                          child: const Text('Forgot Passoward?')),
                    ],
                  ),
                  const Gap(31),
                  RoundButton(
                      title: 'Log in',
                      color: ISDark ? Colors.deepPurple : Colors.black,
                      ontap: () {
                        _LoginUser();
                      }),
                  const Gap(31),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign Up',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
