# Devpay flutter SDK
A Flutter SDK for Devpay Payment Gateway Get your API Keys at https://devpay.io

## Integration

Add dev_pay dependency in pubsec.yaml
```shell
  dev_pay:
    git: https://github.com/DevpayInc/devpay-flutter-sdk

```


## Make payment
### Using built-in UI
#### Showing the payment UI
Devpay SDK provided handy UI to get payment inputs, please refer below code.
```dart
devpay.Config config = new devpay.Config("ACC_ID",
    "ACCESS_KEY");
config.debug = true;
config.sandbox = true;
devpay.DevpayModal devpayModal = devpay.DevpayModal(config: config, amount: 100);
devpayModal.btnText = "PAY "+amountTfController.text+" \$";
devpayModal.onCompletion = (intent,error) {

    if (error != null) {
    print("Err - "+error.toString());
    }

    if (status != null && status== true) {
        print("Payment successful");
        devpayModal.dismiss(context);
    }
};
devpayModal.show(context);

```
> Amount is mandatory inputs, please make sure its provided correctly

#### Set Custom Pay title
By default inbuilt UI shows pay button text as 'PAY', you can change the text as required. Below snippets gives an example to do so. 
```java
devpayModal.btnText =  "PAY <AMOUNT> $";
```

### Using Devpay APIs with your own UI
In-case you want to use own UI to get payment details from the user, you are free to do so. Use below APIs to create payment details form your custom UI & confirm the payment.
```dart
BillingAddress address =
    BillingAddress("street",
    "city",
    "zipTf",
    "state",
    "country");

devpay.Card card =
    devpay.Card("XXXXYYYYXXXXYYYY",
            "MM", 
            "YYYY", 
            "123");

devpay.PaymentDetail paymentDetail = new devpay.PaymentDetail(
    "name",
    <amount>,
    card,
    address);

devpay.Config config = ...;
devpay.DevPayClient client = new devpay.DevPayClient(config);

client.confirmPayment(paymentDetail)
    .then((status) => {
        // Use paymentIntent 
    })
    .onError((error, stackTrace) => {
        // Read thee error
});
```
