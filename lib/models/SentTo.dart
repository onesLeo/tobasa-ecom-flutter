class SentTo {
    String alamat_checkout_user;
    String kabupaten_checkout_user;
    String kecamatan_checkout_user;
    String kode_pos_checkout_user;
    String kota_checkout_user;

    SentTo({this.alamat_checkout_user, this.kabupaten_checkout_user, this.kecamatan_checkout_user, this.kode_pos_checkout_user, this.kota_checkout_user});

    factory SentTo.fromJson(Map<String, dynamic> json) {
        return SentTo(
            alamat_checkout_user: json['alamat_checkout_user'], 
            kabupaten_checkout_user: json['kabupaten_checkout_user'], 
            kecamatan_checkout_user: json['kecamatan_checkout_user'], 
            kode_pos_checkout_user: json['kode_pos_checkout_user'], 
            kota_checkout_user: json['kota_checkout_user'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alamat_checkout_user'] = this.alamat_checkout_user;
        data['kabupaten_checkout_user'] = this.kabupaten_checkout_user;
        data['kecamatan_checkout_user'] = this.kecamatan_checkout_user;
        data['kode_pos_checkout_user'] = this.kode_pos_checkout_user;
        data['kota_checkout_user'] = this.kota_checkout_user;
        return data;
    }
}