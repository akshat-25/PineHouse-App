// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
        title: Text(
          'Detail Page',
          style: GoogleFonts.raleway(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: h * 0.2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: w * 0.26),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/6/66/Matthew_Perry_as_Chandler_Bing.png'),
                maxRadius: 80,
              ),
            ],
          ),
          Container(
            child: Text(
              'Chandler Bing',
              style: GoogleFonts.raleway(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: w * 0.2,
          ),
          Column(
            children: [
              Text(
                'Age: 30',
                style: GoogleFonts.raleway(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text('Mobile: 9876545673',
                  style: GoogleFonts.raleway(
                      fontSize: 20, fontWeight: FontWeight.w400)),
              Text('Department: HR',
                  style: GoogleFonts.raleway(
                      fontSize: 20, fontWeight: FontWeight.w400)),
            ],
          )
        ],
      ),
    );
  }
}
