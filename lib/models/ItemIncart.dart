class ItemIncart {
    String item_name;
    num item_price;

    ItemIncart({this.item_name, this.item_price});

    factory ItemIncart.fromJson(Map<String, dynamic> json) {
        return ItemIncart(
            item_name: json['item_name'], 
            item_price: json['item_price'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['item_name'] = this.item_name;
        data['item_price'] = this.item_price;
        return data;
    }
}