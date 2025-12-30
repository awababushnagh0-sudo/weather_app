class WeatherApi {
  final Coord coord;
  final Main main;
  final Weather weather;
  final String name;

  const WeatherApi({
    required this.name,
    required this.main,
    required this.coord,
    required this.weather,
  });

  factory WeatherApi.fromJson(Map<String, dynamic> json) {
    return WeatherApi(
      name: json['name'] ?? '',
      main: Main.fromJson(json['main']),
      coord: Coord.fromJson(json['coord']),
      weather: Weather.fromJson(
        (json['weather'] as List).isNotEmpty
            ? (json['weather'][0] as Map<String, dynamic>)
            : {'main': 'N/A', 'description': 'N/A'},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'main': main.toJson(),
      'coord': coord.toJson(),
      'weather': [weather.toJson()],
    };
  }
}

class Weather {
  final String main;
  final String description;

  const Weather({required this.main, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['main'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'main': main, 'description': description};
  }
}

class Coord {
  final double lon;
  final double lat;

  const Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] ?? '' as num).toDouble(),
      lon: (json['lon'] ?? '' as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lon': lon, 'lat': lat};
  }
}

class Main {
  final double temp;

  const Main({required this.temp});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(temp: (json['temp'] ?? '' as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {'temp': temp};
  }
}
