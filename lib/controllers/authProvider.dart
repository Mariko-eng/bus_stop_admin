import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/auth/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AdminUserModel _userModel;
  bool _isLoading = false;
  AdminUserModel get userModel => _userModel;
  bool get isLoading => _isLoading;

  UserProvider() {
    _fireSetUp();
  }

  _fireSetUp() {
    _isLoading = true;
    notifyListeners();
    _auth.authStateChanges().listen(_onStateChanged);
  }

  _onStateChanged(User user) async {
    if (user == null) {
      _userModel = null;
      _isLoading = false;
      notifyListeners();
    } else {
      AdminUserModel res = await _getUserAdminDetails(uid: user.uid);
      _userModel = res;
      if(_userModel == null){
        await _auth.signOut();
        _isLoading = false;
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = credential.user;
      AdminUserModel res = await _getUserAdminDetails(uid: user.uid);
      _userModel = res;
      if(_userModel == null){
        await _auth.signOut();
        _isLoading = false;
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar("Failed To Login", "Try Again");
    }
  }

  Future<AdminUserModel> _getUserAdminDetails({String uid}) async{
    try{
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection("admin_accounts").doc(uid).get();
      return AdminUserModel.fromSnapshot(snap);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    _isLoading = true;
    notifyListeners();
    await _auth.signOut();
    _isLoading = false;
    notifyListeners();
    // Get.offAll(() => const Wrapper());
  }
}
