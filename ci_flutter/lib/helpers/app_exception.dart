/// ## AppException Library
///
/// Kumpulan kelas untuk menangani berbagai jenis kesalahan yang terjadi saat berkomunikasi dengan API.
///
/// ### Terminology:
/// - **Exception**: Kesalahan atau kondisi khusus yang terjadi saat menjalankan program.
/// - **Prefix**: Bagian awal dari pesan kesalahan yang memberikan konteks tambahan.
///
/// ### Usage:
/// Penggunaan `AppException` dan kelas turunannya:
///
/// ```dart
/// try {
///   // Code yang mungkin menyebabkan kesalahan
///   throw FetchDataException('No Internet connection');
/// } catch (e) {
///   print(e); // Output: Error During Communication: No Internet connection
/// }
/// ```
///
/// ### Important Links:
/// - [AppException] - Kelas dasar untuk semua exception.
/// - [FetchDataException] - Kesalahan saat mengambil data dari server.
/// - [BadRequestException] - Kesalahan permintaan tidak valid (status code 400).
/// - [UnauthorisedException] - Kesalahan tidak diotorisasi (status code 401 atau 403).
/// - [UnprocessableEntityException] - Kesalahan entitas tidak dapat diproses (status code 422).
/// - [InvalidInputException] - Kesalahan input tidak valid.
///
/// For more information, contact:
/// - GitHub: [AriqFaridzki](https://github.com/AriqFaridzki)
///
/// {@category Helpers}
library AppException;

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

/// Kesalahan saat berkomunikasi dengan server.
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

/// Kesalahan permintaan tidak valid (status code 400).
class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

/// Kesalahan tidak diotorisasi (status code 401 atau 403).
class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorized: ");
}

/// Kesalahan entitas tidak dapat diproses (status code 422).
class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([message])
      : super(message, "Unprocessable Entity: ");
}

/// Kesalahan input tidak valid.
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
