import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/contents/R/r.dart';
import 'package:kopkar_mas_app/models/list_simpanan.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/total_simpanan.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';

class SimpananPage extends StatefulWidget {
  const SimpananPage({Key? key}) : super(key: key);

  @override
  State<SimpananPage> createState() => _SimpananPageState();
}

class _SimpananPageState extends State<SimpananPage> {
  ListApiSimpanan? listApiSimpanan;
  Future _getListApiSimpanan() async {
    final result = await KopkarMasApi().getSimpanan();
    // print(result.data);
    if (result.status == Status.success) {
      listApiSimpanan = ListApiSimpanan.fromJson(result.data!);
      setState(() {
        print(listApiSimpanan!.data);
      });
    }
  }

  TotalApiSimpanan? totalApiSimpanan;
  Future _getTotalApiSimpanan() async {
    final result = await KopkarMasApi().getTotalSimpanan();
    if (result.status == Status.success) {
      totalApiSimpanan = TotalApiSimpanan.fromJson(result.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getListApiSimpanan();
    _getTotalApiSimpanan();
  }

  @override
  Widget build(BuildContext context) {
    // print(simpanan);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50, // Tinggi App Bar
          automaticallyImplyLeading: true,
          backgroundColor: Color(0Xff142a4f),
          elevation: 2,
          title: Text(
            'Simpanan Saya',
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            totalApiSimpanan == null
                ? Container(
                    padding: EdgeInsets.only(
                        top: 28, bottom: 50, left: 50, right: 25),
                    decoration: BoxDecoration(
                        color: Color(0Xff142a4f),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.only(right: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45.0),
                                    child: Image.asset(
                                      R.assets.imgBook,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ),
                                    // Icon(
                                    //   Icons.menu_book,
                                    //   color: Colors.white,
                                    //   size: 50,
                                    // ),
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
                                    // SkeletonAnimation(
                                    //   shimmerColor: Colors.grey,
                                    //   borderRadius: BorderRadius.circular(20),
                                    //   shimmerDuration: 1000,
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.grey[300],
                                    //       borderRadius:
                                    //           BorderRadius.circular(20),
                                    //       // boxShadow: shadowList,
                                    //     ),
                                    //     margin: EdgeInsets.only(top: 40),
                                    //   ),
                                    // ),
                                    Text(
                                      'Saldo',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 2)
                                          .format(0),
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
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
                  )
                : Container(
                    padding: EdgeInsets.only(
                        top: 28, bottom: 50, left: 50, right: 25),
                    decoration: BoxDecoration(
                        color: Color(0Xff142a4f),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.only(right: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45.0),
                                    child: Image.asset(
                                      R.assets.imgBook,
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                    ),
                                    // Icon(
                                    //   Icons.menu_book,
                                    //   color: Colors.white,
                                    //   size: 50,
                                    // ),
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
                                      'Saldo',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 2)
                                          .format(totalApiSimpanan!.data),
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
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
            listApiSimpanan == null
                ? Container(
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            // value: 0.5,
                            backgroundColor: Color(0xff142a4f),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
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
                // SkeletonAnimation(
                //     shimmerColor: Colors.grey,
                //     borderRadius: BorderRadius.circular(20),
                //     shimmerDuration: 1000,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.grey[300],
                //         borderRadius: BorderRadius.circular(20),
                //         // boxShadow: shadowList,
                //       ),
                //       margin: EdgeInsets.only(top: 40),
                //     ),
                //   )
                // ||
                : listApiSimpanan!.data!.isEmpty
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
                            itemCount: listApiSimpanan!.data!.length,
                            itemBuilder: (context, int index) {
                              final currentSimpanan =
                                  listApiSimpanan!.data![index];
                              final tglSimpanan = currentSimpanan.tglSimpanan;
                              final jumlah =
                                  double.parse(currentSimpanan.jmlSimpanan!);
                              final status = currentSimpanan.stts;
                              final keterangan = currentSimpanan.ket;
                              return Container(
                                color: Colors.white,
                                child: ListTile(
                                    // leading: Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(45),
                                    //       // color: Color(0xff193552)
                                    //     ),
                                    //     child: Icon(
                                    //       status == '1'
                                    //           ? Icons.add_box
                                    //           : Icons.remove_circle,
                                    //       color: status == '1'
                                    //           ? Colors.blue
                                    //           : Colors.red,
                                    //     )),
                                    title: Row(
                                      children: [
                                        Text(
                                          keterangan!,
                                          style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          DateFormat("dd-MMM-yyy").format(
                                              DateTime.parse(tglSimpanan!)),
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              status == '1'
                                                  ? 'Kredit'
                                                  : 'Debet',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  fontSize: 12),
                                            ),
                                            Spacer(),
                                            Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: "Rp. ",
                                                        decimalDigits: 2)
                                                    .format(jumlah),
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    color: status == '1'
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontSize: 12))
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            })),
          ],
        ));
  }
}
