import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/views/main_page.dart';

class ResultSuccess extends StatefulWidget {
  const ResultSuccess({Key? key}) : super(key: key);

  @override
  State<ResultSuccess> createState() => _ResultSuccessState();
}

class _ResultSuccessState extends State<ResultSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff142a4f),
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
                        color: Colors.white,
                      )),
                  Text(
                    "Tutup",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150),
              Text(
                "Selamat",
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Colors.white,
                    fontSize: 24),
              ),
              SizedBox(
                height: 34,
              ),
              Image.asset(
                "assets/success.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Pengajuan berhasil disimpan',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
