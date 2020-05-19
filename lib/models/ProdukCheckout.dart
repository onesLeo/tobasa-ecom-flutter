class ProdukCheckout {
    String harga_produk;
    String id_produk;
    String link_to_item;
    String nama_produk;

    ProdukCheckout({this.harga_produk, this.id_produk, this.link_to_item, this.nama_produk});

    factory ProdukCheckout.fromJson(Map<String, dynamic> json) {
        return ProdukCheckout(
            harga_produk: json['harga_produk'], 
            id_produk: json['id_produk'], 
            link_to_item: json['link_to_item'], 
            nama_produk: json['nama_produk'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['harga_produk'] = this.harga_produk;
        data['id_produk'] = this.id_produk;
        data['link_to_item'] = this.link_to_item;
        data['nama_produk'] = this.nama_produk;
        return data;
    }
}