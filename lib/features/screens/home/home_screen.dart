import 'package:flyro/core/navigation/navigate.dart';
import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/home/all_discount_flights.dart';
import 'package:flyro/features/screens/home/discount_flights_details.dart';
import 'package:flyro/features/screens/home/menu_screen.dart';
import 'package:flyro/features/screens/home/search_screen.dart';
import 'package:flyro/models/discount_flights_model.dart';
import 'package:flyro/widget/home_widgets/ai_greetings.dart';
import 'package:flyro/widget/home_widgets/discount_flights.dart';
import 'package:flyro/widget/home_widgets/flight_info_card.dart';
import 'package:flyro/widget/home_widgets/home_header.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _lastPressed;
  final List<DiscountFlight> _discountFlights = [];

  @override
  void initState() {
    super.initState();
    _discountFlights.addAll(
      discountFlightDataJson.map((json) => DiscountFlight.fromJson(json)),
    );
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      AppToast.show("Press back again to exit", context);
      return false;
    }
    SystemNavigator.pop();
    return true;
  }

  void _handleFlightTap(DiscountFlight flight) {
    Navigate.to(
      context: context,
      page: DiscountFlightDetailsScreen(flight: flight),
      transition: RouteTransition.rightToLeft,
    );
  }

  void _handleSeeMoreTap() {
    Navigate.to(
      context: context,
      page: AllDiscountFlightsScreen(flights: _discountFlights),
      transition: RouteTransition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: context.scaffoldBackground,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: AppSizes.DEFAULT,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(
                        onMenuTap: () {
                          Navigate.to(
                            context: context,
                            page: const MenuScreen(),
                            transition: RouteTransition.leftToRight,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        onSearchTap: () {
                          Navigate.to(
                            context: context,
                            page: const SearchScreen(),
                            transition: RouteTransition.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      36.0.height,
                      const AIGreetingsSection(),
                      16.0.height,
                      FlightInfoCard(
                        fromCode: 'LHR',
                        toCode: 'JFK',
                        fromCity: 'London',
                        toCity: 'New York',
                        departureTime: '10:15 AM',
                        arrivalTime: '12:15 PM',
                        date: 'Sat, 26 Sep',
                      ),
                      16.0.height,
                      MyButton(
                        buttonText:
                            'Search Flights (${discountFlightDataJson.length})',
                        onTap: () {
                          Navigate.to(
                            context: context,
                            page: const SearchScreen(),
                            transition: RouteTransition.rightToLeft,
                          );
                        },
                      ),
                      16.0.height,
                      Row(
                        children: [
                          MyText(
                            text: 'Discount Flights',
                            color: context.text,
                            size: 22.0,
                            weight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Bounce(
                            onTap: _handleSeeMoreTap, // Updated to use navigation
                            child: MyText(
                              text: 'See more',
                              color: context.primary,
                              size: 14.0,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      16.0.height,
                    ],
                  ),
                ),
              ),
              // Discount Flights List using SliverList
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.DEFAULT.left),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final flight = _discountFlights[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DiscountFlightCard(
                          flight: flight,
                          onTap: () => _handleFlightTap(flight), // Added onTap
                        ),
                      );
                    },
                    childCount: _discountFlights.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}