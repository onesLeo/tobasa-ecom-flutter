class user {
    UserX user;

    user({this.user});

    factory user.fromJson(Map<String, dynamic> json) {
        return user(
            user: json['user'] != null ? UserX.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}