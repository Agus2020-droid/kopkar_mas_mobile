class ListApiAngsuran {
  String? status;
  String? message;
  List<Data>? data;

  ListApiAngsuran({this.status, this.message, this.data});

  ListApiAngsuran.fromJson(Map<String, dynamic> json) {
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
  int? idAngsuran;
  String? kreditKd;
  String? nikKtp;
  String? userId;
  String? nama;
  String? tglAngsuran;
  String? jmlAngsuran;
  String? metode;
  String? noref;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idAngsuran,
      this.kreditKd,
      this.nikKtp,
      this.userId,
      this.nama,
      this.tglAngsuran,
      this.jmlAngsuran,
      this.metode,
      this.noref,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idAngsuran = json['id_angsuran'];
    kreditKd = json['kredit_kd'];
    nikKtp = json['nik_ktp'];
    userId = json['user_id'];
    nama = json['nama'];
    tglAngsuran = json['tgl_angsuran'];
    jmlAngsuran = json['jml_angsuran'];
    metode = json['metode'];
    noref = json['noref'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_angsuran'] = this.idAngsuran;
    data['kredit_kd'] = this.kreditKd;
    data['nik_ktp'] = this.nikKtp;
    data['user_id'] = this.userId;
    data['nama'] = this.nama;
    data['tgl_angsuran'] = this.tglAngsuran;
    data['jml_angsuran'] = this.jmlAngsuran;
    data['metode'] = this.metode;
    data['noref'] = this.noref;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
