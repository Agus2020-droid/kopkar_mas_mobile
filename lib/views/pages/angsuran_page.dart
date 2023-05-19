import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/models/list_angsuran.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';

class AngsuranPage extends StatefulWidget {
  const AngsuranPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  static String route = "angsuran_page";
  final String id;

  @override
  State<AngsuranPage> createState() => _AngsuranPageState();
}

class _AngsuranPageState extends State<AngsuranPage> {
  ListApiAngsuran? listApiAngsuran;
  Future getListAngsuran() async {
    final result = await KopkarMasApi().getAngsuran(widget.id);
    print(result.status);
    if (result.status == Status.success) {
      listApiAngsuran = ListApiAngsuran.fromJson(result.data!);
      final angsuran = listApiAngsuran!.data;
      setState(() {
        // print(angsuran);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListAngsuran();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50, // Tinggi App Bar
        automaticallyImplyLeading: true,
        backgroundColor: Color(0Xff142a4f),
        elevation: 2,
        title: Text(
          'Data Angsuran ',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: listApiAngsuran == null
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
                      Text(
                        "Loading...",
                        style:
                            TextStyle(fontSize: 20, color: Color(0Xff142a4f)),
                      )
                    ],
                  ),
                ),
              )
            : listApiAngsuran!.data!.isEmpty
                ? Center(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/search.png",
                                width: 150,
                              ),
                              Text(
                                'Maaf, belum ada angsuran',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: listApiAngsuran!.data!.length,
                    itemBuilder: (context, index) {
                      final currentResult = listApiAngsuran!.data![index];
                      final kd = currentResult.kreditKd!;
                      final tanggal = currentResult.tglAngsuran!;
                      final String metode = currentResult.metode!;
                      final double jml =
                          double.parse(currentResult.jmlAngsuran!);
                      return Container(
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     bottom: BorderSide(
                        //       color:
                        //           Color(0xff193552), // Gunakan customColors disini
                        //       width: 0.5,
                        //     ),
                        //   ),
                        // ),
                        child: ListAngsuran(
                          kode: kd,
                          tgl: tanggal,
                          mtd: metode,
                          jumlah: jml,
                        ),
                      );
                    }),
      ),
    );
  }
}

class ListAngsuran extends StatelessWidget {
  const ListAngsuran({
    Key? key,
    required this.kode,
    required this.tgl,
    required this.mtd,
    required this.jumlah,
  }) : super(key: key);

  final String kode;
  final String tgl;
  final String mtd;
  final double? jumlah;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xff193552),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  Text(
                    DateFormat("dd-MMM-yyy").format(DateTime.parse(tgl)),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  )
                ],
              )),
          Container(
            color: Colors.white,
            child: ListTile(
              // leading: Container(
              //     padding: EdgeInsets.all(5),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8),
              //         // color: Color(0xff193552)
              //         ),
              //     child: Column(
              //       children: [
              //         Icon(
              //           Icons.calendar_month,
              //           color: Color(0xff193552),
              //         ),
              //         Text(
              //           DateFormat("dd-MMM-yyy").format(DateTime.parse(tgl)),
              //           style: TextStyle(fontSize: 10, color: Colors.grey),
              //         )
              //       ],
              //     )),
              // title: Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [

              //   ],
              // ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Kode Kredit',
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: Colors.blue),
                      ),
                      Spacer(),
                      Text(
                        kode,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: Colors.lightGreen),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Metode',
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: Colors.blue),
                      ),
                      Spacer(),
                      Text(
                        mtd == '1'
                            ? 'Tunai'
                            : mtd == '2'
                                ? 'Transfer'
                                : mtd == '3'
                                    ? 'Potong Gaji'
                                    : '-',
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: Colors.lightGreen),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Angsuran',
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: Colors.blue),
                      ),
                      Spacer(),
                      Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                            .format(jumlah),
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: Colors.lightGreen),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
