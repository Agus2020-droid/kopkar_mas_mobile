class UnreadNotif {
  String? status;
  String? message;
  List<Notifications>? notifications;

  UnreadNotif({this.status, this.message, this.notifications});

  UnreadNotif.fromJson(Map<String, dynamic> json) {
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
  String? countNotif;

  Notifications({this.countNotif});

  Notifications.fromJson(Map<String, dynamic> json) {
    countNotif = json['count_notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_notif'] = this.countNotif;
    return data;
  }
}
