import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppodb_2/models/profil/list_profil.dart';
import 'package:ppodb_2/models/riwayat/rmodel_riwayat.dart';

import 'package:ppodb_2/page/akun/akun.dart';
import 'package:ppodb_2/page/widgets/finite_state.dart';
import 'package:ppodb_2/service/database/myCuan_Api.dart';


class RiwayatProvider extends ChangeNotifier {
  final MyCuanAPI service = MyCuanAPI();

  RiwayatData? riwayat;
  String _isNext = "";

  MyState myState = MyState.loading;

  Future fetchRiwayat() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      riwayat = await service.getHistory();

      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        /// If want to check status code from service error
        e.response!.statusCode;
      }

      myState = MyState.failed;
      notifyListeners();
    }
  }

  
}



