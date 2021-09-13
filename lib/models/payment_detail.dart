import 'billing_address.dart';
import 'card.dart';

class PaymentDetail {
  late int amount;
  late String description = "";
  late String name;
  late BillingAddress billingAddress;
  late Card card;
  Map metaData = new Map();

  PaymentDetail(String name, int amount, Card card,
      BillingAddress billingAddress) {
    this.amount = amount;
    this.name = name;
    this.billingAddress = billingAddress;
    this.card = card;
  }

}
