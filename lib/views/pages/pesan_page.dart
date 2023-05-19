import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/models/notifikasi.dart';
import 'package:kopkar_mas_app/models/unread.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/main_page.dart';
// import 'package:kopkar_mas/helpers/notifikasi.dart';

class PesanPage extends StatefulWidget {
  const PesanPage({Key? key}) : super(key: key);

  @override
  State<PesanPage> createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  // Atur variabel untuk menentukan apakah sedang memuat atau tidak
  bool _isLoading = false;

  // Metode untuk mengambil data baru
  Future<void> _refreshData() async {
    // Setelah Anda selesai mengambil data baru, Anda dapat menghentikan tampilan memuat dengan mengubah nilai _isLoading menjadi false
    setState(() {
      getNotif();
      getUnreadNotif();
      _isLoading = false;
    });
  }

  UnreadNotif? unreadNotif;
  getUnreadNotif() async {
    final result = await KopkarMasApi().getUnread();
    unreadNotif = UnreadNotif.fromJson(result.data!);

    setState(() {});
  }

  String? msg;
  ListNotifikasi? listNotifikasi;
  Future getNotif() async {
    final result = await KopkarMasApi().getNotifikasi();

    if (result.status == Status.success) {
      listNotifikasi = ListNotifikasi.fromJson(result.data!);

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotif();
    getUnreadNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80, // Tinggi App Bar
          automaticallyImplyLeading: false,
          backgroundColor: Color(0Xff142a4f),
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pesan Masuk',
                style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 18),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),

          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            unreadNotif == null
                                ? '0'
                                : unreadNotif!.notifications!.first.countNotif!,
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        SizedBox(width: 5),
                        Text(' Pesan belum terbaca',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.blue,
                    height: 5,
                    thickness: 2,
                  )
                ],
              ),
            ),
            Expanded(
              child: listNotifikasi == null
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
                              style: TextStyle(
                                  fontSize: 20, color: Color(0Xff142a4f)),
                            )
                          ],
                        ),
                      ),
                    )
                  : listNotifikasi!.notifications!.isEmpty
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
                                      'Tidak ada notifikasi',
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
                      : ListView.builder(
                          itemCount: listNotifikasi!.notifications!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final currentNotifikasi =
                                listNotifikasi!.notifications![index];
                            final id = currentNotifikasi.id!;
                            final bg = currentNotifikasi.read.toString();
                            final foto = currentNotifikasi.data!.user!.foto!;
                            final nama = currentNotifikasi.data!.user!.name!;
                            final subject =
                                currentNotifikasi.data!.request!.notif!;
                            final tglKredit = currentNotifikasi.create;
                            return Container(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              margin: EdgeInsets.only(top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                  color: bg == 'null'
                                      ? Colors.blue.shade50
                                      : Color(0xfffafafa),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.blueGrey.withOpacity(0.25))
                                  ]),
                              child: Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) async {
                                  await KopkarMasApi().getHapusNotif(id);
                                  _refreshData();
                                },
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45.0),
                                      child: Image.network(
                                        'https://kopkarmas.com/storage/public/foto_user/${foto}',
                                        // 'http://127.0.0.1:8000/storage/foto_user/$foto',
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    // Image.asset(
                                    //   R.assets.imgUser,
                                    //   fit: BoxFit.contain,
                                    // ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(45)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        nama,
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.alarm,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        DateFormat("dd/MM/yy")
                                            .format(DateTime.parse(tglKredit!)),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subyek : ' + subject,
                                        style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    final result =
                                        await KopkarMasApi().getReadNotif(id);
                                    _refreshData();
                                  },
                                ),
                              ),
                            );
                          }),
            ),
          ],
        ));
  }
}
