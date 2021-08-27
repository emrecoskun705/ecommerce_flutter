import 'dart:io';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/providers/stripe_provider.dart';
import 'package:ecommerce_flutter/screens/components/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

String checkoutSuccessUrl = '$kServerApiURL/stripe/success/';
String checkoutCancelUrl = '$kServerApiURL/stripe/cancel/';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  StripeProvider _stripeProvider = StripeProvider();
  late String url;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _stripeProvider.fetchStripeURL();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _stripeProvider,
      child: Consumer<StripeProvider>(
        builder: (context, data, _) {
          if (data.isLoading) {
            return LoadingScreen();
          } else {
            return buildWebView(data, context);
          }
        },
      ),
    );
  }

  WebView buildWebView(StripeProvider data, BuildContext context) {
    // webview will show user Stripe Checkout page
    return WebView(
      initialUrl: data.stripeURL,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        print(request);
        if (request.url.startsWith(checkoutSuccessUrl)) {
          // success is handled by stripe webhook in django server
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Your order has been successfully created')));
        } else if (request.url.startsWith(checkoutCancelUrl)) {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Your order has been canceled')));
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
