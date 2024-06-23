import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late ProductDetails _productDetails; // Store productDetails here

  Future<void> initialize() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (available) {
      final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails({'premium_content'}.toSet());
      if (response.notFoundIDs.isNotEmpty) {
        // Handle the error.
      } else {
        _productDetails = response.productDetails.first; // Store the productDetails
      }
    }
  }

  Future<void> buyPremiumContent(ProductDetails productDetails) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  // Getter for productDetails
  ProductDetails get productDetails => _productDetails;
}