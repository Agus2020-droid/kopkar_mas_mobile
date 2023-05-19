class ListNotifikasi {
  String? status;
  String? message;
  List<Notifications>? notifications;

  ListNotifikasi({this.status, this.message, this.notifications});

  ListNotifikasi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  Data? data;
  String? read;
  String? create;

  Notifications({this.id, this.data, this.read, this.create});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    read = json['read'];
    create = json['create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read'] = this.read;
    data['create'] = this.create;
    return data;
  }
}

class Data {
  User? user;
  Request? request;

  Data({this.user, this.request});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? nikKtp;
  String? nikKry;
  String? email;
  String? emailVerifiedAt;
  String? telp;
  String? alamat;
  String? level;
  String? statusUser;
  String? foto;
  Null? mode;
  String? lastLoginAt;
  String? lastLoginIp;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.nikKtp,
      this.nikKry,
      this.email,
      this.emailVerifiedAt,
      this.telp,
      this.alamat,
      this.level,
      this.statusUser,
      this.foto,
      this.mode,
      this.lastLoginAt,
      this.lastLoginIp,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nikKtp = json['nik_ktp'];
    nikKry = json['nik_kry'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    telp = json['telp'];
    alamat = json['alamat'];
    level = json['level'];
    statusUser = json['status_user'];
    foto = json['foto'];
    mode = json['mode'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nik_ktp'] = this.nikKtp;
    data['nik_kry'] = this.nikKry;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['telp'] = this.telp;
    data['alamat'] = this.alamat;
    data['level'] = this.level;
    data['status_user'] = this.statusUser;
    data['foto'] = this.foto;
    data['mode'] = this.mode;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_ip'] = this.lastLoginIp;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Request {
  String? notif;

  Request({this.notif});

  Request.fromJson(Map<String, dynamic> json) {
    notif = json['notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notif'] = this.notif;
    return data;
  }
}
