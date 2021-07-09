import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  Map<String, dynamic> userData = Map();

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    print('email: ' + userData["email"]);

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: password)
        .then((user) =>
            setUser(user: user.user, userData: userData, onSuccess: onSuccess))
        .catchError((e) {
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void setUser(
      {@required User user,
      @required Map<String, dynamic> userData,
      @required VoidCallback onSuccess}) async {
    firebaseUser = user;
    onSuccess();
    isLoading = false;
    notifyListeners();
    await _saveUserData(userData);
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    print('Salvando...');
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .set(userData);
  }

  void signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      firebaseUser = user.user;
      await _loadCurrentUser();
      onSuccess();
    }).catchError((e) {
      onFail();
    });

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = _auth.currentUser;
    } else {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users").doc(firebaseUser.uid).get();
        userData = docUser.data();
      }
    }
    notifyListeners();
  }

  @override
  Future<void> addListener(VoidCallback listener) async {
    super.addListener(listener);

    await _loadCurrentUser();
  }
}
