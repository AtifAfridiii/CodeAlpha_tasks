import 'dart:convert';
import 'package:dukan/strip/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripServices {
  static String apibase = 'https://api.stripe.com/v1';
  static String paymentApiurl = '${StripServices.apibase}/payment_intents';

  static Map<String, String> headers = {
    "Authorization": "Bearer $privatekey",
    "Content-Type": "application/x-www-form-urlencoded",
  };

  static init() {
    Stripe.publishableKey = publishkey;
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse(StripServices.paymentApiurl),
        body: body,
        headers: StripServices.headers,
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('failed to create payement intent');
    }
  }

  static Future<void> initPaymentSheet(String amount, String currency) async {
    try {
      final PaymentIntent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: PaymentIntent['client_secret'],
        merchantDisplayName: 'Atif',
        style: ThemeMode.dark,
      ));
    } catch (e) {
      throw Exception('failed to inailize payement sheet');
    }
  }

  static Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception('failed to present payement sheet');
    }
  }
}
