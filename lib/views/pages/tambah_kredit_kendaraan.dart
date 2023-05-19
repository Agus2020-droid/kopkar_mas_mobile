import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/last_id.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/login_page.dart';
import 'package:kopkar_mas_app/views/pages/result_failed.dart';
import 'package:kopkar_mas_app/views/pages/result_success.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class TambahKendraan extends StatefulWidget {
  const TambahKendraan({Key? key}) : super(key: key);

  @override
  State<TambahKendraan> createState() => _TambahKendraanState();
}

enum KondisiKendaraan { baru, bekas }

class _TambahKendraanState extends State<TambahKendraan> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _tambahDataKredit = {};
  final _tgl_controller = TextEditingController();
  final _userId_controller = TextEditingController();
  final _nama_controller = TextEditingController();
  final _ktp_controller = TextEditingController();
  final _jns_controller = TextEditingController();
  final _nmKendaraan_controller = TextEditingController();
  final _jmlUnit_controller = TextEditingController();
  final _spek_controller = TextEditingController();
  final _nominal_controller = TextEditingController();

  List<String> classTenor = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24"
  ];
  String selectedClassTenor = "1";
  String kondisi = "Baru";

  onTapKondisi(KondisiKendaraan kondisiInput) {
    if (kondisiInput == KondisiKendaraan.baru) {
      kondisi = "Baru";
    } else {
      kondisi = "Bekas";
    }
    setState(() {});
  }

  Dataku? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {
      // print(dataUser!.user);
    });
  }

  LastId? lastId;
  getLastId() async {
    final result = await KopkarMasApi().getIdLast();
    lastId = LastId.fromJson(result.data!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getLastId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Kredit Baru (Kendaraan)',
          style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Color(0Xff142a4f),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0Xfffafafa),
        iconTheme: IconThemeData(
          color: Color(0Xff142a4f), // set the color of the back icon
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.motorcycle,
                size: 35,
              ),
              color: Colors.amber,
              onPressed: () {},
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: ButtonLogin(
              backgroundColor: Color(0Xff142a4f),
              child: Text(
                'SUBMIT',
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              borderColor: Color(0Xff142a4f),
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _tambahDataKredit['nm_brg'] = _nmKendaraan_controller.text;
                  _tambahDataKredit['jml_brng'] = _jmlUnit_controller.text;
                  _tambahDataKredit['spek'] = _spek_controller.text;
                  _tambahDataKredit['tenor'] = selectedClassTenor;
                  _tambahDataKredit['nominal'] = _nominal_controller.text;
                }
                final plafon = _nominal_controller.text.replaceAll(".", "");
                final int tenor = int.parse(selectedClassTenor);

                final double bunga = 0.01;

                final plaf = double.parse(plafon);
                final ttlKredit = (plaf * bunga) + plaf;
                final total = NumberFormat("0", "en_US").format(ttlKredit);
                final angsuran =
                    NumberFormat("0", "en_US").format(ttlKredit / tenor);
                final ids = lastId!.data!.toInt();
                final ids2 = ids + 1;
                final kodeKredit = 'KR' + NumberFormat('000').format(ids2);

                DateTime now = DateTime.now();
                final tgl = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
                final jenis = 'KENDARAAN';
                final json = {
                  "kd_kredit": kodeKredit,
                  "tgl_kredit": tgl,
                  "user_id": dataUser!.user!.id.toString(),
                  "nama": dataUser!.user!.name,
                  "nik_ktp": dataUser!.user!.nikKtp,
                  "jns_krdt": jenis,
                  "nm_kendaraan": _nmKendaraan_controller.text,
                  "jml_unit": _jmlUnit_controller.text,
                  "spek": _spek_controller.text,
                  "nominal": plafon,
                  "kondisi": kondisi,
                  "tenor": tenor.toString(),
                  "bunga": bunga.toString(),
                  "angsuran": angsuran,
                  "total": total.toString()
                };
                print(json);
                final result = await KopkarMasApi().postKredit(json);
                print(result.status);
                if (result.status == Status.success) {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResultSuccess()));
                } else {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FailedPage()));
                }
              })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                EditProfileTextField(
                  hintText: 'contoh: Vario, Vixon',
                  title: "Merk Kendaraan",
                  controller: _nmKendaraan_controller,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom nama kendaraan harus diisi';
                    }
                  },
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Kondisi',
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary:
                                kondisi.toLowerCase() == "Baru".toLowerCase()
                                    ? Color(0Xff142a4f)
                                    : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  width: 1, color: Color(0xffcacaca)),
                            ),
                          ),
                          onPressed: () {
                            onTapKondisi(KondisiKendaraan.baru);
                            // print(JenisPinjam.pengembangan);
                          },
                          child: Text(
                            "Baru",
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12,
                              color:
                                  kondisi.toLowerCase() == "Baru".toLowerCase()
                                      ? Colors.white
                                      : Color(0xff282828),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: kondisi == "Bekas"
                                ? Color(0Xff142a4f)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  width: 1, color: Color(0xffcacaca)),
                            ),
                          ),
                          onPressed: () {
                            onTapKondisi(KondisiKendaraan.bekas);
                          },
                          child: Text(
                            "Bekas",
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12,
                              color: kondisi == "Bekas"
                                  ? Colors.white
                                  : Color(0xff282828),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                EditProfileTextField(
                  hintText: 'contoh: 1 unit',
                  title: "Jumlah Unit",
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom jumlah unit harus diisi';
                    }
                  },
                  controller: _jmlUnit_controller,
                ),
                SizedBox(height: 5),
                EditProfileTextField(
                  hintText: 'contoh: 150 CC warna Hitam tahun 2016',
                  title: "Spesifikasi kendaraan",
                  controller: _spek_controller,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom spesifikasi kendaraan harus diisi';
                    }
                  },
                ),
                SizedBox(height: 5),
                Text(
                  "Plafon Pinjaman",
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom Nominal harus diisi';
                    }
                  },
                  controller: _nominal_controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    NumberTextInputFormatter(
                      integerDigits: 10,
                      decimalDigits: 0,
                      maxValue: '100000000000',
                      decimalSeparator: ',',
                      groupDigits: 3,
                      groupSeparator: '.',
                      allowNegative: false,
                      overrideDecimalPoint: true,
                      insertDecimalPoint: false,
                      insertDecimalDigits: true,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text("Tenor",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    )),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: Colors.white,
                    // border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        value: selectedClassTenor,
                        items: classTenor
                            .map(
                              (e) => DropdownMenuItem<String>(
                                child: Text(
                                  e + ' bulan',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (String? val) {
                          selectedClassTenor = val!;
                          setState(() {});
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
    required this.validators,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;
  final String? Function(String?) validators;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
          TextFormField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.grey.withOpacity(0.6),
                )),
            validator: validators,
          ),
        ],
      ),
    );
  }
}
