import 'package:citym/providers/auth_provider.dart';
import 'package:citym/providers/bus_schedules_provider.dart';
import 'package:citym/screens/auth/auth_wrapper.dart';
import 'package:citym/screens/bus_result/bus_result_screen.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:   [
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
    ),
    ChangeNotifierProvider(create: (_) => BusSchedulesProvider()),
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Ticket',
      debugShowCheckedModeBanner: false,
      theme: busBookingTheme,
      home: const AuthWrapper(),
      routes: {
        '/bus-result': (context) => const BusResultScreen(),
      },
    );
  }
}

