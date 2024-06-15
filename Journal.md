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