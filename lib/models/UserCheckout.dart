class UserCheckout {
    String no_telp;
    String uid;
    String username;

    UserCheckout({this.no_telp, this.uid, this.username});

    factory UserCheckout.fromJson(Map<String, dynamic> json) {
        return UserCheckout(
            no_telp: json['no_telp'], 
            uid: json['uid'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['no_telp'] = this.no_telp;
        data['uid'] = this.uid;
        data['username'] = this.username;
        return data;
    }
}