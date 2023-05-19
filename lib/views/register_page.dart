import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/repository/auth_api.dart';
import 'package:kopkar_mas_app/views/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _registerData = {};
  final _name_controller = TextEditingController();
  final _ktp_controller = TextEditingController();
  final _nik_controller = TextEditingController();
  final _telp_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _alamat_controller = TextEditingController();
  final _password_controller = TextEditingController();
  final _konfirm_password_controller = TextEditingController();
  bool _showPassword = true;
  bool _showKonfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Register Akun',
          style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.white),
        ),
        backgroundColor: Color(0Xff142a4f),
      ),
      bottomNavigationBar: SafeArea(
          child: ButtonLogin(
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
                  _registerData['telp'] = _telp_controller.text;
                  _registerData['password'] = _password_controller.text;
                  _registerData['name'] = _name_controller.text;
                  _registerData['email'] = _email_controller.text;
                  _registerData['nik_ktp'] = _ktp_controller.text;
                  _registerData['nik_kry'] = _nik_controller.text;
                  _registerData['alamat'] = _alamat_controller.text;
                }
                final json = {
                  "telp": _telp_controller.text,
                  "password": _password_controller.text,
                  "name": _name_controller.text,
                  "email": _email_controller.text,
                  "nik_ktp": _ktp_controller.text,
                  "nik_kry": _nik_controller.text,
                  "alamat": _alamat_controller.text,
                };
                // print(json);
                final result = await AuthApi().postRegister(json);
                print(result.status);

                // try {
                if (result.status == Status.success) {
                  // final url = Uri.parse(ApiUrl.baseUrl + ApiUrl.registers);
                  // final response = await http.post(
                  //   url,
                  //   body: {json},
                  // );

                  // if (response.statusCode == 200) {
                  // final responseData = jsonDecode(response.body);
                  // final prefs = await SharedPreferences.getInstance();
                  // prefs.setString('UserData', result.data);
                  // prefs.setString('user', jsonEncode([json]));
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Pendaftaran berhasil Silahkan Login')));
                } else {
                  // } catch (e) {
                  // if (result.status == Status.error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Periksa kembali Email/NO KTP/NIK Karyawan/No. WhatsApp sudah tersedia')));
                  // }
                }

                // }
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
                TextFormField(
                  controller: _name_controller,
                  validator: (Value) {
                    if (Value == null || Value.isEmpty) {
                      return 'Masukan nama Anda';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        // borderSide: BorderSide(color: Color(0xff142a4f)),
                        ),
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(Icons.account_circle)),
                    labelText: 'Nama lengkap',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _ktp_controller,
                  maxLength: 16,
                  validator: (Value) {
                    if (Value == null || Value.isEmpty) {
                      return 'KTP harus diisi';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    counterText: '',
                    border: UnderlineInputBorder(
                        // borderSide: BorderSide(color: Color(0xff142a4f)),
                        ),
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(Icons.credit_card)),
                    labelText: 'Nomor KTP',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _nik_controller,
                  maxLength: 6,
                  validator: (Value) {
                    if (Value == null || Value.isEmpty) {
                      return 'NIK Karyawan harus diisi';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    counterText: '',
                    border: UnderlineInputBorder(
                        // borderSide: BorderSide(color: Color(0xff142a4f)),
                        ),
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(Icons.credit_card)),
                    labelText: 'NIK Karyawan',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _telp_controller,
                  maxLength: 13,
                  validator: (Value) {
                    if (Value == null || Value.isEmpty) {
                      return 'Nomor WhatsApp harus diisi';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    counterText: '',
                    border: UnderlineInputBorder(
                        // borderSide: BorderSide(color: Color(0xff142a4f)),
                        ),
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(Icons.whatsapp)),
                    labelText: 'Nomor WA',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _email_controller,
                  validator: (Value) {
                    if (Value == null || Value.isEmpty) {
                      return 'Email harus diisi';
                    }
                    if (!Value.contains('@')) {
                      return 'Email tidak valid';
                    }
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        // borderSide: BorderSide(color: Color(0xff142a4f)),
                        ),
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(Icons.email)),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 5),
                TextFormField(
                    controller: _alamat_controller,
                    validator: (Value) {
                      if (Value == null || Value.isEmpty) {
                        return 'Alamat harus diisi';
                      }
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          // borderSide: BorderSide(color: Color(0xff142a4f)),
                          ),
                      prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.pin_drop)),
                      labelText: 'Alamat Tempat Tinggal',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    keyboardType: TextInputType.text),
                SizedBox(height: 5),
                TextFormField(
                    controller: _password_controller,
                    validator: (Value) {
                      if (Value == null || Value.isEmpty) {
                        return 'Password harus diisi';
                      } else if (Value.length < 8) {
                        return 'Minimal 8 karakter';
                      }
                    },
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          // borderSide: BorderSide(color: Color(0xff142a4f)),
                          ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: _showPassword == false
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword),
                SizedBox(height: 5),
                TextFormField(
                    controller: _konfirm_password_controller,
                    validator: (Value) {
                      if (Value == null || Value.isEmpty) {
                        return 'Konfirmasi password harus diisi';
                      }
                      if (Value != _password_controller.text) {
                        return 'Passwords tidak sesuai';
                      }
                    },
                    obscureText: _showKonfirmPassword,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          // borderSide: BorderSide(color: Color(0xff142a4f)),
                          ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showKonfirmPassword = !_showKonfirmPassword;
                          });
                        },
                        icon: _showKonfirmPassword == false
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      labelText: 'Konfirmasi Password',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
