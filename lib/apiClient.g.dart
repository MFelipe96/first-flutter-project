// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiClient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as String,
    name: json['name'] as String,
    avatar: json['avatar'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    countryImage: json['countryImage'] == null
        ? null
        : CountryImage.fromJson(json['countryImage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'countryImage': instance.countryImage,
    };

CountryImage _$CountryImageFromJson(Map<String, dynamic> json) {
  return CountryImage(
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$CountryImageToJson(CountryImage instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://wft-geo-db.p.rapidapi.com/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getTasks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('tasks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Task.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  getCountryImage(code) async {
    ArgumentError.checkNotNull(code, 'code');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result =
        await _dio.request('geo/countries/$code',
            queryParameters: queryParameters,
            options: RequestOptions(
                method: 'GET',
                headers: <String, dynamic>{
                  r'content-type': 'application/json',
                  r'x-rapidapi-host': 'wft-geo-db.p.rapidapi.com',
                  r'x-rapidapi-key':
                      'cd516d1873mshd9f4363d5eafbc5p184fe4jsn11e4e3ae9386'
                },
                extra: _extra,
                contentType: 'application/json',
                baseUrl: baseUrl),
            data: _data);
    final value = Data.fromJson(_result.data);
    return value;
  }
}
