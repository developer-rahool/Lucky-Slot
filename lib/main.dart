import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'firebase_options.dart';
import 'slot_screen.dart'; // Import the MyApp class from screen.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      const MyNewApp()); // Changed to MyNewApp to distinguish from MyApp in screen.dart
}

class MyNewApp extends StatelessWidget {
  const MyNewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lucky Slot',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        // Create an instance of MyApp defined in screen.dart
        debugShowCheckedModeBanner: false);
  }
}

//import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();

    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(onCoinsChange: _handleCoinsChange),
          ),
          (route) => false,
        );
      },
    );
  }

  int userCoins = 0;

  void _updateCoins(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins += amount;
      prefs.setInt('userCoins', userCoins);
    });
  }

  void _handleCoinsChange(int coins) {
    _updateCoins(coins);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Center(
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(
                  'assets/appLogo.png',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height *
                      0.4, // Adjust this value as needed
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBackground extends StatelessWidget {
  Widget child;

  CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/appBackground.jpg'))),
      child: child,
    );
  }
}
