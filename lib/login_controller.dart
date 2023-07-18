import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  final _googleSingin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async{
    googleAccount.value = await _googleSingin.signIn();
  }

  logout() async{
    googleAccount.value = await _googleSingin.signOut();
  }
}