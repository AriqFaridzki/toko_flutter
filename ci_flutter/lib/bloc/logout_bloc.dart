/// ## LogoutBloc
///
/// class ini digunakan untuk handle logout
///
///
/// ### Usage:
/// Penggunaan `LoginBloc` class didalam aplikasi:
///
/// ```dart
/// import 'package:your_ package_name/bloc/logout_bloc';
///
/// void logoutButton() {
///
///   Code ...
///
///   /// removing token from device
///   LogoutBloc.logout()
///
///
///    ....Code
/// }
/// ```
/// ### Static Method:
///
/// **LogoutBloc.logout()** // logging out
///
/// For more information on this contact :
/// - Github : AriqFaridzki
///
/// {@category BLOC}

library LogoutBloc;

import '/helpers/user_info.dart';

class LogoutBloc {
  /// menghapus token yang ada di device
  static Future<void> logout() async {
    await UserInfo().logout();
  }
}
