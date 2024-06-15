/// ## RegistrasiBloc
///
/// class ini digunakan untuk handle registrasi
///
///
/// ### Usage:
/// Penggunaan `RegistrasiBloc` class didalam aplikasi:
///
/// ```dart
/// import 'package:your_package_name/bloc/registrasi_bloc';
///
/// void RegistrasiBloc.registrasi() {
///
///   Code ...
///
///   RegistrasiBloc.registrasi(
///   nama: _namaTextboxController.text,
///   email: _emailTextboxController.text,
///   password: _passwordTextboxController.text)
///   .then( (value) {
///
///    ....Code }
/// ```
///
///
/// ### Static Method:
///
/// **RegistrasiBloc.registrasi()** // logging out
///
///
/// For more information on this contact :
/// - Github : AriqFaridzki
///
/// {@category BLOC}

library RegistrasiBloc;

import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/registrasi.dart';

class RegistrasiBloc {
  /// Mengirimkan permintaan POST ke endpoint register.
  ///
  /// Parameter:
  /// - `nama`: String
  /// - `email`: String
  /// - `password`: String
  ///
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    // sending data UI to api for regist and wait for response
    var body = {"nama": nama, "email": email, "password": password};
    var response = await Api().post(apiUrl, body); // wait response

    var jsonObj = json.decode(response.body); //convert to string
    return Registrasi.fromJson(jsonObj);
  }
}
