import 'package:dev_pay/models/payment_detail.dart';
import 'package:dev_pay/payment_manager.dart';
import 'package:dev_pay/rest_client.dart';

class Config {
  late String accountId;
  late String accessKey;
  late bool sandbox = false;
  late bool debug = false;

  Config(String accountId, String accessKey) {
    this.accountId = accountId;
    this.accessKey = accessKey;
  }
}

class DevPayClient {
  late Config config;

  late PaymentManager manager;

  DevPayClient(Config config) {
    this.config = config;
    RestClient client = paymentManagerRestClient();
    manager = PaymentManager(client);
    manager.config = config;
  }

  Future<bool> confirmPayment(PaymentDetail paymentDetail) async {
    return manager.confirmPayment(paymentDetail);
  }

  RestClient paymentManagerRestClient(){
    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";

    String baseURL = "https://api.devpay.io";
    RestClient client = new RestClient(baseURL, headers, config.debug);
    client.debug = config.debug;
    return client;
  }

}
