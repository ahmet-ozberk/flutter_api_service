import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class Service<T> {
  final dio = Dio();

  Future<T?> get(
      {required String url,
      String? token,
      Function(Map<String, dynamic> type)? fromJson,
      String? throwMessage}) async {
    Response? response;
    try {
      if (token != null) {
        response = await dio.get(url, options: options(token));
      } else {
        response = await dio.get(url);
      }
      if (response.statusCode == HttpStatus.ok) {
        if (fromJson != null) {
          return fromJson(response.data);
        }
        return response.data;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
      // ApiError.fetch(
      //     statusCode: response?.statusCode,
      //     message: error.toString().substring(0, 70));
    }
  }

  Future<T?> post(
      {required String url,
      String? token,
      String? data,
      Function(Map<String, dynamic> type)? fromJson,
      String? throwMessage}) async {
    var response;
    try {
      if (token != null) {
        response = await dio.post(url, data: data, options: options(token));
      } else {
        response = await dio.post(url, data: data);
      }
      if (response.statusCode == HttpStatus.ok) {
        if (fromJson != null) {
          return fromJson(response.data);
        }
        return response.data;
      } else {
        throw Exception(throwMessage ?? 'Failed to load data');
      }
    } catch (error) {
      debugPrint("Post İşleminde Hata: " + error.toString());
      //ApiError.fetch(statusCode: response.statusCode);
    }
  }

  Options options(String token) {
    return Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }
}

class ApiError {
  static fetch({required int? statusCode, String? message}) {
    if (statusCode == 400) {
      Grock.snackBar(
        "Kötü İstek",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Bad Request");
    } else if (statusCode == 401) {
      Grock.snackBar(
        "Yetkisiz İstek",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Unauthorized");
    } else if (statusCode == 403) {
      Grock.snackBar(
        "Yasaklı İstek",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Forbidden");
    } else if (statusCode == 404) {
      Grock.snackBar(
        "Bulunamadı",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Not Found");
    } else if (statusCode == 500) {
      Grock.snackBar(
        "Sunucu Hatası",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Internal Server Error");
    } else if (statusCode == 502) {
      Grock.snackBar(
        "Sunucu Hatası",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Bad Gateway");
    } else if (statusCode == 503) {
      Grock.snackBar(
        "Sunucu Hatası",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Service Unavailable");
    } else if (statusCode == 504) {
      Grock.snackBar(
        "Sunucu Hatası",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Gateway Timeout");
    } else {
      Grock.snackBar(
        "Bilinmeyen Hata",
        description: message,
        type: SnackbarType.error,
        border: Border.all(color: Colors.red),
        opacity: 0.7,
        textPosition: TextAlign.start,
        borderRadius: 7,
      );
      throw Exception("Unknown Error");
    }
  }
}
