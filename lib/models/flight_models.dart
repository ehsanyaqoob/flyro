// lib/models/flight_model.dart

class Flight {
  final String fromCode;
  final String toCode;
  final String fromCity;
  final String toCity;
  final String departureTime;
  final String arrivalTime;
  final String date;

  Flight({
    required this.fromCode,
    required this.toCode,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      fromCode: json['fromCode'] as String,
      toCode: json['toCode'] as String,
      fromCity: json['fromCity'] as String,
      toCity: json['toCity'] as String,
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromCode': fromCode,
      'toCode': toCode,
      'fromCity': fromCity,
      'toCity': toCity,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'date': date,
    };
  }
}

// Dummy JSON Data
const List<Map<String, dynamic>> flightDataJson = [
  {
    'fromCode': 'LHR',
    'toCode': 'JFK',
    'fromCity': 'London',
    'toCity': 'New York',
    'departureTime': '10:15 AM',
    'arrivalTime': '12:15 PM',
    'date': 'Sat, 26 Sep',
  },
  {
    'fromCode': 'CDG',
    'toCode': 'LAX',
    'fromCity': 'Paris',
    'toCity': 'Los Angeles',
    'departureTime': '14:30 AM',
    'arrivalTime': '04:45 PM',
    'date': 'Sun, 27 Sep',
  },
  {
    'fromCode': 'DUB',
    'toCode': 'MIA',
    'fromCity': 'Dublin',
    'toCity': 'Miami',
    'departureTime': '08:00 AM',
    'arrivalTime': '11:30 AM',
    'date': 'Mon, 28 Sep',
  },
  {
    'fromCode': 'AMS',
    'toCode': 'BKK',
    'fromCity': 'Amsterdam',
    'toCity': 'Bangkok',
    'departureTime': '22:45 PM',
    'arrivalTime': '06:20 AM',
    'date': 'Tue, 29 Sep',
  },
  {
    'fromCode': 'SFO',
    'toCode': 'NRT',
    'fromCity': 'San Francisco',
    'toCity': 'Tokyo',
    'departureTime': '11:00 AM',
    'arrivalTime': '08:30 AM',
    'date': 'Wed, 30 Sep',
  },
  {
    'fromCode': 'SYD',
    'toCode': 'LAX',
    'fromCity': 'Sydney',
    'toCity': 'Los Angeles',
    'departureTime': '02:35 PM',
    'arrivalTime': '09:50 AM',
    'date': 'Thu, 01 Oct',
  },
  {
    'fromCode': 'DEL',
    'toCode': 'DXB',
    'fromCity': 'Delhi',
    'toCity': 'Dubai',
    'departureTime': '09:15 AM',
    'arrivalTime': '11:45 AM',
    'date': 'Fri, 02 Oct',
  },
  {
    'fromCode': 'BKK',
    'toCode': 'SGN',
    'fromCity': 'Bangkok',
    'toCity': 'Ho Chi Minh',
    'departureTime': '16:20 PM',
    'arrivalTime': '17:50 PM',
    'date': 'Sat, 03 Oct',
  },
  {
    'fromCode': 'IST',
    'toCode': 'FCO',
    'fromCity': 'Istanbul',
    'toCity': 'Rome',
    'departureTime': '10:00 AM',
    'arrivalTime': '12:25 PM',
    'date': 'Sun, 04 Oct',
  },
  {
    'fromCode': 'GRU',
    'toCode': 'MIA',
    'fromCity': 'São Paulo',
    'toCity': 'Miami',
    'departureTime': '19:30 PM',
    'arrivalTime': '07:15 AM',
    'date': 'Mon, 05 Oct',
  },
];

// Usage in ListView
// List<Flight> flights = flightDataJson.map((json) => Flight.fromJson(json)).toList();