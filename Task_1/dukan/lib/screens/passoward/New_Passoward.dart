import 'package:dukan/components/Back_Button.dart';
import 'package:dukan/components/Round_Button.dart';
import 'package:dukan/screens/HomeScreens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

final _formkey = GlobalKey<FormState>();

class CreatePassoward extends StatefulWidget {
  const CreatePassoward({super.key});

  @override
  State<CreatePassoward> createState() => _CreatePassowardState();
}

class _CreatePassowardState extends State<CreatePassoward> {
  final passowardController = TextEditingController();
  final passowardController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Back_Button(
          onpressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Gap(31),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Create new password',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(31),
                const Text(
                    'Your new password must be different from previously used password'),
                const Gap(51),
                TextFormField(
                  controller: passowardController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      hintText: 'New Passoward',
                      suffixIcon: Icon(Icons.visibility)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter new passoward';
                    }
                    return null;
                  },
                ),
                const Gap(51),
                TextFormField(
                  controller: passowardController2,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      hintText: 'Confirm Passoward',
                      suffixIcon: Icon(Icons.visibility)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your passoward';
                    }
                    return null;
                  },
                ),
                const Gap(51),
                RoundButton(
                  title: 'Confirm',
                  color: Colors.black,
                  ontap: () {
                    if (_formkey.currentState!.validate()) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            children: [
                              const Gap(11),
                              Container(
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: const BoxDecoration(),
                                child: SvgPicture.asset(
                                  'Assets/images/suc.svg',
                                  color: Colors.green,
                                ),
                              ),
                              const Gap(21),
                              const Text(
                                'Your password has been changed',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const Gap(21),
                              const Text(
                                'Welcome back! Discover now!',
                                style: TextStyle(color: Colors.black54),
                              ),
                              const Gap(21),
                              RoundButton(
                                  title: 'Browse home',
                                  color: Colors.black,
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ));
                                  })
                            ],
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
