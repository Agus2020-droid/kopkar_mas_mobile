class ShowDetailKredit {
  String? status;
  String? message;
  List<Data>? data;

  ShowDetailKredit({this.status, this.message, this.data});

  ShowDetailKredit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? nmBrg;
  String? jmlBrng;
  String? nmKendaraan;
  String? kondisi;
  String? jmlUnit;
  String? spek;
  String? keperluan;
  String? tenor;
  String? tempo;
  String? bunga;
  String? angsuran;
  String? status;
  String? tglKredit;
  String? total;
  String? appPtgs;
  String? appBnd;
  String? appKet;
  int? idKredit;
  String? kdKredit;
  String? nominal;
  String? jnsKrdt;
  String? totalAngsuran;
  String? sisaAngsuran;
  String? countAngsuran;

  Data(
      {this.nmBrg,
      this.jmlBrng,
      this.nmKendaraan,
      this.kondisi,
      this.jmlUnit,
      this.spek,
      this.keperluan,
      this.tenor,
      this.tempo,
      this.bunga,
      this.angsuran,
      this.status,
      this.tglKredit,
      this.total,
      this.appPtgs,
      this.appBnd,
      this.appKet,
      this.idKredit,
      this.kdKredit,
      this.nominal,
      this.jnsKrdt,
      this.totalAngsuran,
      this.sisaAngsuran,
      this.countAngsuran});

  Data.fromJson(Map<String, dynamic> json) {
    nmBrg = json['nm_brg'];
    jmlBrng = json['jml_brng'];
    nmKendaraan = json['nm_kendaraan'];
    kondisi = json['kondisi'];
    jmlUnit = json['jml_unit'];
    spek = json['spek'];
    keperluan = json['keperluan'];
    tenor = json['tenor'];
    tempo = json['tempo'];
    bunga = json['bunga'];
    angsuran = json['angsuran'];
    status = json['status'];
    tglKredit = json['tgl_kredit'];
    total = json['total'];
    appPtgs = json['app_ptgs'];
    appBnd = json['app_bnd'];
    appKet = json['app_ket'];
    idKredit = json['id_kredit'];
    kdKredit = json['kd_kredit'];
    nominal = json['nominal'];
    jnsKrdt = json['jns_krdt'];
    totalAngsuran = json['total_angsuran'];
    sisaAngsuran = json['sisaAngsuran'];
    countAngsuran = json['count_angsuran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nm_brg'] = this.nmBrg;
    data['jml_brng'] = this.jmlBrng;
    data['nm_kendaraan'] = this.nmKendaraan;
    data['kondisi'] = this.kondisi;
    data['jml_unit'] = this.jmlUnit;
    data['spek'] = this.spek;
    data['keperluan'] = this.keperluan;
    data['tenor'] = this.tenor;
    data['tempo'] = this.tempo;
    data['bunga'] = this.bunga;
    data['angsuran'] = this.angsuran;
    data['status'] = this.status;
    data['tgl_kredit'] = this.tglKredit;
    data['total'] = this.total;
    data['app_ptgs'] = this.appPtgs;
    data['app_bnd'] = this.appBnd;
    data['app_ket'] = this.appKet;
    data['id_kredit'] = this.idKredit;
    data['kd_kredit'] = this.kdKredit;
    data['nominal'] = this.nominal;
    data['jns_krdt'] = this.jnsKrdt;
    data['total_angsuran'] = this.totalAngsuran;
    data['sisaAngsuran'] = this.sisaAngsuran;
    data['count_angsuran'] = this.countAngsuran;
    return data;
  }
}
