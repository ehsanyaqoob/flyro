import 'package:flyro/export.dart';

class AIGreetingsSection extends StatelessWidget {
  final String? userName;

  const AIGreetingsSection({Key? key, this.userName = 'Jone'})
    : super(key: key);

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  String _getGreetingEmoji() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return '🌅';
    } else if (hour >= 12 && hour < 17) {
      return '☀️';
    } else if (hour >= 17 && hour < 21) {
      return '🌆';
    } else {
      return '🌙';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dynamic greeting with emoji based on time of day
        Row(
          children: [
            MyText(
              text: '${_getGreeting()} , $userName! ',
              size: 18.0,
              weight: FontWeight.w500,
              color: context.text,
            ),
            MyText(
              text: _getGreetingEmoji(),
              size: 18.0,
              weight: FontWeight.w500,
            ),
          ],
        ),
        12.0.height,
        // Main heading
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'How Can I Assist You\nBooking ',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                  color: context.subtitle.withOpacity(0.6),
                ),
              ),
              TextSpan(
                text: 'Your Trip ?',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w500,
                  color: context.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
