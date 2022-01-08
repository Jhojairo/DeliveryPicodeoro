import 'dart:convert';

import 'package:pico_de_oro/src/models/stripe_transaction_response.dart';
import 'package:pico_de_oro/src/utils/my_snackbar.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StripeProvider {
  String secret = 'sk_test_51KCSR2CGlvKUGkSUO0fsPrnRYXj84Sm31f0Zv8fxCATUzQS4WR1vwOojOLYmx5bKN6DklDua90lsPJz6WKCebhE8005xhBBq7Z';


  Map <String, String> headers = {
    'Authorization': 'Bearer sk_test_51KCSR2CGlvKUGkSUO0fsPrnRYXj84Sm31f0Zv8fxCATUzQS4WR1vwOojOLYmx5bKN6DklDua90lsPJz6WKCebhE8005xhBBq7Z',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  BuildContext context;

  void init(BuildContext context) {
    this.context = context;
    StripePayment.setOptions(StripeOptions
      (
        publishableKey: 'pk_test_51KCSR2CGlvKUGkSU6rBuUU9KV16ZLya2Hojr8Z3dUJCGcvLfmyJaPyPXNSmo8bzyPjA4x4Oayp4HmitVcUZhdvis00zJtTnaoR',
        merchantId: 'test',
        androidPayMode: 'test'


    ));
  }

  Future <StripeTransactionResponse> payWhitCard(String amount, String currency) async{
    try{
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
      var paymentIntent = await  createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id


      ));
      if(response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaccion exitosa',
            success: true,
            paymentMethod: paymentMethod

        );
      }
      else {
        return new StripeTransactionResponse(
            message: 'Transaccion fallo',
            success: false

        );
      }

    }
    catch(e){
      print('Error al realizar la transaccion $e');
      MySnackbar.show(context, 'Error al realizar la transaccion');
      return null;

    }


  }

  Future <Map<String,  dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]' : 'card'
      };
      Uri uri= Uri.https('api.stripe.com', 'v1/payment_intents');
      var response = await http.post(uri,body: body, headers: headers  );
      return jsonDecode(response.body);
    }
    catch(e){
      print('Error al crear intento de pago  $e');
      return null;

    }

  }

}




























