import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showPassword = true;

  Dataku? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50, // Tinggi App Bar
        automaticallyImplyLeading: true,
        backgroundColor: Color(0Xff142a4f),
        title: Text(
          'My Profile',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              _showEditPassword(context);
            },
            child: Row(
              children: [
                Text('Ganti Password',
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: Color(0Xff142a4f),
                        fontWeight: FontWeight.w500))
              ],
            ),
          )
        ],
      ),
      body: dataUser == null
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
                      strokeWidth: 8.0,
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
          : SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 28, bottom: 50, left: 25, right: 15),
                      decoration: BoxDecoration(
                          color: Color(0Xff142a4f),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
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
                                    margin: EdgeInsets.only(right: 30),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45.0),
                                      child: Image.network(
                                        'https://kopkarmas.com/storage/public/foto_user/${dataUser!.user!.foto}',
                                        // 'http://127.0.0.1:8000/storage/foto_user/${dataUser!.user!.foto}',
                                        fit: BoxFit.cover,
                                        height: 70,
                                        width: 70,
                                      ),
                                      // Image.asset(
                                      //     'assets/user.png',
                                      //     fit: BoxFit.cover,
                                      //     height: 70,
                                      //     width: 70,
                                      //   ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: VerticalDivider(
                                      color: Colors
                                          .amber, // warna garis horizontal
                                      thickness:
                                          2.0, // ketebalan garis horizontal
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${dataUser!.user!.name}',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        '${dataUser!.user!.email}',
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey.withOpacity(0.25),
                            width: 1.5,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                color: Colors.blueGrey.withOpacity(0.25))
                          ]),
                      margin:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PERSONAL INFORMATION',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                Divider(
                                  color: Color(
                                      0Xff142a4f), // warna garis horizontal
                                  thickness: 5.0, // ketebalan garis horizontal
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Nama lengkap",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                            '${dataUser!.user!.name}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Color(0Xff142a4f),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("No KTP",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                            '${dataUser!.user!.nikKtp}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Color(0Xff142a4f),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Nik Karyawan",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                            '${dataUser!.user!.nikKry}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Color(0Xff142a4f),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Email",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                            '${dataUser!.user!.email}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Color(0Xff142a4f),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Nomor WA",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                            '${dataUser!.user!.telp}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Color(0Xff142a4f),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("ALamat",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                            '${dataUser!.user!.alamat}',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Color(0Xff142a4f),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

void _showEditPassword(BuildContext context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _editPassword = {};
  final password_controller = TextEditingController();
  final newPassword_controller = TextEditingController();
  final confirm_controller = TextEditingController();
  bool _showPassword = true;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.key),
            SizedBox(
              width: 5,
            ),
            Text(
              "Edit Password",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 14,
                      color: Color(0Xff142a4f),
                    )),
              ],
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 260),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password saat ini',
                                // border: OutlineInputBorder(),
                              ),
                              obscureText: false,
                              validator: (value) {
                                if (true == null || value!.isEmpty) {
                                  return 'Password required';
                                }
                                return null;
                              },
                              controller: password_controller,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password Baru',
                                // border: OutlineInputBorder(),
                              ),
                              obscureText: false,
                              validator: (value) {
                                if (true == null || value!.isEmpty) {
                                  return 'Password required';
                                } else if (value.length < 8) {
                                  return 'Input must be at least 8 characters';
                                }
                                return null;
                              },
                              controller: newPassword_controller,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Konfirmasi password',
                                // border: OutlineInputBorder(),
                              ),
                              obscureText: false,
                              validator: (value) {
                                if (true == null || value!.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value != newPassword_controller.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              controller: confirm_controller,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          new ButtonLogin(
              backgroundColor: Color(0Xff142a4f),
              child: Text(
                'SUBMIT',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              borderColor: Color(0Xff142a4f),
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _editPassword['current_password'] = password_controller.text;
                  _editPassword['new_password'] = newPassword_controller.text;
                  _editPassword['confirm_password'] = confirm_controller.text;
                }
                final json = {
                  'current_password': password_controller.text,
                  'new_password': newPassword_controller.text,
                  'confirm_password': confirm_controller.text,
                };
                print(json);

                final result = await KopkarMasApi().putEditPassword(json);
                try {
                  if (result.status == Status.success) {
                    print(result.data);
                    final message = result.data!;
                    Navigator.of(context).pop();
                    showAlert(context, 'Sukses', "assets/success.png");
                  } else {
                    showAlert(context, 'Gagal', "assets/cancel.png");
                  }
                } catch (e) {
                  showAlert(context, 'Gagal', "assets/cancel.png");
                }
              })
        ],
      );
    },
  );
}

void showAlert(BuildContext context, String message, String gambar) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 100),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 5),
                Image.asset(
                  gambar,
                  width: 60,
                ),
                SizedBox(height: 5),
                Text(
                  message,
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Color(0Xff142a4f)),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0Xff142a4f)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
              ),
            ),
          ),
        ],
      );
    },
  );
}
