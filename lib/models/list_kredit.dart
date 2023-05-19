class ListApiKredit {
  String? status;
  String? message;
  List<Data>? data;

  ListApiKredit({this.status, this.message, this.data});

  ListApiKredit.fromJson(Map<String, dynamic> json) {
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
  int? idKredit;
  String? kdKredit;
  String? tglKredit;
  String? userId;
  String? nama;
  String? nikKtp;
  String? jnsKrdt;
  String? nmBrg;
  String? jmlBrng;
  String? nmKendaraan;
  String? kondisi;
  String? jmlUnit;
  String? spek;
  String? beliOleh;
  String? keperluan;
  String? nominal;
  String? tenor;
  String? tempo;
  String? bunga;
  String? angsuran;
  String? total;
  String? tglPtgs;
  String? appPtgs;
  String? nmPtgs;
  String? tglBnd;
  String? appBnd;
  String? nmBnd;
  String? tglKet;
  String? appKet;
  String? nmKet;
  String? status;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idKredit,
      this.kdKredit,
      this.tglKredit,
      this.userId,
      this.nama,
      this.nikKtp,
      this.jnsKrdt,
      this.nmBrg,
      this.jmlBrng,
      this.nmKendaraan,
      this.kondisi,
      this.jmlUnit,
      this.spek,
      this.beliOleh,
      this.keperluan,
      this.nominal,
      this.tenor,
      this.tempo,
      this.bunga,
      this.angsuran,
      this.total,
      this.tglPtgs,
      this.appPtgs,
      this.nmPtgs,
      this.tglBnd,
      this.appBnd,
      this.nmBnd,
      this.tglKet,
      this.appKet,
      this.nmKet,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idKredit = json['id_kredit'];
    kdKredit = json['kd_kredit'];
    tglKredit = json['tgl_kredit'];
    userId = json['user_id'];
    nama = json['nama'];
    nikKtp = json['nik_ktp'];
    jnsKrdt = json['jns_krdt'];
    nmBrg = json['nm_brg'];
    jmlBrng = json['jml_brng'];
    nmKendaraan = json['nm_kendaraan'];
    kondisi = json['kondisi'];
    jmlUnit = json['jml_unit'];
    spek = json['spek'];
    beliOleh = json['beli_oleh'];
    keperluan = json['keperluan'];
    nominal = json['nominal'];
    tenor = json['tenor'];
    tempo = json['tempo'];
    bunga = json['bunga'];
    angsuran = json['angsuran'];
    total = json['total'];
    tglPtgs = json['tgl_ptgs'];
    appPtgs = json['app_ptgs'];
    nmPtgs = json['nm_ptgs'];
    tglBnd = json['tgl_bnd'];
    appBnd = json['app_bnd'];
    nmBnd = json['nm_bnd'];
    tglKet = json['tgl_ket'];
    appKet = json['app_ket'];
    nmKet = json['nm_ket'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_kredit'] = this.idKredit;
    data['kd_kredit'] = this.kdKredit;
    data['tgl_kredit'] = this.tglKredit;
    data['user_id'] = this.userId;
    data['nama'] = this.nama;
    data['nik_ktp'] = this.nikKtp;
    data['jns_krdt'] = this.jnsKrdt;
    data['nm_brg'] = this.nmBrg;
    data['jml_brng'] = this.jmlBrng;
    data['nm_kendaraan'] = this.nmKendaraan;
    data['kondisi'] = this.kondisi;
    data['jml_unit'] = this.jmlUnit;
    data['spek'] = this.spek;
    data['beli_oleh'] = this.beliOleh;
    data['keperluan'] = this.keperluan;
    data['nominal'] = this.nominal;
    data['tenor'] = this.tenor;
    data['tempo'] = this.tempo;
    data['bunga'] = this.bunga;
    data['angsuran'] = this.angsuran;
    data['total'] = this.total;
    data['tgl_ptgs'] = this.tglPtgs;
    data['app_ptgs'] = this.appPtgs;
    data['nm_ptgs'] = this.nmPtgs;
    data['tgl_bnd'] = this.tglBnd;
    data['app_bnd'] = this.appBnd;
    data['nm_bnd'] = this.nmBnd;
    data['tgl_ket'] = this.tglKet;
    data['app_ket'] = this.appKet;
    data['nm_ket'] = this.nmKet;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
