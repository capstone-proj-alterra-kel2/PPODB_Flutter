import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppodb_2/models/dummymodel.dart';
import 'package:ppodb_2/page/akun/akun.dart';
import 'package:ppodb_2/page/akun/background.dart';
import 'package:ppodb_2/page/faq/faq.dart';
import 'package:ppodb_2/page/home/background.dart';
import 'package:ppodb_2/page/product/category_withprovider.dart';
import 'package:ppodb_2/page/product/categoryhome.dart';
import 'package:ppodb_2/page/product/detail_product.dart';
import 'package:ppodb_2/page/produk/pulsa.dart';
import 'package:ppodb_2/page/riwayat/riwayat.dart';
import 'package:ppodb_2/page/product/categoryhome.dart';
import 'package:ppodb_2/page/widgets/botton_navigation_box.dart';
import 'package:ppodb_2/page/widgets/boxIconMenu.dart';
import 'package:ppodb_2/page/widgets/box_besar.dart';
import 'package:ppodb_2/page/widgets/box_kecil.dart';
import 'package:ppodb_2/page/widgets/bpjs.dart';
import 'package:ppodb_2/page/widgets/constanta.dart';
import 'package:ppodb_2/page/widgets/finite_state.dart';
import 'package:ppodb_2/page/widgets/isisaldo.dart';
import 'package:ppodb_2/page/widgets/listrik_pln.dart';
import 'package:ppodb_2/page/widgets/notready.dart';

import 'package:ppodb_2/page/widgets/pdams.dart';

