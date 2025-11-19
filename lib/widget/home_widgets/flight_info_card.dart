import 'package:flyro/export.dart';

class FlightInfoCard extends StatelessWidget {
  final String fromCode;
  final String toCode;
  final String fromCity;
  final String toCity;
  final String departureTime;
  final String arrivalTime;
  final String date;

  const FlightInfoCard({
    Key? key,
    required this.fromCode,
    required this.toCode,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = 230.0; 

        return Container(
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(30.0),
          ),
          height: cardHeight,
          child: Stack(
            children: [
              Padding(
                padding: AppSizes.DEFAULT,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: fromCode,
                              size: 28.0,
                              weight: FontWeight.w500,
                            ),
                            MyText(
                              text: fromCity,
                              size: 16.0,
                              weight: FontWeight.w400,
                              color: context.subtitle.withOpacity(0.6),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MyText(
                              text: toCode,
                              size: 28.0,
                              weight: FontWeight.w500,
                            ),
                            MyText(
                              text: toCity,
                              size: 16.0,
                              weight: FontWeight.w400,
                              color: context.subtitle.withOpacity(0.6),
                            ),
                          ],
                        ),
                      ],
                    ),
                    12.0.height,
                    // Dotted line with plane icon
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Left dotted line
                                Positioned(
                                  left: 30,
                                  top: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                     width: 100,
                                    child: CustomPaint(
                                      painter: DottedLinePainter(
                                        color: context.subtitle.withOpacity(0.5),
                                      ),
                                      size: Size(100, 40),
                                    ),
                                  ),
                                ),
                                // Right dotted line
                                Positioned(
                                  right: 30,
                                  top: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    width: 100,
                                    child: CustomPaint(
                                      painter: DottedLinePainter(
                                        color: context.subtitle.withOpacity(0.5),
                                      ),
                                      size: Size(100, 40),
                                    ),
                                  ),
                                ),
                                // Circle dot on left
                                Positioned(
                                  left: 2,
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: context.subtitle.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // Circle dot on right
                                Positioned(
                                  right: 2,
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: context.subtitle.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // Plane icon in center
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: context.card,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      Assets.airplane,
                                      height: 40.0,
                                      width: 40.0,
                                      color: context.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    12.0.height,
                    // Time and date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: departureTime,
                              size: 18.0,
                              weight: FontWeight.w500,
                              
                            ),
                            MyText(
                              text: date,
                              size: 16.0,
                              weight: FontWeight.w400,
                              color: context.subtitle.withOpacity(0.6),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MyText(
                              text: arrivalTime,
                              size: 18.0,
                              weight: FontWeight.w500,
                            ),
                            MyText(
                              text: date,
                              size: 16.0,
                              weight: FontWeight.w400,
                              color: context.subtitle.withOpacity(0.6),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Curved cutout - LEFT (middle height)
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
              // Curved cutout - RIGHT (middle height)
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
              // Curved cutout - TOP (middle width)
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
              // Curved cutout - BOTTOM (middle width)
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
        );
      },
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DottedLinePainter oldDelegate) => color != oldDelegate.color;
}