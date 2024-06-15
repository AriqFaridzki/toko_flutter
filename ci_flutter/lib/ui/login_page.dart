library LoginPage;

import '/ui/registrasi_page.dart';
import 'package:flutter/material.dart';
import '/bloc/login_bloc.dart';
import '/helpers/user_info.dart';
import '/ui/produk_page.dart';
import '/widget/warning_dialog.dart';

/// {@category UI}
/// Halaman yang menampilkan login untuk user atau opsi registrasi

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// digunakan untuk mengecek state form email dan password
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  /// for managing textbox
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  /// main component build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailTextField(),
                _passwordTextField(),
                spacer(30),
                _buttonLogin(),
                spacer(30),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// untuk mengatur jarak antar widget lain
  Widget spacer(double height) {
    return Container(
      height: height,
      // color: Colors.amber,
    );
  }

  /// email text field
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,

      /// disini `_formKey` akan bermain, flutter memberikan argumen `value`
      /// setiap form untuk mengecek state
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
    );
  }

  /// password text field
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,

      /// disini `_formKey` akan bermain, flutter memberikan argumen `value`
      /// setiap form untuk mengecek state
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  /// button login
  Widget _buttonLogin() {
    return ElevatedButton(
      child: const Text("Login"),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  /// submit function untuk login button
  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      /// `value` ini dari hasil return `LoginBloc.login`
      if (value.token != null && value.token!.isNotEmpty) {
        // print('Login Page : Token received = ${value.token}');

        /// set token untuk user
        await UserInfo().setToken(value.token!);
        // print('Token saved to SharedPreferences');

        // String? savedToken = await UserInfo().getToken();
        // print('Token retrieved from SharedPreferences: $savedToken');

        /// sukses login maka akan ke pindah ke UI`ProdukPage()`
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Email atau password tidak valid",
          ),
        );
      }
    }).catchError((error) {
      // print('Error during login: $error');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  /// widget teks link untuk register
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistrasiPage(),
            ),
          );
        },
      ),
    );
  }
}
