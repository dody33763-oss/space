import 'package:flutter/material.dart';
import 'dart:async';
import '../theme/app_theme.dart';
import 'quran/quran_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // التوجيه التلقائي إلى شاشة القرآن الكريم الرئيسية بعد 3 ثوانٍ
    Timer(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const QuranHomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 700),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF072919),
                Color(0xFF0F5132),
                Color(0xFF146C43),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // دوائر زخرفية خلفية
              Positioned(
                top: -80,
                right: -80,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.accentGold.withOpacity(0.06),
                  ),
                ),
              ),
              Positioned(
                bottom: -100,
                left: -100,
                child: Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.accentGold.withOpacity(0.05),
                  ),
                ),
              ),

              // اللوجو والعنوان
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // أيقونة اللوجو الشريفة
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06),
                          border: Border.all(
                            color: AppTheme.accentGold,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accentGold.withOpacity(0.35),
                              blurRadius: 30,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accentGold,
                          ),
                          child: const Icon(
                            Icons.menu_book_rounded,
                            size: 68,
                            color: Color(0xFF0F5132),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // اسم التطبيق
                      const Text(
                        "الْقُرْآنُ الْكَرِيمُ",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentGold,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset(0, 3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // الوصف أو العبارة
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppTheme.accentGold.withOpacity(0.3),
                          ),
                        ),
                        child: const Text(
                          "تِلاَوَةٌ • فَهْرَسُ السُّوَرِ • قِرَاءَةٌ مبَارَكَةٌ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // مؤشر التحميل
                      const SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentGold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // التذييل
              Positioned(
                bottom: 25,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    "تطبيق القرآن الكريم • جميع الحقوق محفوظة",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
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
