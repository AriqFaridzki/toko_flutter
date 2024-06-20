import 'package:flutter/material.dart';
import 'package:shared_preferences_tools/shared_preferences_tools.dart';
import '/ui/login_page.dart';
import '/ui/produk_page.dart';
import '/ui/test.dart';
import '/helpers/user_info.dart';

void main() async {
  await SharedPreferencesToolsDebug.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    setState(() {
      if (token == null) {
        page = const LoginPage();
      } else {
        page = const ProdukPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
