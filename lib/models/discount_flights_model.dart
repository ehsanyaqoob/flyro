
// Updated Flight Model with additional fields
import 'package:flyro/generated/assets.dart';

class DiscountFlight {
  final String airline;
  final String? airlineLogo;
  final String aircraftType;
  final String fromCode;
  final String toCode;
  final String fromCity;
  final String toCity;
  final String duration;
  final String departureTime;
  final String price;
  final String dateTime;

  DiscountFlight({
    required this.airline,
    this.airlineLogo,
    required this.aircraftType,
    required this.fromCode,
    required this.toCode,
    required this.fromCity,
    required this.toCity,
    required this.duration,
    required this.departureTime,
    required this.price,
    this.dateTime = '',
  });

  factory DiscountFlight.fromJson(Map<String, dynamic> json) {
    return DiscountFlight(
      airline: json['airline'] as String,
      airlineLogo: json['airlineLogo'] as String?,
      aircraftType: json['aircraftType'] as String,
      fromCode: json['fromCode'] as String,
      toCode: json['toCode'] as String,
      fromCity: json['fromCity'] as String,
      toCity: json['toCity'] as String,
      duration: json['duration'] as String,
      departureTime: json['departureTime'] as String,
      price: json['price'] as String,
      dateTime: json['dateTime'] as String? ?? '',
    );
  }
}

// Dummy JSON Data for Discount Flights
const List<Map<String, dynamic>> discountFlightDataJson = [
  {
    'airline': 'AIR FRANCE',
    'airlineLogo': Assets.airplaneforward,
    'aircraftType': 'A330',
    'fromCode': 'LHR',
    'toCode': 'JFK',
    'fromCity': 'London',
    'toCity': 'New York',
    'duration': '2hr 30min',
    'departureTime': '09:00 AM',
    'price': '\$250',
    'dateTime': '09:00:00',
  },
  {
    'airline': 'TURKISH AIRLINES',
    'airlineLogo': Assets.airplaneforward,
    'aircraftType': 'A330',
    'fromCode': 'LHR',
    'toCode': 'JFK',
    'fromCity': 'London',
    'toCity': 'New York',
    'duration': '2hr 45min',
    'departureTime': '10:15 AM',
    'price': '\$220',    'dateTime': '9:00:00',

  },
  {
    'airline': 'LUFTHANSA',
    'airlineLogo': Assets.airplaneforward,
    'aircraftType': 'B787',
    'fromCode': 'CDG',
    'toCode': 'LAX',
    'fromCity': 'Paris',
    'toCity': 'Los Angeles',
    'duration': '3hr 15min',
    'departureTime': '14:30 AM',
    'price': '\$180',    'dateTime': '09:00:00',

  },
  {
    'airline': 'EMIRATES',
    'airlineLogo': Assets.airplaneforward,
    'aircraftType': 'A380',
    'fromCode': 'DXB',
    'toCode': 'LHR',
    'fromCity': 'Dubai',
    'toCity': 'London',
    'duration': '1hr 50min',
    'departureTime': '16:45 PM',
    'price': '\$290',    'dateTime': '09:00:00',

  },
  {
    'airline': 'SINGAPORE AIRLINES',
    'airlineLogo': Assets.airplaneforward,
    'aircraftType': 'A350',
    'fromCode': 'SIN',
    'toCode': 'BKK',
    'fromCity': 'Singapore',
    'toCity': 'Bangkok',
    'duration': '1hr 20min',
    'departureTime': '08:30 AM',
    'price': '\$95',    'dateTime': '08:30:00',

  },
];