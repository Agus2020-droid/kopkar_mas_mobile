class SisaKredit {
  String? status;
  String? message;
  List<Data>? data;

  SisaKredit({this.status, this.message, this.data});

  SisaKredit.fromJson(Map<String, dynamic> json) {
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
  String? ktp;
  String? jumlahSisa;

  Data({this.ktp, this.jumlahSisa});

  Data.fromJson(Map<String, dynamic> json) {
    ktp = json['ktp'];
    jumlahSisa = json['jumlah_sisa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ktp'] = this.ktp;
    data['jumlah_sisa'] = this.jumlahSisa;
    return data;
  }
}
