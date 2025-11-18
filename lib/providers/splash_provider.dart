
import 'package:flyro/export.dart';
import 'package:flyro/features/screens/auth/signin_screen.dart';

class SplashProvider with ChangeNotifier {
  bool _showLoader = false;
  bool _isInitialized = false;
  Timer? _loaderTimer;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _logoFadeAnimation;

  bool get showLoader => _showLoader;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<double> get logoFadeAnimation => _logoFadeAnimation;

  void initializeAnimations(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeIn),
      ),
    );
    _animationController.forward();
  }

  Future<void> startSplashFlow(BuildContext context) async {
    if (_isInitialized) return;
    _isInitialized = true;

    _loaderTimer = Timer(const Duration(milliseconds: 1500), () {
      _showLoader = true;
      notifyListeners();
    });

    await Future.wait([
      Future.delayed(const Duration(milliseconds: 3500)),
      _initApp(),
    ]);

    _loaderTimer?.cancel();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void disposeProvider() {
    _loaderTimer?.cancel();
    _animationController.dispose();
  }
}
