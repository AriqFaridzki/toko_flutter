/// ## Login
///
/// class ini membuat dialog ketika sukses
///
///
/// ### Properties:
///
/// - `int? code`: Kode status http dari respon login.
/// - `bool? status`: Status login (berhasil atau gagal).
/// - `String? token`: Token autentikasi yang diberikan setelah login berhasil.
///
/// - `String? description`: deskripsi yang akan ditampilkan ketika berhasil.
/// - `VoidCallback? okClick`: fungsi bebas setelah klik ok .
///
/// ### Example Usage:
///
/// ```dart
/// // ketika sukses dalam registrasi user
///
/// void _submitRegistrasi(){
/// showDialog(
///         context: context,
///         barrierDismissible: false,
///
///         builder: (BuildContext context) => SuccessDialog(
///           description: "Registrasi berhasil, silahkan login",
///           okClick: () {
///             // action yang akan dilakukan setelah tombol OK diklik
///             Navigator.pop(context);
///           },
///         ),
///       );
/// }
/// ```
///
/// ### For more information on this contact:
/// - GitHub: AriqFaridzki
/// {@category Widget}
library SuccessDialog;

import 'package:flutter/material.dart';

/// untuk mengeset nilai fix untuk konfig dialog
///
/// @nodoc
class Consts {
  Consts._(); // Konstruktor private untuk mencegah instansiasi.

  static const double padding = 16.0;

  static const double avatarRadius = 66.0;
}

/// Widget dialog untuk menampilkan pesan sukses dengan deskripsi opsional.
class SuccessDialog extends StatelessWidget {
  final String? description;

  /// Fungsi callback yang dipanggil ketika tombol 'OK' diklik.
  final VoidCallback? okClick;

  /// Constructor untuk Membuat SuccessDialog `.
  ///
  /// Parameter :
  /// - `description`: deskripsi yang akan ditampilkan ketika berhasil.
  /// - `okClick`: fungsi bebas setelah klik ok .
  const SuccessDialog({
    Key? key,
    this.description,
    this.okClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  /// Membangun isi konten dari dialog.
  Widget dialogContent(BuildContext context) {
    return Container(
      /// config spacing di daerah kontainer
      padding: const EdgeInsets.all(Consts.padding),
      margin: const EdgeInsets.only(top: Consts.avatarRadius),

      /// Style Stuff
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),

      /// membuat deskripsi dan button
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "SUKSES",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Untuk menutup dialog
                okClick!();
              },
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }
}
