import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15.0),
              ),
              style: TextButton.styleFrom(primary: Colors.white)),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return loginForm(primaryColor, model);
      }),
    );
  }

  Form loginForm(Color primaryColor, UserModel model) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: "E-mail"),
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email.isEmpty || !email.contains('@')) {
                return "E-mail inválido";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(hintText: "Senha"),
            obscureText: true,
            validator: (pass) {
              if (pass.isEmpty || pass.length < 6) {
                return "Senha inválida";
              } else {
                return null;
              }
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Esqueci minha senha",
                textAlign: TextAlign.right,
              ),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            height: 44.0,
            child: ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState.validate()) {}
                model.signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                    onSuccess: _onSuccess,
                    onFail: _onFail);
              },
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Login efetuado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 1))
        .then((value) => Navigator.of(context).pop());
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Erro ao efetuar login"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
