/// ## UserInfo Library
///
/// Kelas ini digunakan untuk menyimpan dan mengambil informasi pengguna seperti token dan userID menggunakan `SharedPreferences`.
///
/// `SharedPreferences` adalah sebuah penyimpanan data sederhana berbasis
/// key dan value yang digunakan untuk menyimpan data kecil secara permanen.
/// Ini berguna untuk menyimpan informasi seperti preferensi pengguna,
/// pengaturan aplikasi, atau data lain yang perlu dipertahankan di antara sesi aplikasi.
///
/// value nanti akan disimpan didalam komputer anda,
/// kali ini hanya menyimpan Token saja sebagai autentikasi
///
///
/// ### Terminology:
/// - **Token**: Sebuah string yang digunakan untuk mengautentikasi user.
/// - **UserID**: Sebuah integer yang mengidentifikasi user.
/// - **SharedPreferences**: Penyimpanan data sederhana key dan value di perangkat.
///
///
/// ### Usage:
/// Penggunaan `UserInfo` class di dalam aplikasi:
///
/// ```dart
///
///
/// void main() async {
///   UserInfo userInfo = UserInfo();
///
///   // Menyimpan token
///   await userInfo.setToken('your_token_here');
///
///   // Mengambil token
///   String? token = await userInfo.getToken();
///   print('Retrieved token: $token');
///
///   // Menyimpan userID
///   await userInfo.setUserID(123);
///
///   // Mengambil userID
///   int? userID = await userInfo.getUserID();
///   print('Retrieved userID: $userID');
///
///   // Logout (menghapus semua data yang tersimpan)
///   await userInfo.logout();
/// }
/// ```
///
/// ### Important Links:
/// - [UserInfo.setToken](#) - Menyimpan token ke `SharedPreferences`.
/// - [UserInfo.getToken](#) - Mengambil token dari `SharedPreferences`.
/// - [UserInfo.setUserID](#) - Menyimpan userID ke `SharedPreferences`.
/// - [UserInfo.getUserID](#) - Mengambil userID dari `SharedPreferences`.
/// - [UserInfo.logout](#) - Menghapus semua data dari `SharedPreferences`.
///
/// For more information, contact:
/// - GitHub: [AriqFaridzki](https://github.com/AriqFaridzki)
///
/// {@category Helpers}
///
///
library UserInfo;

import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  /// Menyimpan token ke `SharedPreferences`.
  Future<void> setToken(String value) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", value);
      print('Token saved in setToken: $value');
    } catch (e) {
      print('Error saving token: $e');
      throw Exception('Failed to save token');
    }
  }

  /// Mengambil token dari `SharedPreferences`.
  Future<String?> getToken() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      print('Token retrieved in getToken: $token');
      return token;
    } catch (e) {
      print('Error retrieving token: $e');
      throw Exception('Failed to retrieve token');
    }
  }

  /// Menyimpan userID ke `SharedPreferences`.
  Future<void> setUserID(int value) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setInt("userID", value);
      print('UserID saved: $value');
    } catch (e) {
      print('Error saving userID: $e');
      throw Exception('Failed to save userID');
    }
  }

  /// Mengambil userID dari `SharedPreferences`.
  Future<int?> getUserID() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      int? userID = pref.getInt("userID");
      print('UserID retrieved: $userID');
      return userID;
    } catch (e) {
      print('Error retrieving userID: $e');
      throw Exception('Failed to retrieve userID');
    }
  }

  /// Menghapus semua data dari `SharedPreferences`.
  Future<void> logout() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.clear();
      print('SharedPreferences cleared');
    } catch (e) {
      print('Error clearing SharedPreferences: $e');
      throw Exception('Failed to clear SharedPreferences');
    }
  }
}
