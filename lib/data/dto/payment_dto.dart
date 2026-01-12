class PaymentDto {
  static Map<String, dynamic> toJson({
    required int bookingId,
    required String paymentMethod,
  }) {
    return {
      'payment': {
        'booking_id': bookingId,
        'payment_method': paymentMethod,
      }
    };
  }
}
