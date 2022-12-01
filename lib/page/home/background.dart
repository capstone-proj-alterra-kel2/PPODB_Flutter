
import 'package:flutter/material.dart';
import 'package:ppodb_2/page/widgets/constanta.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({super.key,required this.child});
  final  Widget child;
  @override
  Widget build(BuildContext context) {
     double heightt = MediaQuery.of(context).size.height;
   double widthh = MediaQuery.of(context).size.width;
    return SizedBox(
      height: double.infinity,
      child: Stack(
        
        children: [
          Container(    
                      width: double.infinity,
                       height: heightt*260/910,        
                    decoration: BoxDecoration(              
                      color: primaryColor,
                      borderRadius: BorderRadius.only(bottomRight:Radius.circular(40),bottomLeft: Radius.circular(40))              
                    ),
                    
                  ),
                  child
        ],
      ),
    );
  }
}