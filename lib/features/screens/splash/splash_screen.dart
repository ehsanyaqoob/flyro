
import 'package:flyro/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late SplashProvider provider;

  @override
  void initState() {
    super.initState();
    provider = SplashProvider();
    provider.initializeAnimations(this);
    provider.startSplashFlow(context);
  }

  @override
  void dispose() {
    provider.disposeProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<SplashProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: context.scaffoldBackground,
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: provider.scaleAnimation,
                          child: FadeTransition(
                            opacity: provider.logoFadeAnimation,
                            child: SvgPicture.asset(
                              Assets.flyro,
                              height: 150,
                              color: ThemeColors.buttonBackground(context),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: provider.fadeAnimation,
                          child: MyText(
                            text: "flyro",
                            color: context.text,
                            size: 30,
                            weight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 40,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedOpacity(
                            opacity: provider.showLoader ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: FlyroLoader(size: 40.0, dotSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (kDebugMode)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Consumer<ThemeProvider>(
                        builder: (_, theme, __) {
                          return InkWell(
                            onTap: theme.toggleTheme,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: context.card,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Icon(
                                context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                                color: context.icon,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
