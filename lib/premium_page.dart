import 'package:flutter/material.dart';
import 'payment_service.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  final PaymentService _paymentService = PaymentService();

  @override
  void initState() {
    super.initState();
    _paymentService.initialize().then((_) {
      // Assuming initialize() successfully fetches productDetails
      // _productDetails is now accessible directly
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Content'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _paymentService.productDetails != null // Check if productDetails is available
              ? () {
            _paymentService.buyPremiumContent(_paymentService.productDetails); // Pass productDetails
          }
              : null, // Disable the button if productDetails is null
          child: const Text('Buy Premium Content'),
        ),
      ),
    );
  }
}