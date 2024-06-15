library ProdukForm;

import 'package:flutter/material.dart';
import '/bloc/produk_bloc.dart';
import '/model/produk.dart';
import '/ui/produk_page.dart';
import '/widget/warning_dialog.dart';

/// {@category UI}
/// form untuk untuk menambahkan atau mengedit produk.

class ProdukForm extends StatefulWidget {
  Produk? produk;

  /// Konstruktor untuk `ProdukForm` yang menerima object dari class Produk.
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  /// Mengecek apakah formulir ini untuk mengubah produk atau menambah,
  /// karena ada dua opsi
  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override

  /// main build fucntion ProdukForm
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Kode produk textbox
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,

      /// disini `_formKey` akan bermain, flutter memberikan argumen `value`
      /// setiap form untuk mengecek state
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  /// Nama produk textbox
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,

      /// disini `_formKey` akan bermain, flutter memberikan argumen `value`
      /// setiap form untuk mengecek state
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  /// Harga produk textbox
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,

      /// disini `_formKey` akan bermain, flutter memberikan argumen `value`
      /// setiap form untuk mengecek state
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  /// Button submit untuk konfirmasi perubahan atau penambahan
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          /// control flow status form apakah mengubah atau menambah
          if (!_isLoading) {
            if (widget.produk != null) {
              // kondisi update produk
              ubah();
            } else {
              // kondisi tambah produk
              simpan();
            }
          }
        }
      },
    );
  }

  /// Menyimpan produk baru
  void simpan() {
    setState(() {
      _isLoading = true;
    });

    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    /// `value` adalah hasil return dari ProdukBloc.addProduk()
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      setState(() {
        _isLoading = false;
      });

      if (value == true) {
        // Berhasil menyimpan produk
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const ProdukPage(),
          ),
        );
      } else {
        // Gagal menyimpan produk
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      }
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
  }

  /// Mengubah produk yang sudah ada
  void ubah() {
    setState(() {
      _isLoading = true;
    });

    /// Instansiasi dari Model Class produk
    Produk updateProduk = Produk(id: null);
    updateProduk.id = widget.produk!.id;
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

    /// `value` adalah hasil return dari ProdukBloc.updateProduk()
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      setState(() {
        _isLoading = false;
      });

      if (value == true) {
        // Berhasil mengubah produk
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const ProdukPage(),
          ),
        );
      } else {
        // Gagal mengubah produk
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ),
        );
      }
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
  }
}
