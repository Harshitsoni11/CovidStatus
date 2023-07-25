import 'dart:convert';

import 'package:covid_detail/Model/WorldStatesModel.dart';
import 'package:covid_detail/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel> fetchWorldStates() async{
    final response= await http.get(Uri.parse(AppUrl.worldStateapi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async{
    var data;
    final response= await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}