import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Razorpay _razorpay;

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
      'key': 'rzp_test_gkzdrDk3kA9koU',
      'amount': 12000 * 100,
      'name': 'LearnCodeOnline INC.',
      'description': 'JavaScript Course',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Success" + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Error" + response.code.toString() + " " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External wallet" + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Integration"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image(
              width: double.infinity,
              height: 250,
              image: NetworkImage(
                "https://learnyst.s3.amazonaws.com/assets/schools/2410/courses/20812/js_h086z.png",
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "JavaScript Course Price Rs.999",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: MaterialButton(
                onPressed: () {
                  openCheckout();
                },
                child: Text("Buy Now"),
                height: 50,
                minWidth: 270,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
