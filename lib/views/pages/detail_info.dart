
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/models/detail_info.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';

class DetailInfoPage extends StatefulWidget {
  const DetailInfoPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<DetailInfoPage> createState() => _DetailInfoPageState();
}

class _DetailInfoPageState extends State<DetailInfoPage> {
  DetailInfo? detailInfo;
  getInfoDetail() async {
    final result = await KopkarMasApi().getDetailInfo(widget.id);
    detailInfo = DetailInfo.fromJson(result.data!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Info"),
      ),
      body: detailInfo == null
          ? Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      // value: 0.5,
                      backgroundColor: Color(0xff142a4f),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 6.0,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Loading...",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily))
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      child: Image.network(
                          'https://kopkarmas.com/storage/public/foto_info/' +
                              detailInfo!.data!.first.picture!)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(detailInfo!.data!.first.judul!,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        Text(
                            DateFormat("dd-MMM-yyy").format(DateTime.parse(
                                detailInfo!.data!.first.tglInfo!)),
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 10,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          height: 10,
                          color: Color(0xff142a4f),
                        ),
                        Text(detailInfo!.data!.first.isi!,
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
