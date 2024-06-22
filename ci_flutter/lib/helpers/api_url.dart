/// ## ApiUrl Library
///
/// class ini digunakan untuk memanggil endpoint untuk pemanggilan api yang lebih rapih
///
/// ### Terminology:
/// - **API**: Jembatan antar software lain untuk saling berkomunikasi,
/// yang dialamnya ada peraturan yang sudah di tentukan untuk berkomunikasi
///
/// - **Endpoint**: sebuah url yang bisa diakses dalam penggunaan API
///
/// ### Usage:
/// Penggunaan `ApiURL` class didalam aplikasi:
///
/// ```dart
/// import 'package:your_package_name/api_url.dart';
///
/// void main() {
///   // Print the login URL
///   print(ApiURL.login); // Output: https://api.example.com/login
///
///
///   // menggunakan produk endpoint
///   final productsUrl = ApiURL.products;
///   // Perform HTTP request...
/// }
/// ```
///
/// ### Important Links:
/// - [ApiURL.baseURL](baseURL/) - The base URL for all API requests.
/// - [ApiURL.login](baseURL/login) - The login endpoint.
/// - [ApiURL.registrasi](baseURL/registrasi) - The register endpoint.
///
///
/// - [ApiURL.listProduk](baseURL/produk) - Mengambil semua produk. ( GET )
/// - [ApiURL.showProduk](baseURL/produk/id) - Mengambil produk spesifik. ( GET )
/// -
/// - [ApiURL.createProduk](baseURL/produk) - Membuat Produk. ( POST )
/// - [ApiURL.updateProduk](baseURL/produk/id) - Mengubah produk. ( PUT )
/// - [ApiURL.deleteProduk](baseURL/produk/id) - Mengapus produk spesifik. ( DELETE )
///
/// For more information on this contact :
/// - Github : AriqFaridzki
///
/// {@category Helpers}

library ApiUrl;

class ApiUrl {
  /// memanggil base URL target API
  // static const String baseUrl = 'http://localhost:8080'; // for emulator
  static const String baseUrl =
      'http://192.168.100.104:8080'; // for real devices

  /// Endpoint untuk registrasi
  static const String registrasi = baseUrl + '/registrasi';

  /// Endpoint untuk login
  static const String login = baseUrl + '/login';

  /// Endpoint untuk semua Produk
  static const String listProduk = baseUrl + '/produk';

  /// Endpoint untuk membuat produk
  static const String createProduk = baseUrl + '/produk';

  /// Mengembalikan endpoint untuk memperbarui produk spesifik berdasarkan [id].
  ///
  /// Parameter:
  /// - `id`: ID produk yang ingin diperbarui.
  static String updateProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  /// Mengembalikan endpoint untuk mengambil produk spesifik berdasarkan [id].
  ///
  /// Parameter:
  /// - `id`: ID produk yang ingin diambil.
  static String showProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  /// Mengembalikan endpoint untuk menghapus produk spesifik berdasarkan [id].
  ///
  /// Parameter:
  /// - `id`: ID produk yang ingin dihapus.
  static String deleteProduk(int id) {
    return '$baseUrl/produk/$id';
  }
}
