import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ppodb_2/page/home/home.dart';
import 'package:ppodb_2/page/login_register/register1_page.dart';
import 'package:ppodb_2/page/main_page/main_page.dart';
import 'package:ppodb_2/shared/shared.dart';
import 'package:ppodb_2/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _katasandiController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
void showAlertDialog (){
  showDialog(context: context, builder: (context) {
    return Dialog(
      backgroundColor: Color.fromARGB(255, 242, 167, 167),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      alignment: Alignment.topCenter,
      child: Container(
        height: 80,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.red, size: 30,),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Email, nomor handphone, atau kata sandi salah. Mohon cek lagi."),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },);
}

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
          "Masuk",
          style: dengerTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                right: Size.width * 0.044, left: Size.width * 0.044),
            child: ListView(children: [
              Image.asset(
                'assets/bg_login.png',
                width: Size.width * 0.805,
                height: Size.height * 0.2875,
              ),
              SizedBox(
                height: Size.height * 0.045,
              ),
              Text(
                "E-mail/No.Hp",
                style: blackTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: Size.height * 0.0125,
              ),
              TextFormField(
                  controller: _emailController,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return "email tidak valid";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "emailkamu@gmail.com",
                    labelText: "emailkamu@gmail.com",
                  )),
              SizedBox(
                height: Size.height * 0.025,
              ),
              Text(
                "Kata Sandi",
                style: blackTextStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: Size.height * 0.0125,
              ),
              TextFormField(
                obscureText: providerKonfirmasi.passVissible,
                  controller: _katasandiController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Sandi tidak boleh";
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon: Icon(
                            providerKonfirmasi.passVissible?
                            Icons.visibility_off:Icons.visibility),onPressed: () {
                            provider.setPassVissible();
                          },),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Kata Sandi",
                    labelText: "Kata Sandi",
                  )),
              SizedBox(
                height: Size.height * 0.0125,
              ),
              Text(
                "Lupa kata sandi?",
                style: primaryTextStyle.copyWith(fontSize: 12),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: Size.height * 0.09,
              ),
              Container(
                height: Size.height * 0.06,
                width: Size.width * 0.911,
                child: ElevatedButton(
                    onPressed: () async{
                      final isValidForm = formKey.currentState!.validate();
                      if (isValidForm) {
                        
                            await Provider.of<AuthViewModel>(context, listen: false).getToken( _emailController.text, _katasandiController.text);
                            if(providerKonfirmasi.message == "invalid email or password"){
                              print("email dan kata sandi salah");
                             showAlertDialog();
                            }
                            if(providerKonfirmasi.message == "validation failed"){
                              print("validasi gagal");
                              showAlertDialog();
                            }
                            if(providerKonfirmasi.message == "success"){
                              if(!mounted)return;
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),(route)=>false);
                            }
                            
                        
                      }
                    },
                    child: Text(
                      'Masuk',
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
                height: Size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun?",
                    style: blackTextStyle.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    width: Size.width * 0.022,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Register1Page(),
                        ));
                      },
                      child: Text(
                        "Daftar",
                        style: primaryTextStyle.copyWith(fontSize: 14),
                      )),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
