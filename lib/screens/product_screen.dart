import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(this.productData, {Key key}) : super(key: key);

  final ProductData productData;

  @override
  _ProductScreenState createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

  String sizeSelected;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 5.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            sizeSelected = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: size == sizeSelected
                                      ? primaryColor
                                      : Colors.grey[500],
                                  width: 3.0)),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: sizeSelected != null ? () {} : null,
                    child: Text(
                      "Adicionar ao Carrinho",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
