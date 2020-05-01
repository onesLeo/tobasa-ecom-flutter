class AddressUser {
    String alamat;
    String kabupaten;
    String kecamatan;
    String kode_pos;
    String kota;

    AddressUser({this.alamat, this.kabupaten, this.kecamatan, this.kode_pos, this.kota});

    factory AddressUser.fromJson(Map<String, dynamic> json) {
        return AddressUser(
            alamat: json['alamat'], 
            kabupaten: json['kabupaten'], 
            kecamatan: json['kecamatan'], 
            kode_pos: json['kode_pos'], 
            kota: json['kota'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alamat'] = this.alamat;
        data['kabupaten'] = this.kabupaten;
        data['kecamatan'] = this.kecamatan;
        data['kode_pos'] = this.kode_pos;
        data['kota'] = this.kota;
        return data;
    }
}