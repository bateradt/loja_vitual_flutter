import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class ProductScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProductScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.get("title")),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: mountTabBarView()),
    );
  }

  FutureBuilder<QuerySnapshot> mountTabBarView() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection("products")
          .doc(snapshot.id)
          .collection("items")
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              GridView.builder(
                  padding: EdgeInsets.all(4.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                        "grid",
                        ProductData.fromDocument(
                            snapshot.data.docs.elementAt(index)));
                  }),
              ListView.builder(
                  padding: EdgeInsets.all(4.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                        "list",
                        ProductData.fromDocument(
                            snapshot.data.docs.elementAt(index)));
                  })
            ],
          );
        }
      },
    );
  }
}
