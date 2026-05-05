import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/register_page.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/ride/ride_booking_page.dart';
import '../../presentation/pages/ride/ride_tracking_page.dart';
import '../../presentation/pages/order/order_page.dart';
import '../../presentation/pages/restaurant/restaurants_page.dart';
import '../../presentation/pages/profile/profile_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Splash
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Auth
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      
      // Home
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      
      // Ride
      GoRoute(
        path: '/ride/booking',
        builder: (context, state) => const RideBookingPage(),
      ),
      GoRoute(
        path: '/ride/tracking/:id',
        builder: (context, state) => RideTrackingPage(
          rideId: state.pathParameters['id']!,
        ),
      ),
      
      // Order
      GoRoute(
        path: '/order',
        builder: (context, state) => const OrderPage(),
      ),
      
      // Restaurants
      GoRoute(
        path: '/restaurants',
        builder: (context, state) => const RestaurantsPage(),
      ),
      
      // Profile
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error?.message ?? "Page not found"}'),
      ),
    ),
  );
}
