import 'ProdukCheckout.dart';
import 'SentTo.dart';
import 'UserCheckout.dart';

class CheckoutProduk {
    List<ProdukCheckout> produk_checkout;
    SentTo sent_to;
    UserCheckout user_checkout;

    CheckoutProduk({this.produk_checkout, this.sent_to, this.user_checkout});

    factory CheckoutProduk.fromJson(Map<String, dynamic> json) {
        return CheckoutProduk(
            produk_checkout: json['produk_checkout'] != null ? (json['produk_checkout'] as List).map((i) => ProdukCheckout.fromJson(i)).toList() : null, 
            sent_to: json['sent_to'] != null ? SentTo.fromJson(json['sent_to']) : null, 
            user_checkout: json['user_checkout'] != null ? UserCheckout.fromJson(json['user_checkout']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.produk_checkout != null) {
            data['produk_checkout'] = this.produk_checkout.map((v) => v.toJson()).toList();
        }
        if (this.sent_to != null) {
            data['sent_to'] = this.sent_to.toJson();
        }
        if (this.user_checkout != null) {
            data['user_checkout'] = this.user_checkout.toJson();
        }
        return data;
    }
}