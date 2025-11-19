import 'package:flyro/core/navigation/navigate.dart';
import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/home/discount_flights_details.dart';
import 'package:flyro/models/discount_flights_model.dart';
import 'package:flyro/widget/home_widgets/discount_flights.dart';

class AllDiscountFlightsScreen extends StatelessWidget {
  final List<DiscountFlight> flights;

  const AllDiscountFlightsScreen({Key? key, required this.flights}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackground,
      appBar: AppBar(
        title: Text('All Discount Flights'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: AppSizes.DEFAULT,
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: DiscountFlightCard(
              flight: flight,
              onTap: () {
                // Navigate to details screen
                Navigate.to(
                  context: context,
                  page: DiscountFlightDetailsScreen(flight: flight),
                  transition: RouteTransition.rightToLeft,
                );
              },
            ),
          );
        },
      ),
    );
  }
}