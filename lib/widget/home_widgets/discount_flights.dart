import 'dart:math';

import 'package:flyro/export.dart';
import 'package:flyro/models/discount_flights_model.dart';

class DiscountFlightCard extends StatelessWidget {
  final DiscountFlight flight;
  final VoidCallback? onTap;

  const DiscountFlightCard({Key? key, required this.flight, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = 220.0;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: context.discountCardColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            height: cardHeight,
            child: Stack(
              children: [
                Padding(
                  padding: AppSizes.DEFAULT,
                  child: Column(
                    children: [
                      // Airline and Price row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (flight.airlineLogo != null)
                                SvgPicture.asset(
                                  flight.airlineLogo!,
                                  height: 24.0,
                                  width: 24.0,
                                  color: context.discountText,
                                ),
                              8.0.width,
                              MyText(
                                text: flight.airline,
                                size: 16.0,
                                weight: FontWeight.bold,
                                color: context.discountText,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: context.discountCardColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                MyText(
                                  text: 'Type',
                                  size: 14.0,
                                  weight: FontWeight.w400,
                                  color: context.discountSubtitle,
                                ),
                                MyText(
                                  text: flight.aircraftType,
                                  size: 18.0,
                                  weight: FontWeight.w500,
                                  color: context.discountText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      10.0.height,
                      // From and To codes with cities
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: flight.fromCode,
                                size: 28.0,
                                weight: FontWeight.w500,
                                color: context.discountText,
                              ),
                              MyText(
                                text: flight.fromCity,
                                size: 16.0,
                                weight: FontWeight.w400,
                                color: context.discountSubtitle,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container for dotted semi-circle and plane
                              SizedBox(
                                height: 50.0, // Increased height
                                width: 60.0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Dotted semi-circle at the top
                                    Positioned(
                                      top: 5, // Adjusted position
                                      child: CustomPaint(
                                        size: Size(50, 25), // Adjusted size
                                        painter: DottedSemiCirclePainter(
                                          color: context.primary,
                                        ),
                                      ),
                                    ),
                                    // Plane icon centered below the dots
                                    Positioned(
                                      top: 20, // Position below the dots
                                      child: SvgPicture.asset(
                                        Assets.airplaneforward,
                                        height: 30.0, // Smaller plane
                                        width: 30.0,
                                        color: context.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              4.0.height, // Reduced spacing
                              MyText(
                                text: flight.duration,
                                size: 14.0, // Smaller text
                                weight: FontWeight.w500,
                                color: context.discountSubtitle,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyText(
                                text: flight.toCode,
                                size: 28.0,
                                weight: FontWeight.w500,
                                color: context.discountText,
                              ),
                              MyText(
                                text: flight.toCity,
                                size: 16.0,
                                weight: FontWeight.w400,
                                color: context.discountSubtitle,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.calendarfilled,
                                    width: 18.0,
                                    height: 18.0,
                                    color: context.discountIcon,
                                  ),
                                  Gap(6.0),
                                  MyText(
                                    text: flight.dateTime,
                                    size: 16.0,
                                    weight: FontWeight.w500,
                                    color: context.discountSubtitle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyText(
                                text: "${flight.price}/per",
                                size: 16.0,
                                weight: FontWeight.w500,
                                color: context.discountSubtitle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Curved cutouts (same as FlightInfoCard)
                Positioned(
                  left: -15,
                  top: (cardHeight / 2) - 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.background,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -15,
                  top: (cardHeight / 2) - 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: (cardWidth / 2) - 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.background,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  left: (cardWidth / 2) - 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: context.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DottedSemiCirclePainter extends CustomPainter {
  final Color color;

  DottedSemiCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double radius = size.width / 2 - 2; // Smaller radius

    // Draw only top half of the circle (semi-circle from top)
    const int totalDots = 8; // Reduced dots for better spacing
    for (int i = 0; i < totalDots; i++) {
      // Draw dots from 12 o'clock to 12 o'clock (top half only)
      // Angle range: -10 degrees to 190 degrees to get a proper semi-circle
      final double angle = pi + (pi * i / (totalDots - 1));
      final double x = centerX + radius * cos(angle);
      final double y =
          radius + radius * sin(angle); // Adjusted for top position

      canvas.drawCircle(Offset(x, y), 2.0, paint);
    }
  }

  @override
  bool shouldRepaint(DottedSemiCirclePainter oldDelegate) =>
      color != oldDelegate.color;
}
