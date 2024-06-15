/// ## WarningDialog
///
/// Widget dialog untuk menampilkan pesan peringatan dengan deskripsi opsional.
///
/// ### Properties:
///
/// - `String? description`: Deskripsi teks yang akan ditampilkan dalam dialog.
/// - `VoidCallback? okClick`: Fungsi panggil balik yang dipanggil ketika tombol 'OK' diklik.
///
/// ### Example Usage:
///
/// ```dart
/// // ketika gagal dalam login
///
/// void _submitLogin(){
/// showDialog(
///   context: context,
///   barrierDismissible: false,
///
///   builder: (BuildContext context) => WarningDialog(
///     description: "Email atau password tidak valid",
///     okClick: () {
///       // action yang akan dilakukan setelah tombol OK diklik
///       Navigator.pop(context);
///     },
///   ),
/// );
/// }
/// ```
///
/// ### For more information on this contact:
/// - GitHub: AriqFaridzki
///
/// {@category Widget}
library WarningDialog;

import 'package:flutter/material.dart';

/// untuk mengeset nilai fix untuk konfig dialog
///
/// @nodoc
class Consts {
  Consts._(); //  untuk mencegah instansiasi.

  static const double padding = 16.0;

  static const double avatarRadius = 66.0;
}

/// Widget dialog untuk menampilkan pesan peringatan dengan deskripsi opsional.
class WarningDialog extends StatelessWidget {
  /// Deskripsi teks yang akan ditampilkan dalam dialog.
  final String? description;

  /// Fungsi callback yang dipanggil ketika tombol 'OK' diklik.
  final VoidCallback? okClick;

  /// Constructor untuk Membuat WarningDialog `.
  ///
  /// Parameter :
  /// - `description`: deskripsi yang akan ditampilkan ketika berhasil.
  /// - `okClick`: fungsi bebas setelah klik ok .
  const WarningDialog({
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
      padding: const EdgeInsets.all(Consts.padding),
      margin: const EdgeInsets.only(top: Consts.avatarRadius),

      // decoration stuff
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

      /// buat desc dan button
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "GAGAL",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.red,
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
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Untuk menutup dialog
                if (okClick != null) {
                  okClick!();
                }
              },
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }
}
