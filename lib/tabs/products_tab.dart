import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  Future<QuerySnapshot> getCategory() async {
    var future = FirebaseFirestore.instance.collection("products").orderBy("title").get();
    return future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getCategory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          print("Products");
          print(snapshot.data.docs);
          var dividedTiles = ListTile.divideTiles(
              tiles: snapshot.data.docs.map((doc) {
                return CategoryTile(doc);
              }).toList(), color: Colors.grey[500]).toList();
          return ListView(
            children: dividedTiles,
          );
        }
      },);
  }
}
