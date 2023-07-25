

import 'package:covid_detail/Services/states_services.dart';
import 'package:covid_detail/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountiresList extends StatefulWidget {
  const CountiresList({Key? key}) : super(key: key);

  @override
  State<CountiresList> createState() => _CountiresListState();
}

class _CountiresListState extends State<CountiresList> {

  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff343434),
      ),
      backgroundColor: Color(0xff343434),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                style: TextStyle(color: Colors.white),
                controller: searchcontroller,
                decoration: InputDecoration(
                  fillColor: Colors.white,

                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const  BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(

                    borderSide: const BorderSide(
                      width: 5,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(50.0)
                  ),

                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            String name=snapshot.data![index]['country'];
                            if(searchcontroller.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        totalcase: snapshot.data![index]['cases'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totaldeath: snapshot.data![index]['deaths'],
                                        totalRecovered: snapshot.data![index]['recovered'],

                                         test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],

                                         todayRecovered: snapshot.data![index]['todayRecovered'],
                                        active: snapshot.data![index]['active'],


                                      )),);

                                      },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'],style: TextStyle(color: Colors.white),),
                                      subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(color: Colors.white),),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),),
                                    ),
                                  ),
                                ],
                              );
                            }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                        name: snapshot.data![index]['country'],
                                        totalcase: snapshot.data![index]['cases'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totaldeath: snapshot.data![index]['deaths'],
                                        totalRecovered: snapshot.data![index]['recovered'],

                                        test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]['critical'],

                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        active: snapshot.data![index]['active'],


                                      )),);
                              },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'],style: TextStyle(color: Colors.white),),
                                      subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(color: Colors.white),),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),),
                                    ),
                                  ),
                                ],
                              );
                            }else{
                              return Container();
                            }



                      });
                    }else{
                      return ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context,index){

                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(height: 10,width: 09,color: Colors.white,),
                                    subtitle: Container(height: 10,width: 09,color: Colors.white,),
                                    leading: Container(height: 50,width: 50,color: Colors.white,),
                                  ),
                                ],
                              ),
                            );

                          });
                    }

                  }) ,
                ),
          ],
        ),
      ),

    );

  }
}
