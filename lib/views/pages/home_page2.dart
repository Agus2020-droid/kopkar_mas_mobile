import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/contents/R/r.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/get_status.dart';
import 'package:kopkar_mas_app/models/list_info.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/sisa_kredit.dart';
import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/pages/detail_info.dart';
import 'package:kopkar_mas_app/views/pages/informasi_page.dart';
import 'package:kopkar_mas_app/views/pages/kredit_page.dart';
import 'package:kopkar_mas_app/views/pages/profile_page.dart';
import 'package:kopkar_mas_app/views/pages/shu_page.dart';
import 'package:kopkar_mas_app/views/pages/simpanan_page.dart';
import 'package:kopkar_mas_app/views/pages/tambah_kredit_barang.dart';
import 'package:kopkar_mas_app/views/pages/tambah_kredit_kendaraan.dart';
import 'package:kopkar_mas_app/views/pages/tambah_kredit_tunai.dart';
import 'package:kopkar_mas_app/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  Dataku? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {
      // print(dataUser!.user);
    });
  }

  SisaKredit? sisaKredit;
  getTotalSisa() async {
    final result = await KopkarMasApi().getSisaKredit();
    print(result.status);
    if (result.status == Status.success) {
      sisaKredit = SisaKredit.fromJson(result.data!);
      setState(() {});
    }
  }

  GetStatusUser? statusUser;
  getStatus() async {
    final result = await KopkarMasApi().getUserStatus();
    print(result.status);
    if (result.status == Status.success) {
      statusUser = GetStatusUser.fromJson(result.data!);
      setState(() {
        // print(statusUser!.data);
      });
    }
  }

  ListInfo? listInfo;
  getInfoList() async {
    final result = await KopkarMasApi().getInformasi();
    print("Info");
    print(result.status);
    if (result.status == Status.success) {
      listInfo = ListInfo.fromJson(result.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getTotalSisa();
    getStatus();
    getInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return dataUser == null
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
                    style: TextStyle(fontSize: 20, color: Color(0Xff142a4f)),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              title: RichText(
                text: TextSpan(
                  text: "Hai, ",
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8)),
                  children: [
                    TextSpan(
                      text: dataUser!.user!.name,
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
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 30, top: 15, bottom: 15),
                    width: 50,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.0),
                      child: Image.network(
                        'https://kopkarmas.com/storage/public/foto_user/' +
                            dataUser!.user!.foto!,
                        // 'http://127.0.0.1:8000/storage/foto_user/$foto',
                        fit: BoxFit.cover,
                        height: 10,
                        width: 10,
                      ),
                    ),
                    // Image.asset(
                    //   R.assets.imgUser,
                    //   fit: BoxFit.contain,
                    // ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              backgroundColor: Color(0xff142a4f),
              elevation: 0,
            ),
            body: Stack(
              children: [
                ClipPath(
                  clipper: ClipPathClass(),
                  child: Container(
                    height: 200,
                    // width: Get.width,
                    width: Get.width * 100,
                    color: Color(0xff142a4f),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          ClipPath(
                            clipper: ClipInfoClass(),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 30, 62, 117),
                                      Color.fromARGB(255, 72, 109, 172),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 20,
                                        color: Colors.white.withOpacity(0.25))
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 30),
                                          Text(
                                            "Transformasi Digital Koperasi",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            "Kopkar-MAS Mobile",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        R.assets.imgLogo,
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        // '10 Feb 2023',
                                        DateFormat('dd/MM/yyy')
                                            .format(DateTime.now()),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {},
                                      //   child: Text(
                                      //     "Panduan User",
                                      //     style: TextStyle(
                                      //       fontFamily:
                                      //           GoogleFonts.poppins().fontFamily,
                                      //       fontSize: 12,
                                      //     ),
                                      //   ),
                                      //   // Icon(Icons.remove_red_eye),
                                      //   style: ElevatedButton.styleFrom(
                                      //     primary: Colors.amber,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  // SizedBox(height: 10),
                                  // Divider(
                                  //   color: Colors.black,
                                  // ),
                                  // SizedBox(height: 10),
                                  // RichText(
                                  //   text: TextSpan(
                                  //     text: "Berlaku sampai ",
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //     ),
                                  //     children: [
                                  //       TextSpan(
                                  //         text: "19 April 2020",
                                  //         style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(height: 10),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       "Telkomsel POIN",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //       ),
                                  //     ),
                                  //     SizedBox(width: 10),
                                  //     Container(
                                  //       padding: EdgeInsets.symmetric(
                                  //         horizontal: 10,
                                  //         vertical: 8,
                                  //       ),
                                  //       decoration: BoxDecoration(
                                  //         color: Color(0xFFF7B731),
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       child: Text(
                                  //         "172",
                                  //         style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 15),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         width: 150,
                          //         padding: const EdgeInsets.all(16),
                          //         decoration: BoxDecoration(
                          //             // border: Border.all(),
                          //             color: Colors.white,
                          //             borderRadius: BorderRadius.circular(5),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                   blurRadius: 10,
                          //                   color:
                          //                       Color(0xff142a4f).withOpacity(0.25))
                          //             ]),
                          //         child: Column(
                          //           children: [
                          //             Text(
                          //               'Simpanan',
                          //               style: TextStyle(
                          //                   fontFamily:
                          //                       GoogleFonts.poppins().fontFamily,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 14),
                          //             ),
                          //             Text(
                          //               '5.000.000',
                          //               style: TextStyle(
                          //                   fontFamily:
                          //                       GoogleFonts.poppins().fontFamily,
                          //                   fontWeight: FontWeight.w100,
                          //                   fontSize: 18),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //       SizedBox(width: 10),
                          //       Container(
                          //         width: 150,
                          //         padding: const EdgeInsets.all(16),
                          //         decoration: BoxDecoration(
                          //           // border: Border.all(),
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         child: Column(
                          //           children: [Text('Simpanan'), Text('5.000.000')],
                          //         ),
                          //       )
                          //       // StatusCard(
                          //       //   title: "Kredit",
                          //       //   data: "5.000.000",
                          //       //   satuan: "Rupiah",
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 15),
                        ],
                      ),
                      Container(
                        height: 7,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.purple,
                          child: Column(
                            children: [
                              // body
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "Pilihan Menu",
                                      style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SimpananPage()));
                                          },
                                          child: ItemKategori(
                                            title: "Simpanan",
                                            icon: R.assets.imgBook,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KreditPage()));
                                          },
                                          child: ItemKategori(
                                            title: "Kredit",
                                            icon: R.assets.imgKredit,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShuPage()));
                                          },
                                          child: ItemKategori(
                                            title: "Slip SHU",
                                            icon: R.assets.imgShu,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage()));
                                          },
                                          child: ItemKategori(
                                            title: "My Profile",
                                            icon: R.assets.imgUser,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            final status = statusUser!.data;
                                            final int sisa = 0;
                                            if (sisaKredit!.data!.isEmpty) {
                                              var sisa = 0;
                                            } else {
                                              var sisa = sisaKredit!
                                                  .data!.first.jumlahSisa!;
                                            }

                                            // print('status User');
                                            // print(status);
                                            print('status Sisa');
                                            print(sisa);

                                            if (status == '1' || sisa == '0') {
                                              _showDialogPiutang(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.red.shade900,
                                                      content: Text(
                                                        'Maaf kredit anda sebelumnya belum LUNAS, Silahkan melakukan pelunasan ke bagian Bendahara Koperasi.',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            color:
                                                                Colors.white),
                                                      )));
                                            }
                                          },
                                          child: ItemKategori(
                                            title: "Pengajuan",
                                            icon: R.assets.imgSmartphone,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Berita Terbaru",
                                          style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InformasiPage()));
                                          },
                                          child: Text(
                                            "Lihat Semua",
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 12,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    listInfo == null
                                        ? Container(
                                            width: double.infinity,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    // value: 0.5,
                                                    backgroundColor:
                                                        Color(0xff142a4f),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(Colors.blue),
                                                    strokeWidth: 6.0,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Loading...",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: Colors.white,
                                            height: 180,
                                            child: ListView.builder(
                                                itemCount:
                                                    listInfo!.data!.length > 5
                                                        ? 5
                                                        : listInfo!
                                                            .data!.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: ((context, index) {
                                                  final currentResult =
                                                      listInfo!.data![index];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          color:
                                                              Color(0xff333333),
                                                          child: ClipRRect(
                                                            // borderRadius:
                                                            //     BorderRadius
                                                            //         .circular(
                                                            //             10),
                                                            child: Stack(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (context) => DetailInfoPage(id: currentResult.idInfo.toString())));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height: double
                                                                          .infinity,
                                                                      child: Image
                                                                          .network(
                                                                        'https://kopkarmas.com/storage/public/foto_info/' +
                                                                            currentResult.picture!,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom:
                                                                        20.0,
                                                                    left: 10.0,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          currentResult
                                                                              .judul!,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 11),
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          currentResult
                                                                              .tglInfo!,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 11),
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                })),
                                          ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class ItemKategori extends StatelessWidget {
  ItemKategori({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45.0),
            child: Image.asset(
              icon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ItemNav extends StatelessWidget {
  ItemNav({
    Key? key,
    required this.status,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final bool status;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30,
          child: Image.asset(
            (status == true)
                ? "assets/icons/$icon-active.png"
                : "assets/icons/$icon.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Beranda",
          style: TextStyle(
            color: (status == true) ? Color(0xFFEC2028) : Color(0xFF747D8C),
          ),
        ),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  StatusCard({
    Key? key,
    required this.title,
    required this.data,
    required this.satuan,
  }) : super(key: key);

  final String title;
  final String data;
  final String satuan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Get.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                text: data,
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 16,
                  color: Color(0xFFEC2028),
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: " $satuan",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 16,
                      color: Color(0xFF747D8C),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    // path.lineTo(size.width - 80, size.height);
    path.lineTo(size.width, size.height);
    // path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

void _showDialogPiutang(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Pilih Kredit",
          style: TextStyle(color: Color(0Xff142a4f), fontSize: 16),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 80, maxWidth: 300),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0Xff142a4f),
                              borderRadius: BorderRadius.circular(45)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TambahBarang()));
                              },
                              icon: Icon(
                                Icons.shopping_bag,
                                // size: 30,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Barang',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0Xff142a4f),
                              borderRadius: BorderRadius.circular(45)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TambahKendraan()));
                              },
                              icon: Icon(
                                Icons.motorcycle,
                                // size: 35,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(height: 5),
                        Text('Motor', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0Xff142a4f),
                              borderRadius: BorderRadius.circular(45)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TambahTunai()));
                              },
                              icon: Icon(
                                Icons.attach_money_rounded,
                                // size: 30,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(height: 5),
                        Text('Tunai', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // actions: <Widget>[
        //   new ElevatedButton(
        //     child: new Text(
        //       "OK",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   )
        // ],
      );
    },
  );
}
