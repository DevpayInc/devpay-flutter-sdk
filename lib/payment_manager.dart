import 'package:dev_pay/dev_pay.dart';
import 'package:dev_pay/rest_client.dart';

import 'models/payment_detail.dart';

class PaymentManager {
  late RestClient client;
  late Config config;

  PaymentManager(RestClient client) {
    this.client = client;
  }

  Future<bool> confirmPayment(PaymentDetail paymentDetail) async {

    return createIntent(paymentDetail)
           .then((token) => confirmIntent(token, paymentDetail));
  }

  Future<String> createIntent(PaymentDetail paymentDetail) async {

    Map<String, dynamic> cardInfo() => {
      "Number": paymentDetail.card.cardNum,
      "ExpMonth": paymentDetail.card.expiryMonth,
      "ExpYear": paymentDetail.card.expiryYear,
      "Cvv": paymentDetail.card.cvv
    };

    Map<String, dynamic> chargeInfo() => {
      "amount": paymentDetail.amount,
      "fee_amount": 0,
      "description": paymentDetail.description,
      "account_id": config.accountId,
      "secreate_key": config.accessKey
    };

    Map<String, dynamic> chargeInfoObj = chargeInfo();
    if (config.sandbox) {
      chargeInfoObj["environment"] = "sandbox";
    }

    Map<String, dynamic> jsonReqData() => {
      "CardDetails": cardInfo(),
      "ChargeDetails": chargeInfoObj
    };

    var response = await client.post("/v1/charge/create_Intend", jsonReqData());
    return response["token"];
  }

  Future<bool> confirmIntent(String token, PaymentDetail paymentDetail) async {

    Map<String, dynamic> cardInfo() => {
      "Number": paymentDetail.card.cardNum,
      "ExpMonth": paymentDetail.card.expiryMonth,
      "ExpYear": paymentDetail.card.expiryYear,
      "Cvv": paymentDetail.card.cvv,
      "token": token
    };

    Map<String, dynamic> chargeInfo() => {
      "amount": paymentDetail.amount,
      "fee_amount": 0,
      "description": paymentDetail.description,
      "account_id": config.accountId,
      "secreate_key": config.accessKey
    };

    Map<String, dynamic> chargeInfoObj = chargeInfo();
    if (config.sandbox) {
      chargeInfoObj["environment"] = "sandbox";
    }

    Map<String, dynamic> jsonReqData() => {
      "CardDetails": cardInfo(),
      "ChargeDetails": chargeInfoObj
    };
    Map<String, String> headers = new Map();

    var response = await client.post("/v1/charge/confirm_charge", jsonReqData(),headers: headers);
    return (response["status"] == 1);
  }
}
