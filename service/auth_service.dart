import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user
  void signUpUser(
      {required int id,
      required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String confpassword,
      required int phone,
      required String role}) async {
    try {
      User user = User(
          id: id,
          firstname: firstname,
          lastname: lastname,
          email: email,
          password: password,
          confpassword: confpassword,
          phone: phone,
          role: role);

      http.Response res = await http.post(
        'localhost:3000/register' as Uri,
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
    } catch (e) {}
  }
}
