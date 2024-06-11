import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
            ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){

          },
          child: Container(
          margin: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: SvgPicture.asset('asset\icons\filter-svgrepo-com.svg'),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 73, 173, 173),
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child:Container(
          margin: const EdgeInsets.all(8),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'asset\icons\filter-svgrepo-com.svg',
            height: 5,
            width: 5,
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 43, 155, 155),
            borderRadius: BorderRadius.circular(10)
          ),
          ),
          ),
          ], 
      ),
    );
  }
}

