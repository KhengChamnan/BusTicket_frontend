import 'package:flutter/material.dart';

class BusLoadingAnimation extends StatefulWidget {
  const BusLoadingAnimation({super.key});

  @override
  State<BusLoadingAnimation> createState() => _BusLoadingAnimationState();
}

class _BusLoadingAnimationState extends State<BusLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  // Road
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Dashed line on road
                  Positioned(
                    bottom: 21,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: Size(screenWidth, 2),
                      painter: DashedLinePainter(
                        offset: _animation.value * screenWidth,
                      ),
                    ),
                  ),
                  // Bus
                  Positioned(
                    left: screenWidth / 2 + (_animation.value * screenWidth / 2) - 30,
                    bottom: 24,
                    child: child!,
                  ),
                ],
              );
            },
            child: _buildBus(),
          ),
        ),
        const Text(
          'Loading...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBus() {
    return SizedBox(
      width: 60,
      height: 40,
      child: CustomPaint(
        painter: BusPainter(),
      ),
    );
  }
}

class BusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Bus body
    paint.color = Colors.blue[700]!;
    final bodyRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(5, 5, size.width - 10, size.height - 15),
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
      bottomLeft: const Radius.circular(4),
      bottomRight: const Radius.circular(4),
    );
    canvas.drawRRect(bodyRect, paint);

    // Windows
    paint.color = Colors.lightBlue[100]!;
    // Front window
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(size.width - 14, 9, 6, 8),
        topRight: const Radius.circular(4),
      ),
      paint,
    );
    // Side windows
    canvas.drawRect(Rect.fromLTWH(10, 9, 8, 8), paint);
    canvas.drawRect(Rect.fromLTWH(22, 9, 8, 8), paint);

    // Wheels
    paint.color = Colors.grey[800]!;
    canvas.drawCircle(Offset(15, size.height - 5), 5, paint);
    canvas.drawCircle(Offset(size.width - 15, size.height - 5), 5, paint);

    // Wheel rims
    paint.color = Colors.grey[400]!;
    canvas.drawCircle(Offset(15, size.height - 5), 2.5, paint);
    canvas.drawCircle(Offset(size.width - 15, size.height - 5), 2.5, paint);

    // Headlight
    paint.color = Colors.yellow[300]!;
    canvas.drawCircle(Offset(size.width - 8, size.height - 12), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedLinePainter extends CustomPainter {
  final double offset;

  DashedLinePainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 10.0;
    const dashSpace = 8.0;
    double startX = offset % (dashWidth + dashSpace);

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => offset != oldDelegate.offset;
}
