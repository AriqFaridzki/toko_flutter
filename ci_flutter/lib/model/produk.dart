/// ## Produk
///
/// Kelas ini merepresentasikan data produk.
///
/// Ini adalah model produk
///
/// ### Properties:
///
/// - `int? id`: ID unik dari produk.
/// - `String? kodeProduk`: Kode produk.
/// - `String? namaProduk`: Nama produk.
/// - `int? hargaProduk`: Harga produk.
/// - `bool? status`: Status produk.
///
/// ### Example Usage:
///
/// ```dart
/// // Contoh data JSON dari API produk
/// Map<String, dynamic> jsonProduk = {
///   "id": "1",
///   "kode_produk": "PRD001",
///   "nama_produk": "Smartphone",
///   "harga": "1500000",
///   "status": true,
/// };
///
/// // Membuat instance Produk dari data JSON
/// Produk produk = Produk.fromJson(jsonProduk);
///
/// // Akses properti dari objek produk
/// print('ID: ${produk.id}');
/// print('Kode Produk: ${produk.kodeProduk}');
/// print('Nama Produk: ${produk.namaProduk}');
/// print('Harga: ${produk.hargaProduk}');
/// print('Status: ${produk.status}');
/// ```
///
/// {@category Model}
///

library Produk;

class Produk {
  /// ID unik dari produk.
  int? id;

  /// Kode produk.
  String? kodeProduk;

  /// Nama produk.
  String? namaProduk;

  /// Harga produk.
  int? hargaProduk;

  /// Status produk.
  bool? status;

  /// Constructor untuk membuat instance Produk.
  ///
  /// - `id`: ID unik dari produk.
  /// - `kodeProduk`: Kode produk.
  /// - `namaProduk`: Nama produk.
  /// - `hargaProduk`: Harga produk.
  /// - `status`: Status produk.
  Produk({
    this.id,
    this.kodeProduk,
    this.namaProduk,
    this.hargaProduk,
    this.status,
  });

  /// Factory method untuk membuat instance Produk dari data JSON.
  ///
  /// Membuat instance dari kelas `Produk` berdasarkan data JSON yang diberikan.
  ///
  /// Parameter :
  /// - `(Map<String, dynamic> json)` : `json` Sebuah map yang berisi data JSON.
  /// Return :
  /// - instance `Produk` dengan properti yang diisi sesuai data JSON.
  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: int.tryParse(json['id']),
      kodeProduk: json['kode_produk'],
      namaProduk: json['nama_produk'],
      hargaProduk: int.tryParse(json['harga']),
      status: json['status'] ?? false,
    );
  }
}
