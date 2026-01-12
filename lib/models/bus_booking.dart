class BusBooking {
  final int id;
  final String? passengerName;
  final String? passengerEmail;
  final String? passengerPhoneNumber;
  final int? numberOfSeats;
  final String? status;
  final DateTime? departureTime;
  final String? bus;
  final String? origin;
  final String? destination;
  final String? paymentStatus;
  final String? paymentAmount;
  final String? paymentMethod;

  BusBooking({
    required this.id,
    this.passengerName,
    this.passengerEmail,
    this.passengerPhoneNumber,
    this.numberOfSeats,
    this.status,
    this.departureTime,
    this.bus,
    this.origin,
    this.destination,
    this.paymentStatus,
    this.paymentAmount,
    this.paymentMethod,
  });

  
  BusBooking copyWith({
    int? id,
    String? passengerName,
    String? passengerEmail,
    String? passengerPhoneNumber,
    int? numberOfSeats,
    String? status,
    DateTime? departureTime,
    String? bus,
    String? origin,
    String? destination,
    String? paymentStatus,
    String? paymentAmount,
    String? paymentMethod,
  }) {
    return BusBooking(
      id: id ?? this.id,
      passengerName: passengerName ?? this.passengerName,
      passengerEmail: passengerEmail ?? this.passengerEmail,
      passengerPhoneNumber: passengerPhoneNumber ?? this.passengerPhoneNumber,
      numberOfSeats: numberOfSeats ?? this.numberOfSeats,
      status: status ?? this.status,
      departureTime: departureTime ?? this.departureTime,
      bus: bus ?? this.bus,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
