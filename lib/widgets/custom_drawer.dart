import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loja_virtual/models/user_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text(
                          "Flutter's\nShoes",
                          style: TextStyle(
                              fontSize: 34.0, fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                        return welcome_user(context, model);
                      }),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list_rounded, "Produtos", pageController, 1),
              DrawerTile(
                  Icons.location_on, "Encontre uma loja", pageController, 2),
              DrawerTile(
                  Icons.local_grocery_store, "Meus pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}

class welcome_user extends StatelessWidget {
  const welcome_user(BuildContext context, this.model, {
    Key key,
  }) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    var model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.model.isLoggedIn() ? "Olá, " + this.model.userData["name"] : "Olá",
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: Text(
            this.model.isLoggedIn() ? "Sair" : "Entre ou cadastre-se >",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          onTap: () {
            if (this.model.isLoggedIn()) {
              this.model.signOut();
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen()));
            }
          },
        )
      ],
    );
  }
}
