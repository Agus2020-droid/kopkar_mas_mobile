import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:kopkar_mas_app/repository/auth_api.dart';
import 'package:kopkar_mas_app/views/login_page.dart';
import 'package:kopkar_mas_app/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  Dataku? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {
      // print(dataUser!.user);
    });
  }

  _verifikasi() async {
    // const url = 'http://127.0.0.1:8000/email/verify';
    const url = 'https://kopkarmas.com/email/verify';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final nama = dataUser!.user!.name;
    final foto = dataUser!.user!.foto;
    return Scaffold(
      backgroundColor: Color(0Xff142a4f),
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        title: RichText(
          text: TextSpan(
            text: "Hai, ",
            style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 14,
                color: Colors.white.withOpacity(0.8)),
            children: [
              TextSpan(
                text: "$nama",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showDialogLogout(context);
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 50, top: 15, bottom: 15),
              width: 50,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45.0),
                child: Image.network(
                  'https://kopkarmas.com/storage/public/foto_user/$foto',
                  height: 40,
                  width: 40,
                ),
              ),

              // Image.asset(
              //   R.assets.imgUser,
              //   fit: BoxFit.contain,
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  )
                ],
              ),
            ),
          ),
        ],
        backgroundColor: Color(0xff142a4f),
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Silahkan verifikasi email Anda.',
              style: TextStyle(color: Colors.white),
            ),
            GestureDetector(
              child: ButtonLogin(
                  backgroundColor: Colors.amber,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Verifikasi Email',
                        style: new TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Color(0Xff142a4f)),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            _verifikasi();
                          },
                      ),
                    ]),
                  ),
                  // Text(
                  //   'Klik disini',
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w500,
                  //       color: Color(0Xff142a4f)),
                  // ),
                  borderColor: Color(0Xff142a4f),
                  onTap: () {
                    _verifikasi();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

void _showDialogLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Color(0Xff142a4f),
        title: new Text(
          "Logout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: new Text("Keluar dari aplikasi ?",
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            onPressed: () async {
              // BottomsheetConfirmation();
              final pref = await SharedPreferences.getInstance();
              final result = await AuthApi().postLogout();
              if (result.status == Status.success) pref.clear();
              // print(result.data);
              // Navigator.pop(context);
              // Fluttertoast.showToast(
              //   msg: "Anda telah logout",
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              //   timeInSecForIosWeb: 1,
              //   backgroundColor: Colors.green,
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
              if (Platform.isWindows) Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false,
              );

              SystemNavigator.pop();

              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => SplashScreen()),
              //   (route) => false,
              // );

              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: const Text(
              'OK',
            ),
          ),
        ],
      );
    },
  );
}
