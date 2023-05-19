import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/contents/R/r.dart';
import 'package:kopkar_mas_app/models/list_kredit.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/sisa_kredit.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/pages/detail_kredit_page.dart';

class KreditPage extends StatefulWidget {
  const KreditPage({Key? key}) : super(key: key);

  @override
  State<KreditPage> createState() => _KreditPageState();
}

class _KreditPageState extends State<KreditPage> {
  ListApiKredit? listApiKredit;
  Future<void> getListApiKredit() async {
    final result = await KopkarMasApi().getKredit();
    // print(result.data);
    if (result.status == Status.success) {
      listApiKredit = ListApiKredit.fromJson(result.data!);

      setState(() {});
    }
  }

  SisaKredit? sisaKredit;
  getTotalSisa() async {
    final result = await KopkarMasApi().getSisaKredit();
    print(result.status);
    if (result.status == Status.success) {
      sisaKredit = SisaKredit.fromJson(result.data!);

      if (result.data!.isEmpty != null) {
        return sisaKredit;
      } else {
        return 0;
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListApiKredit();
    getTotalSisa();
  }

  @override
  Widget build(BuildContext context) {
    // final amount =
    //     int.parse(listApiKredit!.data!.datakredit!.sisa!.first.jumlahSisa!);

    // print(amount);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Tinggi App Bar
          automaticallyImplyLeading: true,
          backgroundColor: Color(0Xff142a4f),
          elevation: 2,
          title: Text(
            'Kredit Saya',
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          centerTitle: false,
        ),
        body: listApiKredit == null
            ? Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 100),
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 28, bottom: 28, left: 25, right: 15),
                    decoration: BoxDecoration(
                        color: Color(0Xff142a4f),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  margin: EdgeInsets.only(right: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45.0),
                                    child: Image.asset(
                                      R.assets.imgKredit,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 45,
                                  //   child: VerticalDivider(
                                  //     color: Colors.amber, // warna garis horizontal
                                  //     thickness: 2.0, // ketebalan garis horizontal
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sisa Kredit',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                    sisaKredit == null ||
                                            sisaKredit!.data!.isEmpty
                                        ? Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: "Rp. ",
                                                    decimalDigits: 0)
                                                .format(0),
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          )
                                        : Text(
                                            NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: "Rp. ",
                                                    decimalDigits: 0)
                                                .format(int.parse(sisaKredit!
                                                    .data!.first.jumlahSisa!
                                                    .toString())),
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                  ],
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  //line
                  listApiKredit!.data!.isEmpty
                      // || sisaKredit!.data!.isEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            getListApiKredit();
                          },
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
                                      'Belum ada transaksi',
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: listApiKredit!.data!.length,
                              itemBuilder: (context, int index) {
                                final currentKredit =
                                    listApiKredit!.data![index];

                                return ListKredit(
                                  id_kredit: currentKredit.idKredit!.toInt(),
                                  kd_kredit: currentKredit.kdKredit!,
                                  jns_kredit: currentKredit.jnsKrdt!,
                                  tglKredit: currentKredit.tglKredit,
                                  plafon: double.parse(currentKredit.nominal!),
                                  appketua: currentKredit.appKet,
                                  appPetugas: currentKredit.appPtgs,
                                  appBnd: currentKredit.appBnd,
                                );
                              }),
                        )
                ],
              ));
  }
}

class ListKredit extends StatelessWidget {
  const ListKredit({
    Key? key,
    required this.kd_kredit,
    this.tglKredit,
    required this.jns_kredit,
    this.plafon,
    required this.id_kredit,
    this.appketua,
    this.appPetugas,
    this.appBnd,
  }) : super(key: key);

  final int id_kredit;
  final String kd_kredit;
  final String? tglKredit;
  final String jns_kredit;
  final double? plafon;
  final String? appketua;
  final String? appPetugas;
  final String? appBnd;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (appPetugas == '1' && appBnd == '1' && appketua == '1') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailKreditPage(id: id_kredit)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  'Maaf, status pengajuan masih dalam proses verifikasi')));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          // leading: Container(
          //     padding: EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: Color(0xff193552)),
          //     child: Icon(
          //       Icons.handshake,
          //       color: Colors.white,
          //     )),
          title: Row(
            children: [
              Text(
                'No. ' + kd_kredit,
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              Spacer(),
              Text(
                DateFormat("dd-MMM-yyy").format(DateTime.parse(tglKredit!)),
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 12),
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    jns_kredit,
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 12),
                  ),
                  Spacer(),
                  Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(plafon),
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 12))
                ],
              ),
              Divider(
                color: Colors.amber,
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Approval',
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 12),
                  ),
                  Spacer(),
                  Text('Petugas',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 12)),
                  SizedBox(width: 3),
                  Icon(
                    appPetugas == '1'
                        ? Icons.check_circle
                        : appPetugas == '2'
                            ? Icons.dangerous
                            : Icons.warning_amber_rounded,
                    size: 14,
                    color: appPetugas == '1'
                        ? Colors.blue
                        : appPetugas == '2'
                            ? Colors.red
                            : Colors.amber,
                  ),
                  SizedBox(width: 8),
                  Text('Bendahara',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 12)),
                  SizedBox(width: 3),
                  Icon(
                    appBnd == '1'
                        ? Icons.check_circle
                        : appBnd == '2'
                            ? Icons.dangerous
                            : Icons.warning_amber_rounded,
                    size: 14,
                    color: appBnd == '1'
                        ? Colors.blue
                        : appBnd == '2'
                            ? Colors.red
                            : Colors.amber,
                  ),
                  SizedBox(width: 8),
                  Text('Ketua',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 12)),
                  SizedBox(width: 3),
                  Icon(
                    appketua == '1'
                        ? Icons.check_circle
                        : appketua == '2'
                            ? Icons.dangerous
                            : Icons.warning_amber_rounded,
                    size: 14,
                    color: appketua == '1'
                        ? Colors.blue
                        : appketua == '2'
                            ? Colors.red
                            : Colors.amber,
                  )
                ],
              ),
            ],
          ),
          // trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
