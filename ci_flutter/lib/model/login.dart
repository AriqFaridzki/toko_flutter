/// ## Login
///
/// class ini merepresentasikan data login pengguna .
///
/// ini adalah model login
///
/// ### Properties:
///
/// - `int? code`: Kode status http dari respon login.
/// - `bool? status`: Status login (berhasil atau gagal).
/// - `String? token`: Token autentikasi yang diberikan setelah login berhasil.
/// - `int? userID`: ID pengguna yang login.
/// - `String? userEmail`: Email pengguna yang login.
///
///
/// ### Example Usage:
///
/// ```dart
/// // Contoh data JSON dari respon API login
/// Map<String, dynamic> jsonResponse = {
///   "code": 200,
///   "status": true,
///   "data": {
///     "token": "some_auth_token",
///     "user": {
///       "id": "123",
///       "email": "user@example.com"
///     }
///   }
/// };
///
/// // Membuat instance Login dari data JSON
/// Login loginData = Login.fromJson(jsonResponse);
///
/// // Akses properti dari objek loginData
/// print('Code: ${loginData.code}');
/// print('Status: ${loginData.status}');
/// print('Token: ${loginData.token}');
/// print('UserID: ${loginData.userID}');
/// print('UserEmail: ${loginData.userEmail}');
/// ```
///
/// ### For more information on this contact:
/// - GitHub: AriqFaridzki
///
/// {@category Model}
///

library Login;

class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  /// Constructor untuk Membuat instance dari kelas `Login`.
  ///
  /// Parameter :
  /// - `code`: Kode status http dari respon login.
  /// - `status`: Status login (berhasil atau gagal).
  /// - `token`: Token autentikasi yang diberikan setelah login berhasil.
  /// - `userID`: ID pengguna yang login.
  /// - `userEmail`: Email pengguna yang login.
  Login({this.code, this.status, this.token, this.userEmail, this.userID});

  /// Factory method untuk membuat instance Login dari data JSON.
  ///
  /// Membuat instance dari kelas `Login` berdasarkan data JSON yang diberikan.
  ///
  /// Parameter :
  /// - `(Map<String, dynamic> obj)` : `obj` Sebuah map yang berisi data JSON.
  /// Return :
  /// - instance `Login` dengan properti yang diisi sesuai data JSON.
  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
      code: obj['code'],
      status: obj['status'],
      token: obj['data']['token'],
      userID: int.parse(obj['data']['user']['id']),
      userEmail: obj['data']['user']['email'],
    );
  }
}
