class BusSchedules {
  final int id;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double seatPrice;
  final int availableSeats;
  final String status;
  final Bus bus;
  final Route route;

  BusSchedules({
    required this.id,
    required this.departureTime,
    required this.arrivalTime,
    required this.seatPrice,
    required this.availableSeats,
    required this.status,
    required this.bus,
    required this.route,
  });

  
}

class Bus {
  final String plateNumber;
  final int capacity;

  Bus({
    required this.plateNumber,
    required this.capacity,
  });

}

class Route {
  final int id;
  final String origin;
  final String destination;

  Route({
    required this.id,
    required this.origin,
    required this.destination,
  });

  
}
