import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
part 'apiClient.g.dart';


@RestApi(baseUrl: "https://wft-geo-db.p.rapidapi.com/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}){
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    return _RestClient(dio, baseUrl: baseUrl);
  }
  //factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  static const _api_key = 'cd516d1873mshd9f4363d5eafbc5p184fe4jsn11e4e3ae9386';

  @GET("tasks")
  Future<List<Task>> getTasks();

  @GET("geo/countries/{code}")
  @Headers(<String, String>{"content-type": "application/json",
    "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
    "x-rapidapi-key":_api_key,})
  Future<Data> getCountryImage(@Path("code") String code);
}

@JsonSerializable()
class Task {
  String id;
  String name;
  String avatar;
  String createdAt;

  Task({this.id, this.name, this.avatar, this.createdAt});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class Data {
  CountryImage countryImage;

  Data({this.countryImage});

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
        countryImage: CountryImage.fromJson(json['data'])
    );
  }
}

@JsonSerializable()
class CountryImage {
  final String imageUrl;

  CountryImage({this.imageUrl});
  factory CountryImage.fromJson(Map<String, dynamic> json){
    return CountryImage(
      imageUrl: json['flagImageUri'],
    );
  }
}