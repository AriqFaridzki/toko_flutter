/// ## Registrasi
///
/// Kelas ini merepresentasikan hasil operasi registrasi.
///
/// Ini adalah model registrasi
///
/// ### Properties:
///
/// - `int? code`: Kode status http dari respon registrasi.
/// - `bool? status`: Status hasil apakah registrasi berhasil
/// - `String? data`: Data tambahan
///
/// ### Example Usage:
///
/// ```dart
/// // Contoh data JSON dari hasil registrasi
/// Map<String, dynamic> jsonRegistrasi = {
///   "code": 200,
///   "status": true,
///   "data": "Registrasi berhasil!"
/// };
///
/// // Membuat instance Registrasi dari data JSON
/// Registrasi registrasi = Registrasi.fromJson(jsonRegistrasi);
///
/// // Akses properti dari objek registrasi
/// print('Code: ${registrasi.code}');
/// print('Status: ${registrasi.status}');
/// print('Data: ${registrasi.data}');
/// ```
///
/// {@category Model}
///

library Registrasi;

class Registrasi {
  /// Kode hasil operasi registrasi.
  int? code;

  /// Status hasil operasi registrasi.
  bool? status;

  /// Data tambahan dari hasil registrasi.
  String? data;

  /// Constructor untuk membuat instance Registrasi.
  ///
  /// - `code`: Kode hasil operasi registrasi.
  /// - `status`: Status hasil operasi registrasi.
  /// - `data`: Data tambahan dari hasil registrasi.
  Registrasi({
    this.code,
    this.status,
    this.data,
  });

  /// Factory method untuk membuat instance Registrasi dari data JSON.
  ///
  /// Membuat instance dari kelas `Registrasi` berdasarkan data JSON yang diberikan.
  ///
  /// - Parameter :
  ///   - `(Map<String, dynamic> obj)` : `obj` Sebuah map yang berisi data JSON.
  /// - Return :
  ///   - instance `Registrasi` dengan properti yang diisi sesuai data JSON.
  factory Registrasi.fromJson(Map<String, dynamic> obj) {
    return Registrasi(
      code: obj['code'],
      status: obj['status'],
      data: obj['data'],
    );
  }
}
