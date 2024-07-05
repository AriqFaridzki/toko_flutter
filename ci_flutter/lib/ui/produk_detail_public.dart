library ProdukDetail;

import 'package:ci_flutter/bloc/produk_bloc.dart';
import 'package:ci_flutter/ui/produk_page.dart';
import 'package:flutter/material.dart';
import '/model/produk.dart';
import '/ui/produk_form.dart';
import '../helpers/user_cart.dart';

/// {@category UI}
/// Halaman yang menampilkan detail produk dan menyediakan option untuk mengedit atau menghapus produk.
class ProdukDetailPublic extends StatefulWidget {
  final Produk? produk;

  /// Konstruktor untuk `ProdukDetail` yang menerima object dari class Produk
  ProdukDetailPublic({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailPublicState createState() => _ProdukDetailPublicState();
}

class _ProdukDetailPublicState extends State<ProdukDetailPublic> {
  @override

  /// main build function ProdukDetail
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.kyou.id/items/216082-kuripan-plushie-megumin-konosuba-17cm.jpg'), // Replace with actual image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                // verticalDirection: VerticalDirection.down,
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title and subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.produk!.namaProduk}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Plushie Megumin dengan ini subtitle',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: 8.0),

                      // Rating and review
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star_border),
                          SizedBox(width: 8.0),
                          Text('(320 Reviews)'),
                        ],
                      ),
                      SizedBox(height: 16.0),

                      // Availability
                      Row(
                        children: [
                          Text(
                            'Available in stock',
                            style: TextStyle(color: Colors.green),
                          ),
                          Spacer(),
                          Icon(Icons.check_circle, color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),

                  // // Size selection

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'Size',
                      //   style: TextStyle(
                      //     fontSize: 18.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 8.0),
                      // Row(
                      //   children: [
                      //     _buildSizeOption('S'),
                      //     _buildSizeOption('M'),
                      //     _buildSizeOption('L', isSelected: true),
                      //     _buildSizeOption('XL'),
                      //     _buildSizeOption('XXL'),
                      //   ],
                      // ),
                      // SizedBox(height: 16.0),

                      // // Color selection
                      // Text(
                      //   'Color',
                      //   style: TextStyle(
                      //     fontSize: 18.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 8.0),
                      // Row(
                      //   children: [
                      //     _buildColorOption(Colors.black),
                      //     _buildColorOption(Colors.yellow),
                      //     _buildColorOption(Colors.green, isSelected: true),
                      //   ],
                      // ),

                      AddSection(
                          sectionName: "Description",
                          description:
                              "Get ready to cause some explosions with this adorable Kuripe Kuripesu (Megumin) plushie! This officially licensed product is made from soft, plush fabric and features Megumin's iconic explosion staff and confident expression. The perfect size for cuddling or displaying, this Megumin plushie is sure to please fans of the anime series \"Konosuba: God's Blessing on this Wonderful World!\" "),
                    ],
                  ),

                  SizedBox(height: 16.0),
                  // Price and Add to cart button

                  SizedBox(height: 16.0),
                  // Edit and Delete buttons
                  // _buildButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            children: [
              Text(
                'Rp. ${widget.produk!.hargaProduk.toString()}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> item = {
                    "kodeProduk": widget.produk!.kodeProduk,
                    "namaProduk": widget.produk!.namaProduk,
                    "hargaProduk": widget.produk!.hargaProduk
                  }; // Replace with actual item details from your model
                  await addToCart(item);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                ),
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 2.0,
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

class AddSection extends StatelessWidget {
  final String sectionName;
  final String description;

  const AddSection(
      {super.key, required this.sectionName, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          sectionName,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
