library ProdukDetail;

import 'package:ci_flutter/bloc/produk_bloc.dart';
import 'package:ci_flutter/ui/produk_page.dart';
import 'package:flutter/material.dart';
import '/model/produk.dart';
import '/ui/produk_form.dart';

/// {@category UI}
/// Halaman yang menampilkan detail produk dan menyediakan option untuk mengedit atau menghapus produk.
class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  /// Konstruktor untuk `ProdukDetail` yang menerima object dari class Produk
  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override

  /// main build function ProdukDetail
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            /// Menampilkan kode produk
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),

            /// Menampilkan nama produk
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),

            /// Menampilkan harga produk
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  /// Membangun tombol untuk mengedit dan menghapus produk
  Widget _buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Edit button
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),

        /// Delete button
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => _confirmHapus(),
        ),
      ],
    );
  }

  /// Menampilkan dialog konfirmasi sebelum menghapus produk
  void _confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        /// Yes button
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            Navigator.pop(context);
            _hapusProduk();
          },
        ),

        /// No button
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      builder: (context) => alertDialog,
      context: context,
    );
  }

  /// Menghapus produk dengan memanggil `ProdukBloc.deleteProduk`
  /// dan menampilkan hasilnya kepada pengguna
  void _hapusProduk() async {
    bool success = await ProdukBloc.deleteProduk(id: widget.produk!.id);
    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage(),
        ),
      );
    } else {
      // Menampilkan dialog kesalahan jika penghapusan gagal
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Hapus gagal, silahkan coba lagi"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
