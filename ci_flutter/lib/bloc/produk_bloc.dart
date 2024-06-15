/// ## ProdukBloc
///
///  digunakan untuk mengelola operasi CRUD
///  (Create, Read, Update, Delete) untuk bagian produk menggunakan API.
///
/// ### Terminology:
/// - **CRUD**: Create, Read, Update, Delete adalah empat operasi dasar yang dilakukan pada basis data.
/// - **API**: Application Programming Interface, jembatan antar perangkat lunak untuk saling berkomunikasi.
/// - **Endpoint**: URL yang dapat diakses dalam penggunaan API.
/// - **BLOC** : arsitektur Business Logic Component
///
/// ### Usage:
/// Penggunaan `ProdukBloc` class dalam aplikasi:
///
/// ```dart
/// import 'package:your_package_name/bloc/produk_bloc.dart';
///
/// void main() async {
///   // Mengambil semua produk
///   List<Produk> produkList = await ProdukBloc.getProduks();
///   print(produkList);
///
///   // Menambahkan produk baru
///   Produk newProduk = Produk(kodeProduk: '001', namaProduk: 'Produk Baru', hargaProduk: 10000);
///   await ProdukBloc.addProduk(produk: newProduk);
///
///   // Memperbarui produk
///   newProduk.namaProduk = 'Produk Baru Diubah';
///   bool success = await ProdukBloc.updateProduk(produk: newProduk);
///   if (success) print('Produk berhasil diupdate');
///
///   // Menghapus produk
///   bool deleted = await ProdukBloc.deleteProduk(id: newProduk.id);
///   if (deleted) print('Produk berhasil dihapus');
/// }
/// ```
///
/// ### Static Methods:
/// - **getProduks**: Mengambil semua produk dari server.
/// - **addProduk**: Menambahkan produk baru ke server.
/// - **updateProduk**: Memperbarui produk yang sudah ada di server.
/// - **deleteProduk**: Menghapus produk dari server.
///
/// For more information on this contact:
/// - GitHub: [AriqFaridzki](https://github.com/AriqFaridzki)
///
/// {@category BLOC}

library ProdukBloc;

import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/produk.dart';

/// digunakan untuk mengelola operasi CRUD
/// (Create, Read, Update, Delete) untuk bagian produk menggunakan API.
class ProdukBloc {
  /// Mengirimkan permintaan GET ke endpoint produk.
  ///
  /// Return :
  /// - `List<Produk>` variable = [{
  ///   - `id`          : `int`,
  ///   - `kodeProduk`  : `String`,
  ///   - `namaProduk`  : `String`,
  ///   - `hargaProduk` : `int`,
  ///   - `status`      : `bool`
  ///   - }, ...Another Data]
  // }
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;

    var response = await Api().get(apiUrl);
    // print("product bloc : Response Body = ${response.body}"); // Debug print for response body
    var jsonObj = json.decode(response.body);
    // print("product bloc : decodedJson = ${jsonObj}"); // debug print for response body

    /// menyimpan data dari api agar mudah di loop
    List<dynamic> listProduk = (jsonObj
        as Map<String, dynamic>)['data']; //mengakses array ['data'] dari api

    List<Produk> produks = [];

    /// memformat data ke model produk
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  /// Mengirimkan permintaan POST ke endpoint produk.
  ///
  /// untuk menambahkan data produk
  ///
  /// Parameter :
  ///  - `produk` : Produk Model Class
  ///
  ///
  /// Return :
  /// - `status` : bool
  // }
  static Future addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;
    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  /// Mengirimkan permintaan PUT ke endpoint produk.
  ///
  /// untuk mengubah / update data produk
  ///
  /// Parameter :
  ///  - `produk` : Produk Model Class
  ///
  ///
  /// Return :
  /// - `status` : bool
  // }
  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    try {
      var response = await Api().put(apiUrl, body);
      var jsonObj = json.decode(response.body);

      // Assuming your API returns a status indicating success or failure
      if (jsonObj['status'] == true) {
        return true; // Return true if update was successful
      } else {
        return false; // Return false or handle other conditions indicating failure
      }
    } catch (e) {
      // print('Error during update produk: $e');
      throw e; // Propagate the error
    }
  }

  /// Mengirimkan permintaan PUT ke endpoint produk.
  ///
  /// untuk mengubah / update data produk
  ///
  /// Parameter :
  ///  - `produk` : Produk Model Class
  ///
  ///
  /// Return :
  /// - `status` : bool
  // }
  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(apiUrl);

    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }
}
