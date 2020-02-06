import 'package:flutter/material.dart';
import 'package:navigate/modal/product.dart';

class ProductDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final Product _productInfo = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(title: Text(_productInfo.name)),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(_productInfo.img),
              Text(_productInfo.name),
              Text(_productInfo.price.toString())
            ]),
      ),
    );
  }
}
