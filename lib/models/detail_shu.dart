class ShowDetailShu {
  String? status;
  String? message;
  List<Data>? data;

  ShowDetailShu({this.status, this.message, this.data});

  ShowDetailShu.fromJson(Map<String, dynamic> json) {
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
  int? idShu;
  String? tglShu;
  String? thnBuku;
  String? nikKtp;
  String? nama;
  String? nmBank;
  String? noRek;
  String? peranKrdt;
  String? peranPeng;
  String? jmlShu;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idShu,
      this.tglShu,
      this.thnBuku,
      this.nikKtp,
      this.nama,
      this.nmBank,
      this.noRek,
      this.peranKrdt,
      this.peranPeng,
      this.jmlShu,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idShu = json['id_shu'];
    tglShu = json['tgl_shu'];
    thnBuku = json['thn_buku'];
    nikKtp = json['nik_ktp'];
    nama = json['nama'];
    nmBank = json['nm_bank'];
    noRek = json['no_rek'];
    peranKrdt = json['peran_krdt'];
    peranPeng = json['peran_peng'];
    jmlShu = json['jml_shu'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_shu'] = this.idShu;
    data['tgl_shu'] = this.tglShu;
    data['thn_buku'] = this.thnBuku;
    data['nik_ktp'] = this.nikKtp;
    data['nama'] = this.nama;
    data['nm_bank'] = this.nmBank;
    data['no_rek'] = this.noRek;
    data['peran_krdt'] = this.peranKrdt;
    data['peran_peng'] = this.peranPeng;
    data['jml_shu'] = this.jmlShu;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
