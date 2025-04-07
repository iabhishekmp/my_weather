import 'package:equatable/equatable.dart';

import 'weather_entity.dart';

class ForecastEntity extends Equatable {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<WeatherEntity>? list;

  const ForecastEntity({this.cod, this.message, this.cnt, this.list});

  ForecastEntity copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<WeatherEntity>? list,
  }) => ForecastEntity(
    cod: cod ?? this.cod,
    message: message ?? this.message,
    cnt: cnt ?? this.cnt,
    list: list ?? this.list,
  );

  factory ForecastEntity.fromJson(Map<String, dynamic> json) => ForecastEntity(
    cod: json['cod'],
    message: json['message'],
    cnt: json['cnt'],
    list:
        json['list'] == null
            ? []
            : List<WeatherEntity>.from(
              json['list']!.map((dynamic x) => WeatherEntity.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    'cod': cod,
    'message': message,
    'cnt': cnt,
    'list':
        list == null
            ? <dynamic>[]
            : List<dynamic>.from(list!.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [cod, message, cnt, list];
}
