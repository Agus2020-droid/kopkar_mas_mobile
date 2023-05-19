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

class TambahTunai extends StatefulWidget {
  const TambahTunai({Key? key}) : super(key: key);

  @override
  State<TambahTunai> createState() => _TambahTunaiState();
}

class _TambahTunaiState extends State<TambahTunai> {
  bool isSnackBarVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _tambahDataKredit = {};
  final _tgl_controller = TextEditingController();
  final _userId_controller = TextEditingController();
  final _nama_controller = TextEditingController();
  final _ktp_controller = TextEditingController();
  final _jns_controller = TextEditingController();
  final _keperluan_controller = TextEditingController();
  final _nominal_controller = TextEditingController();
  final _tenor_controller = TextEditingController();
  final _bunga_controller = TextEditingController();

  List<String> classTenor = ["1", "2", "3", "4", "5"];
  String selectedClassTenor = "1";

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
          'Kredit Baru (Tunai)',
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
                Icons.attach_money_rounded,
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
                  _tambahDataKredit['keperluan'] = _keperluan_controller.text;
                  _tambahDataKredit['tenor'] = selectedClassTenor;
                  _tambahDataKredit['nominal'] = _nominal_controller.text;
                }
                final plafon = _nominal_controller.text.replaceAll(".", "");
                final int tenor = int.parse(selectedClassTenor);
                final bunga = 0;

                final plaf = double.parse(plafon);
                final ttlKredit = (plaf * bunga) + plaf;
                final total = NumberFormat("0.00", "en_US").format(ttlKredit);
                final angsuran =
                    NumberFormat("0.00", "en_US").format(ttlKredit / tenor);
                final ids = lastId!.data;
                final int ids2 = ids! + 1;
                final kodeKredit = 'KR' + NumberFormat('000').format(ids2);
                DateTime now = DateTime.now();
                final tgl = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
                final jenis = 'TUNAI';

                final json = {
                  "kd_kredit": kodeKredit,
                  "tgl_kredit": tgl,
                  "user_id": dataUser!.user!.id.toString(),
                  "nama": dataUser!.user!.name,
                  "nik_ktp": dataUser!.user!.nikKtp,
                  "jns_krdt": jenis,
                  "keperluan": _keperluan_controller.text,
                  "nominal": plafon,
                  "tenor": tenor.toString(),
                  "bunga": bunga.toString(),
                  "angsuran": angsuran,
                  "total": total.toString()
                  // "nm_brg": '',
                  // "jml_brng": '',
                  // "nm_kendaraan": '',
                  // "kondisi": '',
                  // "jml_unit": '',
                  // "spek": '',
                  // "beli_oleh": '',
                };
                // print(json);
                final result = await KopkarMasApi().postKredit(json);
                // print(result.message);
                if (result.status == Status.success) {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ResultSuccess()));
                  // Alert(
                  //   context: context,
                  //   title: "RFLUTTER ALERT",
                  //   desc: "Flutter is better with RFlutter Alert.",
                  //   image: Image.asset("assets/success.png"),
                  // ).show();
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     backgroundColor: Colors.lightGreen,
                  //     content: Text(
                  //         'Selamat pengajuan kredit tunai berhasil dibuat, tunggu verifikasi dari petugas Koperasi')));
                } else {
                  // CoolAlert.show(
                  //    context: context,
                  //                 type: CoolAlertType.error,
                  //                 text: "Gagal dibuat",
                  //                 autoCloseDuration: Duration(seconds: 2));
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FailedPage()));
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Maaf kredit baru gagal dibuat')));
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
                  hintText: 'contoh: Biaya berobat',
                  title: "Keperluan",
                  controller: _keperluan_controller,
                  validators: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom keperluan harus diisi';
                    }
                  },
                ),
                SizedBox(height: 5),
                Text(
                  "Nominal Pinjaman",
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
                  decoration: InputDecoration(
                    hintText: 'contoh : 5.000.000',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
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
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
            validator: validators,
          ),
        ],
      ),
    );
  }
}