import 'package:ppodb_2/page/widgets/tampilantelekom.dart';
import 'package:ppodb_2/page/widgets/textIconMenu.dart';
import 'package:ppodb_2/service/database/myCuan_Api.dart';
import 'package:ppodb_2/service/providers/profil/profil_provider.dart';
import 'package:ppodb_2/service/providers/wallet/wallet_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Dummypaket> dummy = [
    Dummypaket(
        desc:
            "Langganan Disney+ Hotstar 1 bulan (Kuota Maxstream 3GB). Masa berlaku 30 hari. Jika kuota MAXstream habis pelanggan dapat membeli kuota tambahan. \n\nJika masa aktif paket ini belum berakhir, pembelian paket Disney+ Hotstar selanjutnya akan gagal dan tidak menambah masa aktif paket yang sudah ada.",
        harga: 22000,
        id: 1,
        name: "Paket Disney+ Hotstar\n(30 Hari)"),
    Dummypaket(
        desc:
            "Kuota 1,5GB untuk akses aplikasi Zoom. Langganan akun Zoom Pro berlaku untuk 3 hari. Akun Zoom Pro bisa melakukan hostmeeting lebih dari 40 menit dengan partisipan hingga 300 orang. Kuota internet Zoom dan akun Zoom Pro berlaku berlaku hingga pukul 23.59 pada hari terakhir masa aktif paket.",
        harga: 25000,
        id: 2,
        name: "Paket Zoom Pro 1.5GB\n(3 Hari)"),
    Dummypaket(
        desc: "Kuota MaxStream 12GB + Kuota Utama 3GB. Masa Berlaku 30 Hari.",
        harga: 50000,
        id: 3,
        name: "Paket Gigamax Basic 15GB"),
    Dummypaket(
        desc:
            "Kuota utama mulai 3.3 GB hingga 7GB + 1GB OMG! dengan masa berlaku 30 hari. (Kuota internet sesuai zona user, silahkan cek di *363*46#)",
        harga: 54000,
        id: 3,
        name: "Paket Internet Bulanan OMG! 55rb"),
    Dummypaket(
        desc:
            "Kuota Utama mulai 3.3GB hingga 7GB + 1GB OMG!. Bonus berlangganan Vidio. Masa berlaku 30 hari. Kuota internet sesuai zona user, silahkan cek di *363*46#",
        harga: 64000,
        id: 4,
        name: "[New] Paket Internet Bulanan OMG + Vidio 65K")
  ];
  List<ProductDummyModel> fafa = [
    ProductDummyModel(
        id: 1, name: "5.000", diskon: 2000, harga: 6000, status: "diskon"),
    ProductDummyModel(
        id: 2, name: "10.000", diskon: 0, harga: 10200, status: "tersedia"),
    ProductDummyModel(
        id: 3, name: "20.000", diskon: 0, harga: 22000, status: "tersedia"),
    ProductDummyModel(
        id: 4, name: "50.000", diskon: 0, harga: 51000, status: "tersedia"),
    ProductDummyModel(
        id: 5, name: "100.000", diskon: 2000, harga: 100000, status: "diskon"),
    ProductDummyModel(
        id: 5, name: "200.000", diskon: 0, harga: 200000, status: "habis"),
  ];
  late PageController _pageController;
  int activePage = 1;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    Future.delayed(
      Duration.zero,
      () {
        final _provider = Provider.of<ProfilProvider>(context, listen: false);

        /// Fetch users data
        _provider.fetchProfil();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.only(bottom: 3, left: 3, right: 3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? primaryColor : offIndikartor,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightt = MediaQuery.of(context).size.height;
    double widthh = MediaQuery.of(context).size.width;

    return Scaffold(
        // extendBodyBehindAppBar: ,

        body: BackgroundHome(
      child: SizedBox(
        height: heightt,
        width: widthh,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: heightt * 26 / 800,
              ),
              Padding(
                padding: EdgeInsets.only(top: heightt * 10 / 800),
                child: SizedBox(
                  height: heightt * 50 / 800,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icon/c.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: widthh * 6 / 360,
                      ),
                      Image.asset(
                        "assets/icon/MYCUAN.png",
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: widthh * 180 / 360),
                        child: Image.asset(
                          "assets/icon/lonceng.png",
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: heightt * 16 / 800),
                child: Boxkecil(
                    child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Saldo",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                      Consumer<ProfilProvider>(
                        builder: (context, provider, _) {
                          switch (provider.myState) {
                            case MyState.loading:
                              return Padding(
                          padding: EdgeInsets.only(top: heightt * 5 / 800),
                          child: Text("Rp. 0",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23)),
                        );
                        case MyState.loaded:
                        if(provider.profil!.data!.wallet!.balance==null){
                          return Padding(
                          padding: EdgeInsets.only(top: heightt * 5 / 800),
                          child: Text("Rp. 0",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23)),
                        );
                        }else{
                           return Padding(
                            padding: EdgeInsets.only(top: heightt * 5 / 800),
                            child: Text("Rp."+ provider.profil!.data!.wallet!.balance.toString(),
                                style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 23)),
                                                  );
                        }
                        case MyState.failed:
                        return Padding(
                          padding: EdgeInsets.only(top: heightt * 5 / 800),
                          child: Text("Error",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23)),
                        );
                              
                            default:
                              return CircularProgressIndicator();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: heightt * 5 / 800),
                          child: Text("Rp. 0",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23)),
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: heightt * 36 / 800,
                        width: widthh * 33 / 360,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(400)),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Isisaldo())));
                          },
                          icon: Image.asset(
                            "assets/icon/Plus.png",
                            height: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widthh * 5 / 360,
                      ),
                      Text("Top Up",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ],
                  ),
                )),
              ),
              Boxbesar(
                  child: Container(
                width: double.infinity,
                height: heightt * 205 / 800,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: heightt * 16 / 800,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    // childAspectRatio: 5 ,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: modulName.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (modulName[index] == "Pulsa") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      Tampilan_telekom(type: 7))));
                        }
                        if (modulName[index] == "Paket Data") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      Tampilan_telekom(type: 6))));
                        }
                        if (modulName[index] == "PDAM") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DetailProduct(
                                        code: 11,
                                      ))));
                        }
                        if (modulName[index] == "Listrik") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DetailProduct(
                                        code: 9,
                                      ))));
                        }
                        if (modulName[index] == "BPJS") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DetailProduct(
                                        code: 8,
                                      ))));
                        }
                        if (modulName[index] == "Indihome") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Notready())));
                        }
                        if (modulName[index] == "Voucher Game") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Notready())));
                        }
                        if (modulName[index] == "Lainnya") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      CategoryProductprovider())));
                        }
                      },
                      child: Column(
                        children: [
                          if (modulName[index] == "Pulsa") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "Paket Data") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "PDAM") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "Listrik") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "BPJS") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "Indihome") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "Voucher Game") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                          if (modulName[index] == "Lainnya") ...[
                            BoxIconModul(icon: iconModul[index]),
                            TextIconModul(label: modulName[index].toString())
                          ],
                        ],
                      ),
                    );
                  },
                ),
              )),
              Container(
                height: heightt * 228 / 800,
                width: widthh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthh * 24 / 360,
                          top: heightt * 24 / 800,
                          bottom: heightt * 8 / 800),
                      child: Text("Promo",
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: PageView.builder(
                          itemCount: gambarPromo.length,
                          pageSnapping: true,
                          controller: _pageController,
                          onPageChanged: (page) {
                            setState(() {
                              activePage = page;
                            });
                          },
                          itemBuilder: (context, pagePosition) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                    child: Container(
                                  margin:
                                      EdgeInsets.only(right: widthh * 20 / 360),
                                  width: widthh,
                                  height: heightt * 140 / 800,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              gambarPromo[pagePosition]))),
                                )),
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: widthh * 35 / 328, bottom: heightt * 5 / 800),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: indicators(gambarPromo.length, activePage)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: widthh * 24 / 360,
                    bottom: heightt * 10 / 800,
                    top: heightt * 24 / 800),
                child: Text("Butuh Bantuan ?",
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: widthh * 24 / 360, right: widthh * 24 / 360),
                child: InkWell(
                    child: Container(
                  width: widthh * 328 / 360,
                  height: heightt * 140 / 800,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      "assets/image/Hotline.png",
                    )),
                  ),
                )),
              ),
              SizedBox(
                height: heightt * 30 / 800,
              )
            ],
            //  Container(
            //    child: Text("Promo",style: GoogleFonts.inter(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w600
            //    ),),
            //  )
          ),
        ),
      ),
    ));
  }
}
