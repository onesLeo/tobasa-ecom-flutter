import 'package:flutter_app/models/CheckoutProduk.dart';
import 'package:flutter_app/models/ProdukCheckout.dart';
import 'package:flutter_app/models/SentTo.dart';
import 'package:flutter_app/models/UserCheckout.dart';

class InitializationDummyData{

    InitializationDummyData();

    CheckoutProduk checkOutItemDummyData(){
      return new CheckoutProduk(
        produk_checkout: _productChecoutDummyItem(),
        sent_to: _sentToDummyItem(),
        user_checkout: _userCheckoutDummyData()
      );
    }

    List<ProdukCheckout> _productChecoutDummyItem(){
      ProdukCheckout produkCheckout = ProdukCheckout(harga_produk: "5000",
          id_produk: "some-unique-id",
          nama_produk: "Testing nama produk",
          link_to_item: "https://cdn.shopify.com/s/files/1/0021/5030/1751/products/28337342_B.jpg?v=1562422590");

      ProdukCheckout produkCheckout2 = ProdukCheckout(harga_produk: "25000",
          id_produk: "some-unique-id",
          nama_produk: "Testing nama 2 produk",
          link_to_item: "https://cdn.shopify.com/s/files/1/0021/5030/1751/products/28337342_B.jpg?v=1562422590");

      List<ProdukCheckout> listOfProduct = [];
      listOfProduct.add(produkCheckout);
      listOfProduct.add(produkCheckout2);
      return listOfProduct;
    }

    SentTo _sentToDummyItem(){
      final alamat = 'Jl Testing di Tobasa';
      final kabupaten = 'Kabupaten testing ';
      final kecamatan = 'Kecamatan testing ';
      final kota  = 'Kota testing ';
      final kodePos  = 'Kode Pos testing ';

      return SentTo(
        alamat_checkout_user: alamat ,
        kabupaten_checkout_user: kabupaten,
        kecamatan_checkout_user: kecamatan,
        kota_checkout_user: kota,
        kode_pos_checkout_user: kodePos
      );
    }

    UserCheckout _userCheckoutDummyData(){
      return UserCheckout(
          uid: "Some-uid-of-user",
        username: "Some-username",
        no_telp: "some-phone-number"
      );
    }

}