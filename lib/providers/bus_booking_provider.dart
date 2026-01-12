import 'package:citym/data/repository/abstract/bus_booking_repository.dart';
import 'package:citym/data/repository/rails/rails_auth_repository.dart';
import 'package:citym/data/repository/rails/rails_bus_booking_repository.dart';
import 'package:citym/models/bus_booking.dart';
import 'package:flutter/material.dart';
import 'package:citym/providers/asyncvalue.dart';

class BusBookingProvider extends ChangeNotifier {
  final BusBookingRepository _busBookingRepository =
      RailsBusBookingRepository(RailsAuthRepository());
  
  AsyncValue<List<BusBooking>>? bookingsListValue;
  AsyncValue<Map<String, dynamic>>? createBookingValue;

  Future<List<BusBooking>> getBookings() async {
    bookingsListValue = AsyncValue.loading();
    notifyListeners();

    try {
      final results = await Future.wait([
        _busBookingRepository.getBookings(),
        Future.delayed(const Duration(seconds: 1)),
      ]);

      final bookings = results[0] as List<BusBooking>;

      bookingsListValue = AsyncValue.success(bookings);
      notifyListeners();
      return bookings;
    } catch (error) {
      bookingsListValue = AsyncValue.error(error);
      notifyListeners();
      return [];
    }
  }

  Future<Map<String, dynamic>> createBooking({
    required int busScheduleId,
    required String passengerName,
    required String passengerEmail,
    required int numberOfSeats,
    String? passengerPhoneNumber,
  }) async {
    createBookingValue = AsyncValue.loading();
    notifyListeners();

    try {
      final result = await _busBookingRepository.createBooking(
        busScheduleId: busScheduleId,
        passengerName: passengerName,
        passengerEmail: passengerEmail,
        numberOfSeats: numberOfSeats,
        passengerPhoneNumber: passengerPhoneNumber,
      );

      createBookingValue = AsyncValue.success(result);
      notifyListeners();
      await getBookings();

      return result;
    } catch (error) {
      createBookingValue = AsyncValue.error(error);
      notifyListeners();
      return {'success': false, 'message': 'Failed to create booking: ${error.toString()}'};
    }
  }
}
