

import 'package:covid_detail/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';
import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
                FutureBuilder(
                    future: statesServices.fetchWorldStates(),
                    builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        PieChart(
                          baseChartColor: Colors.blue,
                          dataMap: {
                            "Total":double.parse(snapshot.data!.cases!.toString()),
                            "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                            "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                              legendTextStyle: TextStyle(color: Colors.white)

                          ),
                          animationDuration: Duration(microseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorlist,

                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                                ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString(),),
                                ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                                ReusableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString(),),
                                ReusableRow(title: 'Active Cases', value: snapshot.data!.active.toString(),),
                                ReusableRow(title: 'Affected Countries', value: snapshot.data!.affectedCountries.toString(),),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString(),),
                                ReusableRow(title: 'Total Recovered', value: snapshot.data!.todayRecovered.toString(),),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountiresList()),);
                         },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Track Continue',
                                style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        )
                      ],
                    );
                  }else{
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: controller,
                      ),);
                  }
                }),

              ],
            ),
          )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff343434),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,bottom: 5,top: 10,right: 10),
        child: Column(

          children: [

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(title,style: TextStyle(color: Colors.white),),
                Text(value,style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(height: 5,),
            Divider()

          ],
        ),
      ),
    );
  }
}

