class AddressUser {
    String alamat;
    String kabupaten;
    String kecamatan;
    String kode_pos;
    String kota;
    bool isPrimary;

    AddressUser({this.alamat, this.kabupaten, this.kecamatan, this.kode_pos, this.kota, this.isPrimary});

    factory AddressUser.fromJson(Map<String, dynamic> json) {
        return AddressUser(
            alamat: json['alamat'], 
            kabupaten: json['kabupaten'], 
            kecamatan: json['kecamatan'], 
            kode_pos: json['kode_pos'], 
            isPrimary: json['is_primary'],
            kota: json['kota'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['alamat'] = this.alamat;
        data['kabupaten'] = this.kabupaten;
        data['kecamatan'] = this.kecamatan;
        data['kode_pos'] = this.kode_pos;
        data['is_primary'] = this.isPrimary;
        data['kota'] = this.kota;
        return data;
    }
}