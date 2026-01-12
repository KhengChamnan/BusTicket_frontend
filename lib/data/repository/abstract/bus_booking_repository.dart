import 'package:citym/models/bus_booking.dart';

abstract class BusBookingRepository {
  Future<Map<String, dynamic>> createBooking({
    required int busScheduleId,
    required String passengerName,
    required String passengerEmail,
    required int numberOfSeats,
    String? passengerPhoneNumber,
  });

  Future<List<BusBooking>> getBookings();

}
