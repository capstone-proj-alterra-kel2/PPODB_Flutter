import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ppodb_2/models/profil/list_profil.dart';
import 'package:ppodb_2/models/register_model.dart';

import 'package:ppodb_2/page/akun/akun.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _dio = Dio(
  BaseOptions(
    baseUrl: 'https://foodnih.com/v1',
  ),
);
class MyCuanAPI {
  MyCuanAPI() {
    
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
  }
  String _isNext = "";
  String get isNext => _isNext;


  Future<Wallet> getBalance() async {
     final prefs = await SharedPreferences.getInstance();
final String token = prefs.getString('token') ?? "";
    try {
      final response = await _dio
          .get('/user/wallet',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token",
          }));
         
         _isNext = "berhasil";
         Wallet dataWallet= Wallet.fromJson(response.data);
        return dataWallet;
      
    } on DioError catch (e) {
      print(e.response!.data['message']);
      print('data bermasalah');
       _isNext = "gagal";
      rethrow;
    }
  }
  Future<DataProfil> getProfil() async {
    final prefs = await SharedPreferences.getInstance();
final String token = prefs.getString('token') ?? "";
    try {
      final response = await _dio
          .get('/user/profile',
           options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token",
          })
          );
         print(response.data);
      print(response.statusCode);
         _isNext = "berhasil";
          DataProfil dataProfil = DataProfil.fromJson(response.data);
        return dataProfil;
      
    } on DioError catch (e) {
      print(e.response!.data['message']);
      print('data bermasalah');
       _isNext = "gagal";
      rethrow;
    }
  }
  Future updateUser(String name, String phone_number, String email,   ) async {
    final prefs = await SharedPreferences.getInstance();
final String token = prefs.getString('token') ?? "";
    try {
      final response = await _dio
          .put('/user/data', 
           options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token",
          }) ,         
          data: {            
            "name":name, 
            "phone_number":phone_number, 
            "email":email,});
             DataProfil dataProfilUpdate = DataProfil.fromJson(response.data);
         
          _isNext = "berhasil";
          print(dataProfilUpdate);
        return dataProfilUpdate;
         
        
        
      
    } on DioError catch (e) {
      print(e.response!.data['message']);
      print('data bermasalah');
       _isNext = "gagal";
      rethrow;
    }
  }
   Future updateGambar(File gambar,    ) async {
    final prefs = await SharedPreferences.getInstance();
final String token = prefs.getString('token') ?? "";
 
    
    try {
      String fileName = gambar.path.split('/').last;
    FormData formData = FormData.fromMap({
        "image":
            await MultipartFile.fromFile(gambar.path, filename:fileName),
    });
      final response = await _dio
          .put('/user/image', 
           options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token",
          }) ,         
          data: formData);
             //DataProfil dataProfilUpdate = DataProfil.fromJson(response.data);
         
          _isNext = "berhasil";
          print(response.data);
        return response.data;
         
        
        
      
    } on DioError catch (e) {
      print(e.response!.data['message']);
      print('data bermasalah');
       _isNext = "gagal";
      rethrow;
    }
  }
  Future updatePassowrd(String oldPass, String newPass   ) async {
    final prefs = await SharedPreferences.getInstance();
final String token = prefs.getString('token') ?? "";
    try {
      final response = await _dio.put('/user/password', 
           options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token",
          }) ,         
          data: {            
            "new_password":newPass, 
            "old_password":oldPass, 
            });
            
         
          _isNext = "berhasil";
          
        return response.data;
         
        
        
      
    } on DioError catch (e) {
      print(e.response!.data['message']);
      print('data bermasalah');
       _isNext = "gagal";
      rethrow;
    }
  }
  Future getToken(String email, String password) async {
    try {
      final response = await _dio
          .post('/v1/auth/login', data: {"email":email, "password":password});
        return response.data['token'];
      
    } catch (e) {
      rethrow;
    }
  }
}