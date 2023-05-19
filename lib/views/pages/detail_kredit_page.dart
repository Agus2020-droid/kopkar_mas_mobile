import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/models/detail_kredit.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/login_page.dart';
import 'package:kopkar_mas_app/views/pages/angsuran_page.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailKreditPage extends StatefulWidget {
  const DetailKreditPage({Key? key, required this.id}) : super(key: key);
  static String route = "detail_kredit_page";
  final int id;
  @override
  State<DetailKreditPage> createState() => _DetailKreditPageState();
}

class _DetailKreditPageState extends State<DetailKreditPage> {
  double? _value;
  ShowDetailKredit? detailKredit;
  Future getShowDetailKredit() async {
    final result = await KopkarMasApi().getDetailKredit(widget.id);
    print(result.status);
    if (result.status == Status.success) {
      detailKredit = ShowDetailKredit.fromJson(result.data!);
      final showKredit = detailKredit!.data!;
      final ttl = showKredit.first.total!;
      final ttlangsuran = showKredit.first.totalAngsuran!;
      _value = (int.parse(ttlangsuran) / int.parse(ttl)) * 100;

      // final detailKredit = result.data!;
      setState(() {
        // print(_value.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShowDetailKredit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff142a4f),
      appBar: AppBar(
        toolbarHeight: 50, // Tinggi App Bar
        automaticallyImplyLeading: true,
        backgroundColor: Color(0Xff142a4f),
        elevation: 0,
        title: Text(
          'Detail Kredit',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          child: ButtonLogin(
              backgroundColor: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Detail Angsuran",
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0Xff142a4f)),
                  )
                ],
              ),
              borderColor: Color(0Xff142a4f),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AngsuranPage(
                          id: detailKredit!.data!.first.kdKredit!,
                        )));
              }),
        ),
      ),
      body: detailKredit == null
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                // color: Color(0Xff142a4f),
                child: Column(
                  children: [
                    Center(
                      child: _value == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  // value: 0.5,
                                  backgroundColor: Color(0xff142a4f),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                  strokeWidth: 6.0,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Loading...",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SleekCircularSlider(
                                  min: 0,
                                  max: 100,
                                  initialValue: _value!,
                                  // onChange: (double value) {
                                  //   setState(() {
                                  //     _value = value;
                                  //   });
                                  // },
                                  innerWidget: (double value) {
                                    return Center(
                                      child: Text(
                                        '${value.toInt()}%',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  },
                                ),
                                Text(_value == 100 ? 'LUNAS' : 'BELUM LUNAS',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'No. Transaksi',
                      textakhir: detailKredit!.data!.first.kdKredit!,
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Tanggal',
                      textakhir: DateFormat("dd-MMM-yyy").format(
                          DateTime.parse(detailKredit!.data!.first.tglKredit!)),
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Jenis Kredit',
                      textakhir: detailKredit!.data!.first.jnsKrdt!,
                    ),
                    TextKredit(
                      tampil: detailKredit!.data!.first.jnsKrdt! == 'BARANG'
                          ? true
                          : false,
                      textawal: 'Nama Barang',
                      textakhir: detailKredit!.data!.first.jnsKrdt! == 'BARANG'
                          ? detailKredit!.data!.first.nmBrg!
                          : '',
                    ),
                    TextKredit(
                      tampil: detailKredit!.data!.first.jnsKrdt! == 'BARANG'
                          ? true
                          : false,
                      textawal: 'Jumlah Barang',
                      textakhir: detailKredit!.data!.first.jnsKrdt! == 'BARANG'
                          ? detailKredit!.data!.first.jmlBrng!
                          : '',
                    ),
                    TextKredit(
                      tampil: detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN'
                          ? true
                          : false,
                      textawal: 'Jumlah Unit',
                      textakhir:
                          detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN'
                              ? detailKredit!.data!.first.jmlUnit!
                              : '',
                    ),
                    TextKredit(
                      tampil:
                          detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN' ||
                                  detailKredit!.data!.first.jnsKrdt! == 'BARANG'
                              ? true
                              : false,
                      textawal: 'Spesifikasi',
                      textakhir:
                          detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN' ||
                                  detailKredit!.data!.first.jnsKrdt! == 'BARANG'
                              ? detailKredit!.data!.first.spek!
                              : '',
                    ),
                    TextKredit(
                      tampil: detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN'
                          ? true
                          : false,
                      textawal: 'Nama Kendaraan',
                      textakhir:
                          detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN'
                              ? detailKredit!.data!.first.nmKendaraan!
                              : '',
                    ),
                    TextKredit(
                      tampil: detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN'
                          ? true
                          : false,
                      textawal: 'Kondisi',
                      textakhir:
                          detailKredit!.data!.first.jnsKrdt! == 'KENDARAAN'
                              ? detailKredit!.data!.first.kondisi!
                              : '',
                    ),
                    TextKredit(
                      tampil: detailKredit!.data!.first.jnsKrdt! == 'TUNAI'
                          ? true
                          : false,
                      textawal: 'Keperluan',
                      textakhir: detailKredit!.data!.first.jnsKrdt! == 'TUNAI'
                          ? detailKredit!.data!.first.keperluan!
                          : '',
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Plafon',
                      textakhir: NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(
                              double.parse(detailKredit!.data!.first.nominal!)),
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Tenor',
                      textakhir:
                          detailKredit!.data!.first.tenor.toString() + ' Bulan',
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Bunga',
                      textakhir: detailKredit!.data!.first.bunga!.toString(),
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Angsuran per bulan',
                      textakhir: NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(double.parse(
                              detailKredit!.data!.first.angsuran!)),
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Jatuh Tempo',
                      textakhir: DateFormat("dd-MMM-yyy").format(
                          DateTime.parse(detailKredit!.data!.first.tempo!)),
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Total Angsuran',
                      textakhir: NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(double.parse(
                              detailKredit!.data!.first.totalAngsuran!)),
                    ),
                    TextKredit(
                      tampil: true,
                      textawal: 'Sisa Angsuran',
                      textakhir: NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(double.parse(
                              detailKredit!.data!.first.sisaAngsuran!)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ListAngsuran extends StatelessWidget {
  const ListAngsuran({
    Key? key,
    required this.kode,
    required this.tglAngsuran,
    required this.metode,
    required this.angsuran,
  }) : super(key: key);
  final String kode;
  final String? tglAngsuran;
  final String metode;
  final double? angsuran;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            kode,
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          Spacer(),
          Text(
            DateFormat("dd-MMM-yyy").format(DateTime.parse(tglAngsuran!)),
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
                metode,
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 12),
              ),
              Spacer(),
              Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                      .format(angsuran),
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 12))
            ],
          ),
        ],
      ),
    );
  }
}

class TextKredit extends StatelessWidget {
  const TextKredit({
    Key? key,
    required this.textawal,
    required this.textakhir,
    required this.tampil,
  }) : super(key: key);

  final String textawal;
  final String textakhir;
  final bool tampil;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: tampil,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Text(
              textawal,
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Text(
              textakhir,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white, // Gunakan customColors disini
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
