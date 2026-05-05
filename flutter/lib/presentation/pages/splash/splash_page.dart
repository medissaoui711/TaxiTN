import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
    
    // Navigate after animation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Check if user is logged in, then navigate to home or login
        context.go('/home'); // For now, go to home
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
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '🚕',
                          style: TextStyle(fontSize: 60.sp),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 30.h),
                    
                    // App Name
                    Text(
                      'TaxiTN',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    
                    SizedBox(height: 10.h),
                    
                    // Tagline
                    Text(
                      'تطبيق كل شيء',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    
                    SizedBox(height: 60.h),
                    
                    // Loading indicator
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
