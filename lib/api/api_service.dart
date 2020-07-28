import 'package:http/http.dart' show Client;
import 'package:consumir_web_api/models/materia.dart';

class ApiService{

  //final String BASE_URL = "http://api.bengkelrobot.net:8001";
  //final String ENDPOINT  = "https://webapimateria20200624231657.azurewebsites.net/api/materias";
  final String ENDPOINT  = "https://studentapi20200625220726.azurewebsites.net/api/materias";
  Client httpClient = Client();

  Future<List<Materia>> getMaterias() async {
    //final response = await httpClient.get('$BASE_URL/api/profile');
    final response = await httpClient.get("$ENDPOINT");
    if( response.statusCode == 200 ){
      return Materia.materiaFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<bool> createMateria(Materia data) async {
    final response = await httpClient.post(
      //'$BASE_URL/api/profile',
      '$ENDPOINT',
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: Materia.materiaToJson(data)
    );
    if( response.statusCode == 201 )
      return true;
    else
      return false;
  }

  Future<bool> updateMateria(Materia data) async{
    final response = await httpClient.put(
      //'$BASE_URL/api/profile/${data.id}',
      '$ENDPOINT/${data.Id}',
      headers: {'content-type' : 'application/json'},
      body: Materia.materiaToJson(data)
    );
    if( response.statusCode == 200 || response.statusCode == 204 ){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> deleteMateria(int id) async {
    final response = await httpClient.delete(
      //'$BASE_URL/api/profile/$id',
      '$ENDPOINT/$id',
      headers: {'content-type' : 'application/json'}
    );
    if( response.statusCode == 200 )
      return true;
    else
      return false;
  }
}