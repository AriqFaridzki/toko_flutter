///
/// ### Terminologies
///
/// #### Main Component UI Flutter
/// - Widget: Komponen dasar dalam Flutter yang digunakan untuk membangun antarmuka pengguna.
/// - StatefulWidget: Widget yang memiliki state yang dapat berubah.
/// - State: Objek yang menampung state dari StatefulWidget dan menyediakan metode untuk mengubah state tersebut.
/// - AppBar: Widget di bagian atas aplikasi yang biasanya digunakan untuk menampilkan judul dan tindakan (actions).
/// - Drawer: Panel navigasi yang dapat digeser dari sisi layar.
/// - ListView.builder: Widget yang membuat daftar dari widget yang dibangun berdasarkan item dalam daftar.
///
/// #### Hal yang akan berhubungan dengan data
/// - FutureBuilder: Widget yang membangun widget berdasarkan interaksi dengan Future.
/// - Future: Objek yang mewakili operasi asinkron.
/// - Snapshot: Representasi status saat ini dari Future. (data itu sendiri)
/// - GestureDetector: Widget yang mendeteksi gestur pengguna.
///
/// #### Routing
/// - Navigator: Objek yang mengelola stack rute untuk aplikasi Anda dan memungkinkan navigasi antar halaman.
/// - MaterialPageRoute: Rute yang menggunakan transisi material design untuk navigasi.
///
///
///### For more information on this contact:
/// - GitHub: AriqFaridzki
///

library ProdukPage;

import 'package:flutter/material.dart';
import '/bloc/logout_bloc.dart';
import '/bloc/produk_bloc.dart';
import '/model/produk.dart';
import '/ui/login_page.dart';
import '/ui/produk_detail.dart';
import '/ui/produk_form.dart';

/// {@category UI}
/// Halaman utama untuk menampilkan daftar produk.
class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),

        /// `action` ini adalah properti dari [appBar] yang nanti akan menerima daftar widget
        ///
        /// daftar widget ini salah satunya [Padding], yang nantinya ditambahkan icon
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),

            /// `GestureDetector` mendeteksi aksi user, dalam hal ini ketika klik `onTap`
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                /// pergi ke halaman produk form
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukForm()),
                );
              },
            ),
          ),
        ],
      ),

      /// Bagian samping kanan atas yang di [appBar], nanti akan mengeluarkan panel besar
      ///
      ///
      /// Drawer adalah panel navigasi yang dapat digeser dari kiri atau kanan layar.
      /// Dalam hal ini, Drawer berisi satu [ListTile] yang digunakan untuk logout.
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ),
                    });
              },
            ),
          ],
        ),
      ),

      /// bagian utama dibawah AppBar
      ///
      ///
      /// [FutureBuilder] adalah widget yang membuat widget lagi setelah data dapat dari API
      /// Ini digunakan untuk mengambil data secara asinkron dan menampilkan hasilnya di UI.
      body: FutureBuilder<List<Produk>>(
        /// future disini akan mengambil semua produk dari api
        future: ProdukBloc.getProduks(),

        /// setelah data diambil, data tersebut akan dimasukan ke widget `ListProduk`
        ///
        /// snapshot: Data yang diambil dari Future.
        /// snapshot memiliki beberapa properti yang relevan seperti [hasError], [hasData], dan [data].
        ///
        /// [data] itu sendiri adalah data Produk
        builder: (context, snapshot) {
          /// kalau ada error saat pengambilan data
          if (snapshot.hasError) {
            // print(snapshot.error);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          /// kalau tidak ada data
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListProduk(list: snapshot.data);
        },
      ),
    );
  }
}

/// `ListProduk` untuk container untuk data Produk
///
/// tugasnya memberikan berapa card produk yang harus di produksi
///
class ListProduk extends StatelessWidget {
  final List<Produk>? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override

  /// main builder function ListProduk
  Widget build(BuildContext context) {
    return ListView.builder(
      /// `itemCount` adalah berapa jumlah yang ingin diproduksi
      ///
      /// dalam hal ini berapa jumlah yang ada pada list<Produk>
      /// kalau null (kosong) maka akan di set 0
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        /// tanda ! pada `list!` itu maksudnya list itu memang tidak kosong,
        /// karena dart sensitif dengan variable yang kosong
        ///
        /// ItemProduk ini untuk menghasilkan card produk itu sendiri
        return ItemProduk(produk: list![i]);
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk!),
          subtitle: Text(produk.hargaProduk.toString()),
        ),
      ),
    );
  }
}
