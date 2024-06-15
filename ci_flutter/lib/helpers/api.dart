/// ## Api
///
/// Kelas ini digunakan untuk memanggil endpoint API dengan berbagai
/// metode HTTP seperti POST, GET, PUT, dan DELETE.
///
///
///
/// ### Terminology:
/// - **API**: Jembatan antar software lain untuk saling berkomunikasi,
///   yang di dalamnya ada peraturan yang sudah ditentukan untuk berkomunikasi.
/// - **Endpoint**: Sebuah URL yang bisa diakses dalam penggunaan API.
///
/// ### Usage:
/// Penggunaan `Api` class di dalam aplikasi:
///
/// ```dart
/// import 'package:your_package_name/api.dart';
///
/// void main() async {
///   final api = Api();
///
///   // Contoh penggunaan POST request
///   final responsePost = await api.post('https://api.example.com/login', {
///     'username': 'user',
///     'password': 'pass'
///   });
///   print(responsePost);
///
///   // Contoh penggunaan POST request dengan `ApiURL` class
///   final responsePost = await api.post(ApiURL.login, {
///     'username': 'user',
///     'password': 'pass'
///   });
///   print(responsePost);
///
///   // Contoh penggunaan GET request
///   final responseGet = await api.get('https://api.example.com/products');
///   print(responseGet);
/// }
/// ```
///
/// ### Important Links:
/// - [Api.post](post/) - Mengirimkan data ke server dengan metode POST.
/// - [Api.get](get/) - Mengambil data dari server dengan metode GET.
/// - [Api.put](put/) - Memperbarui data di server dengan metode PUT.
/// - [Api.delete](delete/) - Menghapus data di server dengan metode DELETE.
///
/// ### Error Handling:
/// - [FetchDataException] - Terjadi kesalahan saat komunikasi dengan server.
/// - [BadRequestException] - Permintaan tidak valid (status code 400).
/// - [UnauthorisedException] - Tidak diotorisasi (status code 401 atau 403).
/// - [InvalidInputException] - Input tidak valid (status code 422).
///
/// For more information, contact:
/// - GitHub: [AriqFaridzki](https://github.com/AriqFaridzki)
///
/// {@category Helpers}

library Api;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'user_info.dart';
import 'app_exception.dart';

class Api {
  /// Mengirimkan permintaan POST ke [url] dengan [data].
  ///
  /// Parameter:
  /// - `url`: URL tujuan untuk permintaan POST.
  /// - `data`: Data yang akan dikirim dalam bentuk JSON.
  ///
  ///
  /// Mengembalikan response dari server jika berhasil, melemparkan [FetchDataException] jika terjadi kesalahan koneksi, atau [Exception] jika terjadi kesalahan lain.
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    print('API (token) :${token}');

    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      print('Error in POST request: $e');
      throw Exception('Failed to perform POST request');
    }
    return responseJson;
  }

  /// Mengirimkan permintaan GET ke [url].
  ///
  /// Parameter:
  /// - `url`: URL tujuan untuk permintaan GET.
  ///
  /// Mengembalikan response dari server jika berhasil, melemparkan [FetchDataException] jika terjadi kesalahan koneksi.
  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// Mengirimkan permintaan PUT ke [url] dengan [data].
  ///
  /// Parameter:
  /// - `url`: URL tujuan untuk permintaan PUT.
  /// - `data`: Data yang akan dikirim dalam bentuk JSON.
  ///
  /// Mengembalikan response dari server jika berhasil, melemparkan [FetchDataException] jika terjadi kesalahan koneksi, atau [Exception] jika terjadi kesalahan lain.
  Future<dynamic> put(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    // token diberikan jika user valid

    var responseJson;

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      responseJson = _returnResponse(response);
      print(" response : ${response}");
      print(" responseJSON : ${responseJson}");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      //general purpose error
      // print('Error in PUT request: $e');
      throw Exception('Failed to perform PUT request');
    }
    return responseJson;
  }

  /// Mengirimkan permintaan DELETE ke [url].
  ///
  /// Parameter:
  /// - `url`: URL tujuan untuk permintaan DELETE.
  ///
  /// Mengembalikan response dari server jika berhasil, melemparkan [FetchDataException] jika terjadi kesalahan koneksi.
  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// Mengembalikan response berdasarkan status code.
  ///
  /// Parameter:
  /// - `response`: Response dari server.
  ///
  /// Melemparkan exception berdasarkan status code:
  /// - [BadRequestException] untuk status code 400.
  /// - [UnauthorisedException] untuk status code 401 atau 403.
  /// - [InvalidInputException] untuk status code 422.
  /// - [FetchDataException] untuk status code lainnya atau kesalahan komunikasi.
  dynamic _returnResponse(http.Response response) {
    // untuk error spesifik
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with Status Code: ${response.statusCode}');
    }
  }
}
