import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/contents/R/r.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:kopkar_mas_app/repository/auth_api.dart';
import 'package:kopkar_mas_app/views/main_page.dart';
import 'package:kopkar_mas_app/views/register_page.dart';
import 'package:kopkar_mas_app/views/verification_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "login_page";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _telpController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = true;
  String? Function(String?)? validator;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _loginData = {};

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  read() async {
    final prefs = await PreferenceHelper().getUserData();
    final token = prefs.token;
    final verify = prefs.user!.emailVerifiedAt;
    print("keyToken : ");
    print(token);
    print(verify);
    if (verify != null) {
      if (token != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(MainPage.route, (context) => false);
      }
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerificationPage()));
    }
  }

  _resetPassword() async {
    const url = 'https://kopkarmas.com/password/reset';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120, // Tinggi App Bar
        backgroundColor: Color(0xfffafafa),
        flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
          'assets/banner.png',
          fit: BoxFit.cover,
        )),
      ),
      // backgroundColor: Color(0xff193552),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: Container(
                  width: double.infinity,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/banner.png"),
                  //         fit: BoxFit.contain)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        minRadius: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            R.assets.imgLogo,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "KOPERASI KARYAWAN",
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Makmur Alam Sejahtera",
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Jl. Raya Salatiga -  Solo KM.08 Ds. Butuh Kec. Tengaran",
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      Text(
                        "Kab. Semarang - Jawa Tengah",
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                        child: Column(
                          children: [
                            Text(
                              "LOGIN untuk memulai sesi Anda",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _telpController,
                              validator: (Value) {
                                if (Value == null || Value.isEmpty) {
                                  return 'Nomor HP field is required';
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff142a4f)),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.phone),
                                ),
                                labelText: 'Nomor WhatsApp',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _passwordController,
                              validator: (Value) {
                                if (Value == null || Value.isEmpty) {
                                  return 'Password field is required';
                                }
                              },
                              obscureText: _showPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff142a4f)),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  icon: _showPassword == false
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ButtonLogin(
                                backgroundColor: Color(0Xff142a4f),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                borderColor: Color(0Xff142a4f),
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _loginData['telp'] = _telpController.text;
                                    _loginData['password'] =
                                        _passwordController.text;
                                  }

                                  final json = {
                                    "telp": _telpController.text,
                                    "password": _passwordController.text,
                                  };
                                  final result =
                                      await AuthApi().postLogin(json);

                                  // print('status Kode');
                                  // print(result.statusCode);
                                  // print('=============');
                                  // print('status Error');
                                  // print(result.status);
                                  // print('=============');

                                  if (result.status == Status.success) {
                                    final loginResult =
                                        Login.fromJson(result.data!);
                                    print(loginResult.status);

                                    if (loginResult.status == 'success') {
                                      await PreferenceHelper().setUserData(
                                          loginResult.data!.dataku!);
                                      print(loginResult.data!.dataku!);
                                      final verify = loginResult
                                          .data!.dataku!.user!.emailVerifiedAt;
                                      if (verify != null) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                MainPage.route,
                                                (context) => false);
                                      } else {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerificationPage()));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(loginResult.message!),
                                      ));
                                    }
                                    ;
                                  } else if (result.status == Status.error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.red.shade900,
                                            content: Text(
                                              'Gagal login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.red.shade900,
                                            content: Text('Tidak ada jaringan',
                                                style: TextStyle(
                                                    color: Colors.white))));
                                  }
                                  ;
                                  ;
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: 'Lupa Password',
                                          style: new TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            color: Color(0Xff142a4f),
                                          ),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              _resetPassword();
                                            })),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Register',
                                        style: new TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            color: Color(0Xff142a4f)),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage()));
                                          },
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Versi ' + _packageInfo.version)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.borderColor,
    required this.onTap,
    this.radius,
  }) : super(key: key);
  final double? radius;
  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 25),
            side: BorderSide(
              color: borderColor,
            ),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
