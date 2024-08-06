import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/components/Round_Button.dart';
import 'package:dukan/components/dropdown.dart';
import 'package:dukan/provider/drop.dart';
import 'package:dukan/provider/loading2%20.dart';
import 'package:dukan/provider/loading3.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/HomeScreens/Home_Screen.dart';
import 'package:dukan/screens/Signup_Screens/Log_In_Screen.dart';
import 'package:dukan/screens/seller_Screens/seller_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final dropKey = UniqueKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passowardController = TextEditingController();
  final passowardController2 = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passowardController.dispose();
    passowardController2.dispose();
    super.dispose();
  }

  void _registerUser() async {
    if (_formkey.currentState!.validate()) {
      if (passowardController.text == passowardController2.text) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        );
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passowardController.text.trim(),
          );

          final selectedValue =
              Provider.of<dropValue>(context, listen: false).Value;

          await FirebaseDatabase.instance
              .ref('Account type')
              .child('users')
              .child(userCredential.user!.uid)
              .set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'role': selectedValue,
          });

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userRole', selectedValue);

          Navigator.of(context).pop();

          if (selectedValue == 'buyer') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            Utilis().ToastMessage(
                'Hello! Welcome to Dukan ${nameController.text.trim()}');
          } else if (selectedValue == 'seller') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Seller_Screen()),
            );
            Utilis().ToastMessage(
                'Hello! Welcome to Dukan ${nameController.text.trim()}');
          } else {
            Utilis().ToastMessage('Please select "Account type" to proceed.');
          }
        } on FirebaseAuthException catch (error) {
          Navigator.of(context).pop();
          Utilis().ToastMessage(error.message.toString());
        }
      } else {
        Utilis().ToastMessage('Passwords do not match');
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
              key: _formkey,
              child: Column(
                children: [
                  const Gap(41),
                  Row(
                    children: [
                      const Gap(31),
                      Text(
                        'Create',
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
                  const Gap(21),
                  Dropdown(
                    buyer: 'buyer',
                    seller: 'seller',
                    key: dropKey,
                  ),
                  const Gap(31),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Name ';
                      }
                      return null;
                    },
                  ),
                  const Gap(51),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email adress',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Email ';
                      }
                      return null;
                    },
                  ),
                  const Gap(51),
                  Consumer<Loading2>(
                    builder: (context, vale, child) {
                      return TextFormField(
                        obscureText: vale.toggle,
                        controller: passowardController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: 'Passoward',
                            suffixIcon: InkWell(
                              onTap: () {
                                vale.settoggle();
                              },
                              child: vale.toggle
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Passoward ';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const Gap(51),
                  Consumer<Loading3>(
                    builder: (context, val, child) {
                      return TextFormField(
                        controller: passowardController2,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: val.toggle,
                        decoration: InputDecoration(
                            hintText: 'Confirm passoward',
                            suffixIcon: InkWell(
                              onTap: () {
                                val.settoggle();
                              },
                              child: val.toggle
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm your Passoward ';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const Gap(31),
                  RoundButton(
                      title: 'Sign Up',
                      color: ISDark ? Colors.deepPurple : Colors.black,
                      ontap: () {
                        _registerUser();
                      }),
                  const Gap(31),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: const Text(
                            'Log In',
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
