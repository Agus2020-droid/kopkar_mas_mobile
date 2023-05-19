import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/contents/R/r.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/detail_shu.dart';
import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class DetailShu extends StatefulWidget {
  const DetailShu({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<DetailShu> createState() => _DetailShuState();
}

class _DetailShuState extends State<DetailShu> {
  GlobalKey _globalKey = GlobalKey();

  Future<void> _takeScreenshot(BuildContext context) async {
    // Mengambil widget yang ingin diambil screenshoot-nya
    RenderRepaintBoundary boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);

    // Mengonversi image menjadi format JPEG
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    img.Image? decodedImage = img.decodeImage(pngBytes);
    Uint8List jpegData = img.encodeJpg(decodedImage!, quality: 85);

    // Menyimpan gambar ke dalam penyimpanan perangkat
    final directory = await getExternalStorageDirectory();
    final path = '${directory?.path}/SlipShu.jpg';
    final file = File(path);
    await file.writeAsBytes(jpegData);

    // Menampilkan snackbar sebagai notifikasi
    final snackBar = SnackBar(
      content: Text('Screenshot saved to $path'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  ShowDetailShu? detailShu;
  getDetailShu() async {
    final result = await KopkarMasApi().getdetailShu(widget.id);
    detailShu = ShowDetailShu.fromJson(result.data!);
    final showDetail = detailShu!.data;
    setState(() {});
  }

  Dataku? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {
      // print(dataUser!.user);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailShu();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
          'assets/banner.png',
          fit: BoxFit.cover,
        )),
        toolbarHeight: 120,
        // backwardsCompatibility: false,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     // color: Color(0xff142a4f),
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (context) => ShuPage()));
        //   },
        // ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: detailShu == null
              ? Container(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
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
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        height: 200,
                        color: Color(0xff142a4f),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  R.assets.imgLogo,
                                  height: 70,
                                  width: 70,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'KOPERASI KARYAWAN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('MAKMUR ALAM SEJAHTERA',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Jalan Raya Salatiga - Solo KM. 8, Ds. Butuh, Kec. Tengaran',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Kab. Semarang Jawa Tengah 50775',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(
                              color: Color(0xff193552),
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 15),
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          // height: 420,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10, color: Colors.blueGrey.withOpacity(0.25))
                            // ]
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '-- SLIP SHU TAHUN BUKU ' +
                                          detailShu!.data!.first.thnBuku! +
                                          '--',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(height: 15),
                              ListShu(
                                title: 'Nama',
                                isi: detailShu!.data!.first.nama!,
                              ),
                              SizedBox(height: 3),
                              ListShu(
                                title: 'NIK KTP',
                                isi: detailShu!.data!.first.nikKtp!,
                              ),
                              SizedBox(height: 3),
                              ListShu(
                                title: 'Alamat',
                                isi: dataUser!.user!.alamat!,
                              ),
                              SizedBox(height: 3),
                              ListShu(
                                title: 'Telp',
                                isi: dataUser!.user!.telp!,
                              ),
                              SizedBox(height: 3),
                              ListShu(
                                title: 'Email',
                                isi: dataUser!.user!.email!,
                              ),
                              SizedBox(height: 3),
                              ListShu(
                                title: 'Nama Bank',
                                isi: detailShu!.data!.first.nmBank!,
                              ),
                              SizedBox(height: 3),
                              ListShu(
                                title: 'No. Rekening',
                                isi: detailShu!.data!.first.noRek!,
                              ),
                              SizedBox(height: 3),
                              Divider(
                                color: Color(0xff193552),
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SHU Peran Kredit',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      SizedBox(height: 3),
                                      Text('SHU Peran Pengurus',
                                          style: TextStyle(fontSize: 11)),
                                      SizedBox(height: 3),
                                      Text('Jumlah SHU yang ditransfer',
                                          style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ':',
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      SizedBox(height: 3),
                                      Text(':', style: TextStyle(fontSize: 11)),
                                      SizedBox(height: 3),
                                      Text(':', style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Rp. ",
                                                decimalDigits: 2)
                                            .format(double.parse(detailShu!
                                                .data!.first.peranKrdt!)),
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "Rp. ",
                                                  decimalDigits: 2)
                                              .format(double.parse(detailShu!
                                                  .data!.first.peranPeng!)),
                                          style: TextStyle(fontSize: 11)),
                                      SizedBox(height: 3),
                                      Text(
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "Rp. ",
                                                  decimalDigits: 2)
                                              .format(double.parse(detailShu!
                                                  .data!.first.jmlShu!)),
                                          style: TextStyle(fontSize: 11)),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 3),
                              Divider(
                                color: Color(0xff193552),
                                height: 5,
                              ),
                            ],
                          )),
                      GestureDetector(
                        onTap: () async {
                          await _takeScreenshot(context);
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(10),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 7, color: Colors.black.withOpacity(0.25))
                            // ],
                          ),
                          child: Row(children: [
                            Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "UNDUHAN",
                              style: TextStyle(
                                color: Colors.white,
                                // fontSize: 12,
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class ListShu extends StatelessWidget {
  const ListShu({
    Key? key,
    required this.title,
    required this.isi,
  }) : super(key: key);
  final String title;
  final String isi;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 11)),
        SizedBox(
          width: 30,
        ),
        // Text(':', style: TextStyle(fontSize:11)),
        Spacer(),
        Text(isi, style: TextStyle(fontSize: 11)),
      ],
    );
  }
}
