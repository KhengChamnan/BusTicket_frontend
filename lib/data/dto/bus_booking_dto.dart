import 'package:citym/models/bus_booking.dart';

class BusBookingDto {
  static Map<String, dynamic> toJson({
    required int busScheduleId,
    required String passengerName,
    required String passengerEmail,
    required int numberOfSeats,
    String? passengerPhoneNumber,
  }) {
    final bookingData = {
      'bus_schedule_id': busScheduleId,
      'passenger_name': passengerName,
      'passenger_email': passengerEmail,
      'number_of_seats': numberOfSeats,
      'passenger_phone_number': passengerPhoneNumber,
    };

    return {'booking': bookingData};
  }

  static BusBooking fromJson(Map<String, dynamic> json) {
    return BusBooking(
      id: json['id'] as int,
      passengerName: json['passenger_name'] as String?,
      passengerEmail: json['passenger_email'] as String?,
      passengerPhoneNumber: json['passenger_phone_number'] as String?,
      numberOfSeats: json['number_of_seats'] as int?,
      status: json['status'] as String?,
      departureTime: json['departure_time'] != null ? DateTime.parse(json['departure_time'] as String) : null,
      bus: json['bus'] as String?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      paymentStatus: json['payment_status'] as String?,
      paymentAmount: json['payment_amount'] as String?,
      paymentMethod: json['payment_method'] as String?,
    );
  }
}
