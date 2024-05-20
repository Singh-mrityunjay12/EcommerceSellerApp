import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'SUCCESS PAYMENT: ${response.paymentId}', timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'ERROR HERE : ${response.code} - ${response.message}',
        timeInSecForIosWeb: 4);
  }

  void _handlePaymentWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'EXTERNAL_WALLET IS: ${response.walletName}',
        timeInSecForIosWeb: 4);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    super.initState();
  }

  void makePayment() async {
    var option = {
      'key': 'rzp_test_7GWkbPV8QWSA5r',
      'amount': 100, //1 Rs
      'name': 'Mrityunjay',
      'description': 'iphone',
      'prefill': {
        'contact': '+916386160985',
        'email': 'singhmrityunjay511@gmail.com'
      },
    };
    try {
      _razorpay?.open(option);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment By Razarpay'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Image.network(
                  'https://www.91-img.com/gallery_images_uploads/a/4/a4cd5ffe4c9a8bd71731aee7b5541f6ec071653f.jpg?tr=h-630,c-at_max,q-80'),
              title: const Text("Apple 15 max pro"),
              subtitle: const Text('Sell your kindlay'),
              trailing: ElevatedButton(
                  onPressed: () {
                    makePayment();
                  },
                  child: const Text('Buy Now')),
            ),
          )
        ],
      ),
    );
  }
}

// rzp_test_7GWkbPV8QWSA5r
