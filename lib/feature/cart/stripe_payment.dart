import 'dart:convert';
import 'package:MyShoppingList/common/constant/env.dart';
import 'package:MyShoppingList/feature/authentication/resource/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:http/http.dart' as http;

class StripePayment extends StatefulWidget {
  StripePayment({Key key}) : super(key: key);

  @override
  _StripePaymentState createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  bool isLoading = false;
  String postCreateIntentURL = "";
  bool finish = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> inputFormKey = GlobalKey<FormState>();
  final StripeCard card = StripeCard();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  final Stripe stripe = Stripe(
    "pk_test_51HRKj6LPVmcKPAahMAqPUJNS3FoeUgIqMrIidVL87ehnUHZv7yCsyFoc1GGeIwDCSdtGJRhbfOvzcHIsBNMDjfSN00aDXxeAAC", //Your Publishable Key
    stripeAccount:
        "acct_1HRektGrGyr9XZMS", //Merchant Connected Account ID. It is the same ID set on server-side.
    returnUrlForSca: "stripesdk://3ds.stripesdk.io", //Return URL for SCA
  );

  @override
  void initState() {
    super.initState();
    postCreateIntentURL =
        RepositoryProvider.of<Env>(context).baseUrl + "/orders";
  }

  @override
  Widget build(BuildContext context) {
    if (finish) {
      Navigator.pop(context, true);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Payment"),
      ),
      body: new SingleChildScrollView(
        child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: Column(
              children: [
                CardForm(formKey: formKey, card: card),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Delivered To ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Form(
                    key: inputFormKey,
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                decoration: InputDecoration(
                                  labelText: "City",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                controller: _cityController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "City required!";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Address",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                controller: _addressController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Address required!";
                                  }
                                  return null;
                                })
                          ],
                        ))),
                Container(
                  child: !isLoading
                      ? RaisedButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child:
                              const Text('Buy', style: TextStyle(fontSize: 20)),
                          onPressed: () {
                            formKey.currentState.save();
                            inputFormKey.currentState.save();
                            if (formKey.currentState.validate() &&
                            inputFormKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              buy(context);
                            }
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buy(context) async {
    final StripeCard stripeCard = card;
    final String customerEmail = getCustomerEmail();

    if (!stripeCard.validateCVC()) {
      showAlertDialog(context, "Error", "CVC not valid.");
      return;
    }
    if (!stripeCard.validateDate()) {
      showAlertDialog(context, "Errore", "Date not valid.");
      return;
    }
    if (!stripeCard.validateNumber()) {
      showAlertDialog(context, "Error", "Number not valid.");
      return;
    }

    Map<String, dynamic> paymentIntentRes =
        await createPaymentIntent(stripeCard, customerEmail);
    print("payment Intent res: $paymentIntentRes");
    String clientSecret = paymentIntentRes['client_secret'];
    String paymentMethodId = paymentIntentRes['payment_method'];
    String status = paymentIntentRes['status'];

    if (status == 'requires_action') //3D secure is enable in this card
      paymentIntentRes =
          await confirmPayment3DSecure(clientSecret, paymentMethodId);

    if (paymentIntentRes['status'] != 'succeeded') {
      showAlertDialog(context, "Warning", "Canceled Transaction.");
      return;
    }

    if (paymentIntentRes['status'] == 'succeeded') {
      showAlertDialog(context, "Success", "Thanks for buying!", true);
      return;
    }
    showAlertDialog(
        context, "Warning", "Transaction rejected.\nSomething went wrong");
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      StripeCard stripeCard, String customerEmail) async {
    String clientSecret;
    Map<String, dynamic> paymentIntentRes, paymentMethod;
    try {
      paymentMethod = await stripe.api.createPaymentMethodFromCard(stripeCard);
      clientSecret =
          await postCreatePaymentIntent(customerEmail, paymentMethod['id']);
      paymentIntentRes = await stripe.api.retrievePaymentIntent(clientSecret);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showAlertDialog(context, "Error", "Something went wrong.");
    }
    return paymentIntentRes;
  }

  Future<String> postCreatePaymentIntent(
      String email, String paymentMethodId) async {
    String clientSecret;
    var token =
        await RepositoryProvider.of<UserRepository>(context).fetchToken();
    http.Response response = await http.post(
      postCreateIntentURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'Address': _addressController.text.toString(),
        'payment_method_id': paymentMethodId,
        'City': _cityController.text.toString()
      }),
    );
    return response.body;
  }

  Future<Map<String, dynamic>> confirmPayment3DSecure(
      String clientSecret, String paymentMethodId) async {
    Map<String, dynamic> paymentIntentRes_3dSecure;
    try {
      await stripe.confirmPayment(clientSecret,
          paymentMethodId: paymentMethodId);
      paymentIntentRes_3dSecure =
          await stripe.api.retrievePaymentIntent(clientSecret);
    } catch (e) {
      showAlertDialog(context, "Error", "Something went wrong.");
    }
    return paymentIntentRes_3dSecure;
  }

  String getCustomerEmail() {
    String customerEmail;
    //Define how to get this info.
    // -Ask to the customer through a textfield.
    // -Get it from firebase Account.
    customerEmail = "alessandro.berti@me.it";
    return customerEmail;
  }

  showAlertDialog(BuildContext context, String title, String message,
      [bool success]) {
    success ??= false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (success) {
                    setState(() {
                      finish = true;
                    });
                  }
                  // dismiss dialog
                }),
          ],
        );
      },
    );
  }
}
