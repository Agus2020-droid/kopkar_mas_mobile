import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/repository/auth_api.dart';
import 'package:kopkar_mas_app/views/pages/home_page2.dart';
import 'package:kopkar_mas_app/views/pages/pesan_page.dart';
import 'package:kopkar_mas_app/views/pages/setting_page.dart';
import 'package:kopkar_mas_app/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.initialPage}) : super(key: key);
  static String route = "main_page";
  final int initialPage;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pc = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
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
                          style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        if (Platform.isWindows) Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()),
                          (route) => false,
                        );

                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'OK',
                      ),
                    ),
                  ],
                ));
        return confirm;
      },
      child: Scaffold(
        bottomNavigationBar: _buildBottomNavigation(),
        body: PageView(
          controller: _pc,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage2(), //0
            SettingPage(), //1
            PesanPage(), //2
          ],
        ),
      ),
    );
  }

  _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 40,
            color: Colors.black.withOpacity(0.06))
      ]),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          height: 60,
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5, left: 12, right: 12),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: index == 0 ? Color(0xff142a4f) : Colors.white,
                  child: InkWell(
                    onTap: () {
                      index = 0;
                      _pc.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceInOut);
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: 25,
                          color: index == 0 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          "Beranda",
                          style: TextStyle(
                              color: index == 0 ? Colors.amber : Colors.grey,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5, left: 12, right: 12),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: index == 1 ? Color(0xff142a4f) : Colors.white,
                  child: InkWell(
                    onTap: () {
                      index = 1;
                      _pc.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceInOut);
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 25,
                          color: index == 1 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          "Tentang",
                          style: TextStyle(
                              color: index == 1 ? Colors.amber : Colors.grey,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: index == 2 ? Color(0xff142a4f) : Colors.white,
                  child: InkWell(
                    onTap: () {
                      index = 2;
                      _pc.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceInOut);
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 25,
                              color: index == 2 ? Colors.amber : Colors.grey,
                            ),
                          ],
                        ),
                        Text(
                          "Pesan",
                          style: TextStyle(
                              color: index == 2 ? Colors.amber : Colors.grey,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: index == 3 ? Colors.red.shade900 : Colors.white,
                    child: InkWell(
                      onTap: () {
                        index = 3;
                        // _pc.animateToPage(index,
                        //     duration: Duration(milliseconds: 500),
                        //     curve: Curves.easeInOut);
                        setState(() {
                          _showDialogLogout(context);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.exit_to_app,
                              size: 25,
                              color: index == 3 ? Colors.white : Colors.grey),
                          Text(
                            "Keluar",
                            style: TextStyle(
                                color: index == 3 ? Colors.white : Colors.grey,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                        // children: [
                        //   Image.asset(
                        //     R.assets.imgUser,
                        //     height: 30,
                        //   ),
                        //   Text("Akun")
                        // ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
