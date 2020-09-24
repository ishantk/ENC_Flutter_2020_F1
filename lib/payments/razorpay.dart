import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RazorPayCheckoutPage extends StatefulWidget {

  int amount;

  RazorPayCheckoutPage({Key key, @required this.amount}) : super(key: key);

  @override
  _RazorPayCheckoutPageState createState() => _RazorPayCheckoutPageState();
}

class _RazorPayCheckoutPageState extends State<RazorPayCheckoutPage> {

  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RazorPay CheckOut'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(onPressed: openCheckout, child: Text('Make Payment'))
                ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': widget.amount,
      'name': 'Food Delivery App',
      'description': 'Payment For Food',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    Fluttertoast.showToast(
        msg: "SUCCESS: "+response.paymentId,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

    Navigator.pop(context, "SUCCESS "+response.paymentId);

  }

  void _handlePaymentError(PaymentFailureResponse response) {

    Fluttertoast.showToast(
        msg: "ERROR: "+response.code.toString()+" - "+response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    Navigator.pop(context, "ERROR "+response.message);

  }

  void _handleExternalWallet(ExternalWalletResponse response) {

    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: "+ response.walletName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );

    Navigator.pop(context, "WALLET "+response.walletName);

  }

}
