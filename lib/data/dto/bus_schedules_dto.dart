import 'package:citym/models/bus_schedules.dart';

class BusSchedulesDto {
  static BusSchedules fromJson(Map<String, dynamic> json) {
    return BusSchedules(
      id: json['id'] as int,
      departureTime: DateTime.parse(json['departure_time'] as String),
      arrivalTime: DateTime.parse(json['arrival_time'] as String),
      seatPrice: double.parse(json['seat_price'].toString()),
      availableSeats: json['available_seats'] as int,
      status: json['status'] as String,
      bus: Bus(
        plateNumber: json['bus']['plate_number'] as String,
        capacity: json['bus']['capacity'] as int,
      ),
      route: Route(
        id: json['route']['id'] as int,
        origin: json['route']['origin'] as String,
        destination: json['route']['destination'] as String,
      ),
    );
  }
}