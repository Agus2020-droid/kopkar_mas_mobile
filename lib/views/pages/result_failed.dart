import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/views/main_page.dart';

class FailedPage extends StatefulWidget {
  const FailedPage({Key? key}) : super(key: key);

  @override
  State<FailedPage> createState() => _FailedPageState();
}

class _FailedPageState extends State<FailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // resultData == null
              //     ? Center(child: CircularProgressIndicator())
              //     :
              Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainPage(
                                  initialPage: 0,
                                )));
                      },
                      icon: Icon(
                        Icons.close,
                        color: Color(0Xff142a4f),
                      )),
                  Text(
                    "Tutup",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Color(0Xff142a4f),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),
              Text(
                "Gagal",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Color(0Xff142a4f),
                    fontSize: 24),
              ),
              SizedBox(
                height: 34,
              ),
              Image.asset(
                "assets/cancel.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Maaf belum berhasil, silahkan coba kembali',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Color(0Xff142a4f),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
