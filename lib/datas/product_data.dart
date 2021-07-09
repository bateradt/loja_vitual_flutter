import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    print("Documento");
    print(snapshot.id);
    print(snapshot.get("title"));
    print(snapshot.get("description"));

    print(snapshot.get("price") + 0.00);

    print(snapshot.get("images"));

    print(snapshot.get("sizes"));

    id = snapshot.id;
    title = snapshot.get("title");
    description = snapshot.get("description");
    price = snapshot.get("price") + 0.00;
    images = snapshot.get("images");
    sizes = snapshot.get("sizes");
  }
}