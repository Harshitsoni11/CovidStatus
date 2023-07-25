import 'package:covid_detail/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalcase;
  int totaldeath;
  int totalRecovered;
  //
  int active;
  int critical;
  int todayRecovered;
  int test;

  DetailScreen({
    required this.name,
    required this.totalcase,
    required this.totaldeath,
    required this.image,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,

  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.name.toString()),
        centerTitle: true,
        backgroundColor: Color(0xff343434),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor:Color(0xff343434) ,
              radius: 50,
              backgroundImage: NetworkImage(widget.image),
            ),
            Stack(

              children: [


                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),

                  child: Card(
                    color: Color(0xff343434),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ReusableRow(
                            title: 'Cases', value: widget.totalcase.toString()),
                        ReusableRow(
                            title: 'Total Deaths', value: widget.totaldeath.toString()),
                        ReusableRow(
                            title: 'Total Recovered', value: widget.totalRecovered.toString()),

                        ReusableRow(
                            title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ReusableRow(
                            title: 'Critical', value: widget.critical.toString()),
                        ReusableRow(
                            title: 'Test', value: widget.test.toString()),
                        ReusableRow(
                            title: 'Active', value: widget.active.toString()),

                      ],
                    ),
                  ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}
