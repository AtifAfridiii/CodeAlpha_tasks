import 'package:dukan/components/Back_Button.dart';
import 'package:dukan/components/Round_Button.dart';
import 'package:dukan/screens/passoward/New_Passoward.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class VerifyPassaword extends StatefulWidget {
  const VerifyPassaword({super.key});

  @override
  State<VerifyPassaword> createState() => _VerifyPassawordState();
}

GlobalKey<FormState> formkey = GlobalKey<FormState>();

class _VerifyPassawordState extends State<VerifyPassaword> {
  final ottpController = TextEditingController();
  final validpin = '1221';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          children: [
            const Gap(31),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Verification code',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(31),
            const Text(
                'Please enter the verification code we sent to your email address'),
            const Gap(51),
            _pinput(),
            const Gap(51),
            RoundButton(
              title: 'Verify',
              color: Colors.black,
              ontap: () {
                if (formkey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePassoward(),
                      ));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _pinput() {
    return Form(
      key: formkey,
      child: Pinput(
        errorPinTheme: PinTheme(
            height: MediaQuery.sizeOf(context).height * 0.09,
            width: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(51),
                border: Border.all(
                    strokeAlign: BorderSide.strokeAlignInside,
                    color: Colors.red))),
        autofocus: true,
        focusedPinTheme: PinTheme(
            height: MediaQuery.sizeOf(context).height * 0.09,
            width: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(51),
                border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Colors.green))),
        followingPinTheme: PinTheme(
            height: MediaQuery.sizeOf(context).height * 0.09,
            width: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(51),
                border: Border.all(
                    strokeAlign: BorderSide.strokeAlignInside,
                    color: Colors.black))),
        controller: ottpController,
        defaultPinTheme: PinTheme(
            height: MediaQuery.sizeOf(context).height * 0.09,
            width: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(51), border: Border.all())),
        closeKeyboardWhenCompleted: true,
        isCursorAnimationEnabled: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter the code';
          }
          return value == validpin ? null : 'Pin is incorrect';
        },
        onCompleted: (pin) {
          print('Success$pin');
        },
        errorBuilder: (errorText, pin) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Center(
                child: Text(
              errorText ?? "",
              style: const TextStyle(color: Colors.red),
            )),
          );
        },
      ),
    );
  }
}
