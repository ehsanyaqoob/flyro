import 'package:flyro/export.dart';
import 'package:flyro/models/discount_flights_model.dart';

class DiscountFlightDetailsScreen extends StatelessWidget {
  final DiscountFlight flight;

  const DiscountFlightDetailsScreen({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackground,
      appBar: AppBar(
        title: Text('Flight Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSizes.DEFAULT,
        child: Column(
          children: [
            // Add your flight details UI here
            Text('Flight Details for ${flight.airline}'),
            // ... more details
          ],
        ),
      ),
    );
  }
}