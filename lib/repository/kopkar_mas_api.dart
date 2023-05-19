import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kopkar_mas_app/contents/api_url.dart';
import 'package:kopkar_mas_app/helpers/preference_helper.dart';
import 'package:kopkar_mas_app/models/network_response.dart';

class KopkarMasApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      // headers: {
      //   'Authorization': ApiUrl.apiKey,
      //   HttpHeaders.contentTypeHeader: "application/json",
      // },
      responseType: ResponseType.json,
    );
    final dio = Dio(options);
    return dio;
  }

  Future<NetworkResponse> _getRequest({endpoint, param}) async {
    final token = await PreferenceHelper().getUserData();
    final tokens = token.token!;
    // print(token);

    try {
      final dio = dioApi();
      final result = await dio.get(endpoint,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': 'Bearer ${tokens}'
          }),
          queryParameters: param);
      // print(result.data);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.error(data: null, message: 'Request timeout');
      }
      return NetworkResponse.error(data: null, message: "request timeout");
    } catch (e) {
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> _postRequest({endpoint, body}) async {
    final token = await PreferenceHelper().getUserData();
    final tok = token.token;
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer ${tok}"
          }),
          data: body);
      // return result.data;
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        // print("eror timeout");
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      // print("eror Dio");

      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      // print("eror Lainnya");
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> _putRequest({endpoint, body}) async {
    final token = await PreferenceHelper().getUserData();
    final tok = token.token;
    try {
      final dio = dioApi();
      final result = await dio.put(endpoint,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer ${tok}"
          }),
          data: body);
      // return result.data;
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        // print("eror timeout");
        return NetworkResponse.error(data: null, message: "request timeout");
      }
      // print("eror Dio");

      return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      // print("eror Lainnya");
      return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<NetworkResponse> getSimpanan() async {
    final data = await PreferenceHelper().getUserData();
    final token = data.token;
    // print(token);
    // print(nik);
    final result = await _getRequest(
      endpoint: ApiUrl.simpanans,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getTotalSimpanan() async {
    final data = await PreferenceHelper().getUserData();
    final token = data.token;
    // print(token);
    // print(nik);
    final result = await _getRequest(
      endpoint: ApiUrl.totalSimpanans,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getKredit() async {
    final data = await PreferenceHelper().getUserData();
    final token = data.token;
    // print(token);
    // print(nik);
    final result = await _getRequest(
      endpoint: ApiUrl.kredits,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getDetailKredit(id) async {
    final result = await _getRequest(endpoint: ApiUrl.detailKredit, param: {
      "id_kredit": id,
    });
    return result;
  }

  Future<NetworkResponse> getShu() async {
    final data = await PreferenceHelper().getUserData();
    final token = data.token;
    // print(token);
    // print(nik);
    final result = await _getRequest(
      endpoint: ApiUrl.shus,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getAngsuran(id) async {
    final result = await _getRequest(endpoint: ApiUrl.angsurans, param: {
      "kd_kredit": id,
    });
    return result;
  }

  Future<NetworkResponse> getdetailShu(id) async {
    final result = await _getRequest(endpoint: ApiUrl.detailShu, param: {
      "id_shu": id,
    });
    return result;
  }

  Future<NetworkResponse> postKredit(body) async {
    final result =
        await _postRequest(endpoint: ApiUrl.tambahKredits, body: body);
    // print(result);
    return result;
  }

  Future<NetworkResponse> putEditPassword(body) async {
    final result =
        await _putRequest(endpoint: ApiUrl.editPasswords, body: body);
    return result;
  }

  Future<NetworkResponse> getIdLast() async {
    final result = await _getRequest(endpoint: ApiUrl.lastIdUser);
    return result;
  }

  Future<NetworkResponse> getSisaKredit() async {
    final data = await PreferenceHelper().getUserData();
    final token = data.token;
    // print(token);
    // print(nik);
    final result = await _getRequest(
      endpoint: ApiUrl.sisaKredits,
      param: {
        "nik_ktp": data.user!.nikKtp,
      },
    );
    return result;
  }

  Future<NetworkResponse> getUserStatus() async {
    final data = await PreferenceHelper().getUserData();
    final id = data.user!.id;
    final result = await _getRequest(endpoint: ApiUrl.statusUsers, param: {
      "id": id,
    });
    return result;
  }

  Future<NetworkResponse> getNotifikasi() async {
    final data = await PreferenceHelper().getUserData();
    final id = data.user!.id;
    final result = await _getRequest(endpoint: ApiUrl.notifications, param: {
      "notifiable_id": id,
    });
    return result;
  }

  Future<NetworkResponse> getUnread() async {
    final data = await PreferenceHelper().getUserData();
    final id = data.user!.id;
    final result = await _getRequest(endpoint: ApiUrl.unreads, param: {
      "notifiable_id": id,
    });
    return result;
  }

  Future<NetworkResponse> getReadNotif(id) async {
    final result = await _getRequest(endpoint: ApiUrl.reads, param: {
      "id": id,
    });
    return result;
  }

  Future<NetworkResponse> getHapusNotif(id) async {
    final result = await _getRequest(endpoint: ApiUrl.deletes, param: {
      "id": id,
    });
    return result;
  }

  Future<NetworkResponse> getInformasi() async {
    final result = await _getRequest(endpoint: ApiUrl.listInfo);
    return result;
  }

  Future<NetworkResponse> getDetailInfo(id) async {
    final result = await _getRequest(endpoint: ApiUrl.detailInfo, param: {
      "id_info": id,
    });
    return result;
  }
}
