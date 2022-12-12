import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ppodb_2/models/data_register_model.dart';
import 'package:ppodb_2/page/login_register/login_page.dart';
import 'package:ppodb_2/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../shared/shared.dart';

class Register2Page extends StatefulWidget {
  Register2Page({required this.register1model, super.key});
  final Register1Model register1model;

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final formKey = GlobalKey<FormState>();
  final _katasandiController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  String _simpanData = '';

  void tampilkanBottom(String errorText) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          color: whiteColor,
          child: Center(
            child: Column(
            
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // SizedBox(height: 10,),
                Image.asset("assets/Indikator.png",),
                Image.asset("assets/pop_up_email.png"),
                Text(
                  "${errorText} sudah terdaftar",
                  style: blackTextStyle.copyWith(fontSize: 20),
                ),
                Text(
                  "Email ini sudah terdaftar di MyCuan, kamu bisa menggunakan email ini untuk masuk",
                  style: dengerTextStyle.copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Masuk ke Akun MyCuan',
                    style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context, listen: false);
    final providerKonfirmasi = Provider.of<AuthViewModel>(context);
    var Size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),
        centerTitle: true,
        title: Text(
          "Daftar",
          style: dengerTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                right: Size.width * 0.044, left: Size.width * 0.044),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Size.height * 0.02,
                    ),
                    Container(
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        width: 150,
                        lineHeight: 10,
                        animation: true,
                        percent: 100 / 100,
                        animationDuration: 1000,
                        progressColor: primaryColor,
                        barRadius: Radius.circular(10),
                      ),
                    ),
                    SizedBox(
                      height: Size.height * 0.01,
                    ),
                    Text(
                      "Langkah 2 dari 2",
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                    SizedBox(
                      height: Size.height * 0.01,
                    ),
                    Text(
                      "Buat kata sandi kamu!",
                      style: blackTextStyle.copyWith(fontSize: 22),
                    ),
                    SizedBox(
                      height: Size.height * 0.045,
                    ),
                    Text(
                      "Kata Sandi",
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: Size.height * 0.00625,
                    ),
                    TextFormField(
                        obscureText: providerKonfirmasi.passVissible,
                        controller: _katasandiController,
                        validator: (value) {
                          final karakterRegExp = new RegExp(r'^.{8,}$');
                          final hurufkecilRegExp = new RegExp('(?=.*[a-z])');
                          final kapitalRegExp = new RegExp('(?=.*[A-Z])');
                          final angkaRegExp = new RegExp('(?=.*[0-9])');
                          if (value!.isEmpty) {
                            provider.setIfValueEmpty();
                            return "Harus diisi";
                          } else {
                            provider.setIfValueNotEmpty();
                            if (!karakterRegExp.hasMatch(value)) {
                              provider.setIf8DigitNotMatch();
                              // return 'harus 8 karakter';
                            }
                            if (!hurufkecilRegExp.hasMatch(value)) {
                              provider.setIfHurufKecilNotMatch();
                              // return 'harus ada huruf kecil';
                            }
                            if (!kapitalRegExp.hasMatch(value)) {
                              provider.setIfHurufKapitalNotMatch();
                              // return 'harus ada huruf kapital';
                            }
                            if (!angkaRegExp.hasMatch(value)) {
                              provider.setIfAngkaNotMatch();

                              // return 'harus ada angka';
                            }
                          }
                          _simpanData = value;
                          print(value);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(providerKonfirmasi.passVissible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              provider.setPassVissible();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Sstt! jangan disebarin yah!",
                          labelText: "Sstt! jangan disebarin yah!",
                        )),
                    SizedBox(
                      height: Size.height * 0.025,
                    ),
                    Text(
                      "Konfirmasi Kata Sandi",
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: Size.height * 0.00625,
                    ),
                    TextFormField(
                        obscureText: providerKonfirmasi.passVissible2,
                        controller: _konfirmasiController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Harus diisi";
                          } else if (value != _simpanData) {
                            return 'konfirmasi tidak sesuai';
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(providerKonfirmasi.passVissible2
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              provider.setPassVissible2();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Ulangi kata sandi kamu",
                          labelText: "Ulangi kata sandi kamu",
                        )),
                    SizedBox(
                      height: Size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Badge(
                              badgeColor: providerKonfirmasi.is8Digit
                                  ? Colors.green
                                  : Colors.red,
                              badgeContent: providerKonfirmasi.is8Digit
                                  ? Icon(
                                      Icons.check_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    )
                                  : Icon(
                                      Icons.close_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    ),
                            ),
                            Text('8 Karakter'),
                          ],
                        ),
                        Column(
                          children: [
                            Badge(
                              badgeColor: providerKonfirmasi.isHurufKecil
                                  ? Colors.green
                                  : Colors.red,
                              badgeContent: providerKonfirmasi.isHurufKecil
                                  ? Icon(
                                      Icons.check_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    )
                                  : Icon(
                                      Icons.close_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    ),
                            ),
                            Text('Huruf Kecil'),
                          ],
                        ),
                        Column(
                          children: [
                            Badge(
                              badgeColor: providerKonfirmasi.isHurufKapital
                                  ? Colors.green
                                  : Colors.red,
                              badgeContent: providerKonfirmasi.isHurufKapital
                                  ? Icon(
                                      Icons.check_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    )
                                  : Icon(
                                      Icons.close_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    ),
                            ),
                            Text('Huruf Kapital'),
                          ],
                        ),
                        Column(
                          children: [
                            Badge(
                              badgeColor: providerKonfirmasi.isAngka
                                  ? Colors.green
                                  : Colors.red,
                              badgeContent: providerKonfirmasi.isAngka
                                  ? Icon(
                                      Icons.check_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    )
                                  : Icon(
                                      Icons.close_outlined,
                                      size: 33,
                                      color: whiteColor,
                                    ),
                            ),
                            Text('Angka'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Size.height * 0.1875,
                    ),
                    Container(
                      height: Size.height * 0.06,
                      width: Size.width * 0.911,
                      child: ElevatedButton(
                          onPressed: () async {
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              final users = Register2Model(
                                katasandi: _katasandiController.text,
                                konfirmasi: _konfirmasiController.text,
                              );
                              Provider.of<AuthViewModel>(context, listen: false)
                                  .getAllRegister(
                                      widget.register1model.namalengkap,
                                      widget.register1model.nomortelpon,
                                      widget.register1model.email,
                                      _katasandiController.text,
                                      "");

                              await Future.delayed(const Duration(seconds: 2));
                              if (providerKonfirmasi.isNext == "berhasil") {
                                if (!mounted) return;
                                Provider.of<AuthViewModel>(context,
                                        listen: false)
                                    .saveData2(users);

                                print("pindah halaman");
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              }
                              if (providerKonfirmasi.isNext == "email") {
                                tampilkanBottom("Email");
                              }
                              if (providerKonfirmasi.isNext == "number") {
                                tampilkanBottom("Number");
                              }
                              if (providerKonfirmasi.isNext == "email&number") {
                                print("hasil${providerKonfirmasi.isNext}");
                                tampilkanBottom("email&number");
                              }
                            }
                          },
                          child: Text(
                            'Daftar',
                            style: whiteTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                    ),
                    SizedBox(
                      height: Size.height * 0.0125,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun?",
                          style: blackTextStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          width: Size.width * 0.022,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                            },
                            child: Text(
                              "Masuk",
                              style: primaryTextStyle.copyWith(fontSize: 14),
                            )),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
