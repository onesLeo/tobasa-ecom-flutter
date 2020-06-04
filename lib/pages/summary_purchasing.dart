import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_counter/flutter_counter.dart';

class SummaryPurchasing extends StatefulWidget {
  final Produk item;

  SummaryPurchasing({this.item});

  @override
  _SummaryPurchasingState createState() => _SummaryPurchasingState();
}

class _SummaryPurchasingState extends State<SummaryPurchasing> {
  num _counter = 0;
  num _defaultValue = 0;
  final num totalPrice=0;

  @override
  void initState() {
    super.initState();
    widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                Row(
                    children : [
                      Text('${widget.item.namaProduk} - ${widget.item.hargaProduk}') ,
                      SizedBox(width: 10,),
                      Counter(
                        initialValue: _defaultValue,
                        minValue: 0,
                        maxValue: 100,
                        step: 0.5,
                        decimalPlaces: 1,
                        onChanged: (value){
                          setState(() {
                            _defaultValue = value;
                            _counter = value;
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      Text('${widget.item.ukuran}')
                    ]
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
