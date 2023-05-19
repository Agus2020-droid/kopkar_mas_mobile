import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/models/list_shu.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/pages/detail_shu.dart';

class ShuPage extends StatefulWidget {
  const ShuPage({Key? key}) : super(key: key);

  @override
  State<ShuPage> createState() => _ShuPageState();
}

class _ShuPageState extends State<ShuPage> {
  ListDataShu? listDataShu;
  Future getShu() async {
    final result = await KopkarMasApi().getShu();
    if (result.status == Status.success) {
      listDataShu = ListDataShu.fromJson(result.data!);
      final shu = listDataShu!.data;
      setState(() {
        print(shu);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShu();
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
            'SHU Saya',
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          centerTitle: false,
          actions: [
            // TextButton(
            //     onPressed: () {},
            //     child: IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         Icons.add,
            //         color: Colors.white,
            //       ),
            //       tooltip: 'Tambah Kredit',
            //     ))
          ],
        ),
        body: listDataShu == null
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
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
            : listDataShu!.data!.isEmpty
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
                                'Belum ada data',
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
                    itemCount: listDataShu!.data!.length,
                    itemBuilder: (context, int index) {
                      final currentShu = listDataShu!.data![index];

                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            ListShu(
                              thnBuku: currentShu.thnBuku!,
                              tglShu: currentShu.tglShu!,
                              nm_bank: currentShu.nmBank!,
                              rekening: currentShu.noRek!,
                              jmlShu: double.parse(currentShu.jmlShu!),
                              idShu: currentShu.idShu,
                            ),
                          ],
                        ),
                      );
                    }));
  }
}

class ListShu extends StatelessWidget {
  const ListShu({
    Key? key,
    required this.thnBuku,
    this.tglShu,
    required this.nm_bank,
    required this.rekening,
    this.jmlShu,
    this.idShu,
  }) : super(key: key);

  final String thnBuku;
  final String nm_bank;
  final String rekening;
  final String? tglShu;
  final double? jmlShu;
  final int? idShu;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.blueGrey.withOpacity(0.25))
          ]),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailShu(id: idShu!)));
        },
        child: ListTile(
            leading: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff193552)),
                child: Text(
                  'SHU',
                  style: TextStyle(color: Colors.white),
                )),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat("dd-MMM-yyy").format(DateTime.parse(tglShu!)),
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 10),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tahun Buku',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 12),
                    ),
                    Spacer(),
                    Text(thnBuku,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 12))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nama Bank ',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 12),
                    ),
                    Spacer(),
                    Text(nm_bank,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 12))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'No. Rekening',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 12),
                    ),
                    Spacer(),
                    Text(rekening,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 12))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah SHU',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(jmlShu),
                      style: TextStyle(
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
