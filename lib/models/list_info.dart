class ListInfo {
  String? status;
  String? message;
  List<Data>? data;

  ListInfo({this.status, this.message, this.data});

  ListInfo.fromJson(Map<String, dynamic> json) {
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
  String? idInfo;
  String? judul;
  String? tglInfo;
  String? isi;
  String? picture;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idInfo,
      this.judul,
      this.tglInfo,
      this.isi,
      this.picture,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idInfo = json['id_info'];
    judul = json['judul'];
    tglInfo = json['tgl_info'];
    isi = json['isi'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_info'] = this.idInfo;
    data['judul'] = this.judul;
    data['tgl_info'] = this.tglInfo;
    data['isi'] = this.isi;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
