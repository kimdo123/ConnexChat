import 'package:connex_chat/utils/util.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                    // TODO API
                    Text(
                      'Competitor1 님',
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
                                      // TODO API 사원 사진
                                      child: Utils.people(
                                        'employee${index + 1}',
                                        40,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // TODO API 사원 이름
                                    Text(
                                      Utils.peopleName[index],
                                    ),
                                  ],
                                ),
                              );
                            },
                            // TODO API 사원 수
                            itemCount: 10,
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
}
