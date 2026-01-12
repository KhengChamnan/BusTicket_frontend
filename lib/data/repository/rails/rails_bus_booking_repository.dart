import 'dart:convert';
import 'package:citym/data/dto/bus_booking_dto.dart';
import 'package:citym/data/dto/payment_dto.dart';
import 'package:citym/data/repository/abstract/bus_booking_repository.dart';
import 'package:citym/data/repository/rails/rails_auth_repository.dart';
import 'package:citym/models/bus_booking.dart';
import 'package:citym/network/api_constant.dart';
import 'package:http/http.dart' as http;

class RailsBusBookingRepository extends BusBookingRepository {
  final RailsAuthRepository _authRepository;

  RailsBusBookingRepository(this._authRepository);

  @override
  Future<Map<String, dynamic>> createBooking({
    required int busScheduleId,
    required String passengerName,
    required String passengerEmail,
    required int numberOfSeats,
    String? passengerPhoneNumber,
  }) async {
    try {
      // Get authentication token
      final token = await _authRepository.getToken();
      if (token == null) {
        return {'success': false, 'message': 'No authentication token found'};
      }

      // Step 1: Create booking
      final bookingResponse = await http.post(
        Uri.parse(ApiEndPoints.busBooking),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
        body: json.encode(BusBookingDto.toJson(
          busScheduleId: busScheduleId,
          passengerName: passengerName,
          passengerEmail: passengerEmail,
          numberOfSeats: numberOfSeats,
          passengerPhoneNumber: passengerPhoneNumber,
        )),
      );

      // Check if booking creation was successful
      if (bookingResponse.statusCode != 201) {
        final errorData = json.decode(bookingResponse.body);
        return {
          'success': false,
          'message': errorData['error'] ?? errorData['errors']?.join(', ') ?? 'Failed to create booking'
        };
      }

      final bookingData = json.decode(bookingResponse.body);
      final bookingId = bookingData['booking']['id'] as int;

      // Step 2: Process payment with hardcoded "credit" method
      final paymentResponse = await http.post(
        Uri.parse(ApiEndPoints.payment),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
        body: json.encode(PaymentDto.toJson(
          bookingId: bookingId,
          paymentMethod: 'credit',
        )),
      );

      // Handle payment response
      if (paymentResponse.statusCode == 422) {
        final paymentErrorData = json.decode(paymentResponse.body);
        return {
          'success': false,
          'message': paymentErrorData['errors']?.join(', ') ?? 'Payment failed',
        };
      }

      if (paymentResponse.statusCode < 200 || paymentResponse.statusCode >= 300) {
        // Other payment errors
        return {
          'success': false,
          'message': 'Payment processing failed',
        };
      }

      // Both booking and payment successful
      return {
        'success': true,
        'message': 'Booking and payment completed successfully',
      };
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  @override
  Future<List<BusBooking>> getBookings() async {
    try {
      // Get authentication token
      final token = await _authRepository.getToken();
      if (token == null) {
        return [];
      }

      // Send GET request to fetch bookings
      final response = await http.get(
        Uri.parse(ApiEndPoints.busBooking),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      // Check response status
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return [];
      }

      // Parse response
      final List<dynamic> bookingsList = json.decode(response.body);

      return bookingsList
          .map((booking) =>
              BusBookingDto.fromJson(booking as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
