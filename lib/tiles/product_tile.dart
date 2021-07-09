import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData productData;

  ProductTile(this.type, this.productData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(productData)));
      },
      child: Card(
        child: type == "grid"
            ? productsColumnView(context)
            : productsRowView(context),
      ),
    );
  }

  Row productsRowView(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 1,
            child: Image.network(
              productData.images[0],
              fit: BoxFit.cover,
              height: 250.0,
            )),
        Flexible(
          flex: 1,
          child: textProductValueView(context),
        )
      ],
    );
  }

  Column productsColumnView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(
            productData.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(child: textProductValueView(context))
      ],
    );
  }

  Container textProductValueView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productData.title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            "R\$ ${productData.price.toStringAsFixed(2)}",
            style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
