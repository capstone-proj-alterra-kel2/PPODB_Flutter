import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ppodb_2/models/data_register_model.dart';
import 'package:ppodb_2/models/register_model.dart';
import 'package:ppodb_2/page/login_register/register1_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/database/auth_service.dart';

class AuthViewModel with ChangeNotifier {
  final _dioService = RegisterDioService();
  Data? dataRegister;
  static final _shared = SharedPreferences.getInstance();
  static const _token = 'token';
  String? isNext;

  bool _is8Digit = false;
  bool _isHurufKecil = false;
  bool _isHurufKapital = false;
  bool _isAngka = false;
  String _simpanData = '';
  bool _passVissible = true;
  bool _passVissible2 = true;
  Register1Model? _data1;
  Register2Model? _data2;


  bool get is8Digit => _is8Digit;
  bool get isHurufKecil => _isHurufKecil;
  bool get isHurufKapital => _isHurufKapital;
  bool get isAngka => _isAngka;
  String get simpanData => _simpanData;
  bool get passVissible => _passVissible;
  bool get passVissible2 => _passVissible2;
  Register1Model get data1 => _data1!;
  Register2Model get data2 => _data2!;
  void saveData1(Register1Model dataRegister1){
    _data1 = dataRegister1;
  }
  void saveData2(Register2Model dataRegister2){
    _data2 = dataRegister2;
  }
  // String get isNext => isNext;

  void getAllRegister(String name, String phone_number, String email,
      String password, String image) async {
    try {
      print("dijalankan");
      final result = await _dioService.getAllRegister(
          name, phone_number, email, password, image);

      dataRegister = result;
      print("tes$result");
    } catch (e) {
      if (e is DioError) {
         print("gagal");
        print(e.response!.data["message"]);
       if(e.response!.data["message"] == "email already registered"){
        isNext = "email";
        print("response email");
       }
       
       if(e.response!.data["message"] == "Number already registered"){
        isNext = "number";
         print("response number");
       }


        
      } else {
        //  print(e.response!.data["message"]);
        print("berhasil");
        isNext = "berhasil";
      }
    }
    notifyListeners();
  }

  void getToken(String email, String password) async {
    try {
      final result = await _dioService.getToken(email, password);

      saveToken(result);
    } catch (e) {}
    notifyListeners();
  }

  void setIfValueEmpty() {
    _is8Digit = false;
    _isHurufKecil = false;
    _isHurufKapital = false;
    _isAngka = false;
    notifyListeners();
  }

  void setIfValueNotEmpty() {
    _is8Digit = true;
    _isHurufKecil = true;
    _isHurufKapital = true;
    _isAngka = true;
    notifyListeners();
  }

  void setIf8DigitNotMatch() {
    _is8Digit = false;
    notifyListeners();
  }

  void setIfHurufKecilNotMatch() {
    _isHurufKecil = false;
    notifyListeners();
  }

  void setIfHurufKapitalNotMatch() {
    _isHurufKapital = false;
    notifyListeners();
  }

  void setIfAngkaNotMatch() {
    _isAngka = false;
    notifyListeners();
  }

  void setPassVissible() {
    _passVissible = !_passVissible;
    notifyListeners();
  }

  void setPassVissible2() {
    _passVissible2 = !_passVissible2;
    notifyListeners();
  }

  Future<bool> saveToken(String token) async {
    final shared = await _shared;
    return await shared.setString(_token, token);
  }

  Future<String?> getToken1() async {
    final shared = await _shared;
    return shared.getString(_token);
  }

  Future<bool> removeToken() async {
    final token = await getToken1();
    if (token == null) return false;

    final shared = await _shared;
    return await shared.remove(_token);
  }
}
