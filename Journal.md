# Project Journal - [11/06/2024]

<!-- ## Daily Log
- Learn about docker compose
    - trying to setup development environment via container
        - getting comfortable on docker
- Setup Github repositories
    - adding bunch of stuff that makes it more clean and structurable
    - trying to make a project that easy to understand (*docs)
    - giving links for reference


## Thoughts and Decisions
- Making journal and documentation for progress and guidence
- setup development environment via container because i thought it will be easier and not conflicting in the local
 -->

## Problems and Solutions

### Flutter

1. **Problem**: display `No internet connection setelah login`
    - **Solution**: cek koneksi database anda dengan api, kemungkinan belum di start

2. **Problem**: display `string? is not subtype of int setelah login`
    - **Solution**: masalah kemungkinan berada pada model `Produk` format saat mengambil data dari API

3. **Problem**: tidak bisa delete `Produk`
    - **Solution**: belum mengimplementasikan function delete wkwkw

4. **Problem**: berhasil mengedit `Produk` tetapi mengeluarkan dialog `warning` yang memberitahukan gagal edit produk
    - **Solution**: mengedit model `Produk` dengan mengambil data `status` agar nanti diberi control flow difile UI `produk_detail`

5. **Problem**: gagal login karena tidak menyimpan token
    - **Solution**: di file helpers api melupakan untuk menambahkan function Encode dalam data body (POST), karena kegagalan merequest ke api untuk data login

6. **Problem**: `Vertical viewport was given unbounded height.`
    - **Solution**: artinya si scrollable widget didalamnya tidak ada batasan, jadi sudah ada widget scrollable, terus didalanya ada scrollable ( double ) jadinya error

    jadinya mengganti ListView.builder menjadi CustomScrollView jadi pakai `sliverToBoxAdapter` untuk setiap section, dan untuk bagian list product pakai `sliverGrid` untuk mengatur grid didalamnya, gunakan  `crossAxisCount` untuk mengatur jumlah grid

6. **Problem**: `Card` widget tidak bisa resize
    - **Solution**: karena sudah diatur gridnya oleh `sliverGrid` maka memakai `childAspectRatio` untuk mengatur ukuran setiap Cardnya

7.  **Problem**: gambar dari `NetworkImage` widget tidak ada border
    - **Solution**: wrap widget `NetworkImage` pakai `ClipRRect` untuk mengatur border

8.  **Problem**: gambar dari `NetworkImage` widget tidak full cover
    - **Solution**: karena sebelumnya memakai `Expanded` widget yang mengambil semua space yang ada di card tersebut sampai batasan widget lain, dan adanya paksaan aturan `childAspectRatio` dari `sliverGrid` oleh karena itu memakai container sebagai pengganti

9. **Problem**: gambar yang ada di `Card` tidak adaptasi sesuai ukuran, jadi seperti fixed gitu
    - **Solution**: -

10. **Problem**: tidak bisa consume API dari flutter menggunakan device asli
    - **Solution**: atur development host kembali menggunakan `php spark serve --host your_ip`

11. **Problem**: saat menjalankan aplikasi flutter di device asli, layar hanya putih

    debug log :[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Binding has not yet been initialized. dan The "instance" getter on the ServicesBinding binding mixin is only available once that binding has been initialized.

    - **Solution**:  sisipkan kode `WidgetsFlutterBinding.ensureInitialized()` didalam main() function

    ```dart
        void main() async {
        WidgetsFlutterBinding.ensureInitialized();
        runApp(const MyApp());
    ```
    
}




## Todo 21/06/2024

- tambah fitur di drawer UI saja
- fix klo di expand product si image tidak fixed width, melainkan responsive


## Future

- added UI for solely searching product
- connecting flutter to api
- menambahkan skeleton saat loading produk