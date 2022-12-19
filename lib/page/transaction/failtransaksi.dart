import 'package:flutter/material.dart';
import 'package:ppodb_2/page/main_page/main_page.dart';
import 'package:ppodb_2/page/product/category_withprovider.dart';

class Failtransaction extends StatelessWidget {
  const Failtransaction({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.only(right: size.width * .044, left: size.width * .044),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .2,
            ),
            SizedBox(
              width: size.width * .9138,
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/Gagal_Pandangan_Bawah.png",
                    height: size.height * .3,
                    width: size.width * .66,
                  ),
                  const Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: "Transaksi Kamu Gagal :(",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.black))),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  const Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text:
                              "Maaf, terjadi kendala dengan transaksi\nkamu.  Yuk transaksi ulang!",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff5C5D61)))),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .17,
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: size.width * .016,
                  right: size.width * .016,
                ),
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: size.width * 3.28,
                      height: size.height * .07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0D40C6),
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CategoryProductprovider()),
                              (route) => route.isFirst);
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Transaksi Lain",
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    ))),
            SizedBox(
              height: size.height * .03625,
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: size.width * .016,
                  right: size.width * .016,
                ),
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: size.width * 3.28,
                      height: size.height * .07,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                              ((route) => route.isFirst));
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Kembali ke beranda",
                          ),
                          style: TextStyle(
                              color: Color(0xff0D40C6),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
