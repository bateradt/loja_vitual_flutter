import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  Future getImagesFromHome() {
    var future =
        FirebaseFirestore.instance.collection("home").orderBy("pos").get();

    // var future2 = FirebaseFirestore.instance.collection("products").orderBy("title").get();
    //
    // print("Products");
    // future2.then((value) => print(value.docs));
    return future;
  }

  List<Widget> getImagesFade(AsyncSnapshot<QuerySnapshot> snapshot) {
    print("getImagesFade");
    var list = snapshot.data.docs.map((doc) {
      return FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: doc.get("image"),
          fit: BoxFit.cover);
    }).toList();

    return list;
  }

  double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }

  List<StaggeredTile> getListStaggeredTile(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    print("getListStaggeredTile");
    var list = snapshot.data.docs.map((doc) {
      return StaggeredTile.count(doc.get("x"), checkDouble(doc.get("y")));
    }).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: getImagesFromHome(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
                  );
                } else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: getListStaggeredTile(snapshot),
                    children: getImagesFade(snapshot),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
