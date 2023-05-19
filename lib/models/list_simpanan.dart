class ListApiSimpanan {
  String? status;
  String? message;
  List<Data>? data;

  ListApiSimpanan({this.status, this.message, this.data});

  ListApiSimpanan.fromJson(Map<String, dynamic> json) {
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
  int? idSimpanan;
  String? tglSimpanan;
  String? nikKtp;
  String? nama;
  String? jmlSimpanan;
  String? stts;
  String? ket;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idSimpanan,
      this.tglSimpanan,
      this.nikKtp,
      this.nama,
      this.jmlSimpanan,
      this.stts,
      this.ket,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idSimpanan = json['id_simpanan'];
    tglSimpanan = json['tgl_simpanan'];
    nikKtp = json['nik_ktp'];
    nama = json['nama'];
    jmlSimpanan = json['jml_simpanan'];
    stts = json['stts'];
    ket = json['ket'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_simpanan'] = this.idSimpanan;
    data['tgl_simpanan'] = this.tglSimpanan;
    data['nik_ktp'] = this.nikKtp;
    data['nama'] = this.nama;
    data['jml_simpanan'] = this.jmlSimpanan;
    data['stts'] = this.stts;
    data['ket'] = this.ket;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
