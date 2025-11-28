import 'dart:developer';

import 'package:connex_chat/controller/api.dart';
import 'package:connex_chat/controller/data.dart';
import 'package:connex_chat/utils/util.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<void> futureFunc;
  @override
  void initState() {
    super.initState();
    futureFunc = Auth.getEmpList();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFunc,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(5),
                                child: Utils.svg(
                                  'person_fill',
                                  40,
                                  Colors.deepPurple,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            profileName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(30, 30, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '사원 목록',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 500,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsetsGeometry.only(top: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Utils.people(
                                              'employee${Data.empList[index].id}',
                                              40,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            Data.empList[index].name,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: Data.empList.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
