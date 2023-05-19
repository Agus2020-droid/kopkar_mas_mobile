import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopkar_mas_app/contents/R/r.dart';
import 'package:kopkar_mas_app/models/detail_info.dart';
import 'package:kopkar_mas_app/models/list_info.dart';
import 'package:kopkar_mas_app/models/network_response.dart';
import 'package:kopkar_mas_app/repository/kopkar_mas_api.dart';
import 'package:kopkar_mas_app/views/pages/detail_info.dart';
import 'package:kopkar_mas_app/views/pages/profile_page.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({Key? key}) : super(key: key);

  @override
  State<InformasiPage> createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
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
    // TODO: implement initState
    super.initState();
    getInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita Terbaru',
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
        ),
      ),
      body: listInfo == null
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
                    Text("Loading...",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: GoogleFonts.poppins().fontFamily))
                  ],
                ),
              ),
            )
          : listInfo!.data!.isEmpty
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
                              'Tidak ada informasi',
                              style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: listInfo!.data!.length,
                    itemBuilder: (context, index) {
                      final currentResult = listInfo!.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailInfoPage(
                                  id: currentResult.idInfo.toString())));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ListTile(
                                hoverColor: Colors.amber,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                leading: Container(
                                  color: Colors.amber,
                                  child: Image.network(
                                    'https://kopkarmas.com/storage/public/foto_info/' +
                                        currentResult.picture!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 120,
                                  ),
                                ),
                                iconColor: Colors.amber,
                                title: Text(
                                  currentResult.judul!,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentResult.isi!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(currentResult.tglInfo!,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
