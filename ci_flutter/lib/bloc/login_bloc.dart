/// ## LoginBloc
///
/// class ini digunakan untuk handle bagian login
///
///
/// ### Usage:
/// Penggunaan `LoginBloc` class didalam aplikasi:
///
/// ```dart
/// import 'package:your_ package_name/bloc/login_bloc';
///
/// void submitButton() {
///
///   Code ...
///
///   // Using LoginBloc and async for login
///   LoginBloc.login(
///      email: _emailTextboxController.text,
///      password: _passwordTextboxController.text)
///   .then((value) async {
///
///    ....Code }
/// }
/// ```
///
/// Static Method :
///
/// - **LoginBloc.login()**
///
///
/// For more information on this contact :
/// - Github : AriqFaridzki
///
/// {@category BLOC}

library LoginBloc;

import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/login.dart';

class LoginBloc {
  /// Mengirimkan permintaan POST ke endpoint login.
  ///
  /// Parameter:
  /// - `email`: String
  /// - `password`: String
  ///
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    // print('login_bloc apiUrls : $apiUrl');
    var body = {"email": email, "password": password};
    // print('login_bloc body : $body');

    /// sending login request!
    var response = await Api().post(apiUrl, body);

    // print(response);
    var jsonObj = json.decode(response.body);
    // print(jsonObj); // Print the full response for debugging
    return Login.fromJson(jsonObj); // Use the updated Login model
  }
}
