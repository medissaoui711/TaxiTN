class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://localhost:8080';
  static const String apiVersion = '/v1';
  static const String baseApiUrl = '$baseUrl$apiVersion';
  
  // Auth Endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh';
  
  // User Endpoints
  static const String getProfile = '/api/users/profile';
  static const String updateProfile = '/api/users/profile';
  
  // Driver Endpoints
  static const String registerDriver = '/api/drivers/register';
  static const String updateLocation = '/api/drivers/location';
  static const String setOnlineStatus = '/api/drivers/online';
  
  // Ride Endpoints
  static const String estimateRide = '/api/rides/estimate';
  static const String createRide = '/api/rides';
  static const String getRide = '/api/rides/{id}';
  static const String cancelRide = '/api/rides/{id}/cancel';
  
  // Order Endpoints
  static const String createOrder = '/api/orders';
  static const String getOrder = '/api/orders/{id}';
  
  // Restaurant Endpoints
  static const String listRestaurants = '/restaurants';
  static const String getRestaurant = '/restaurants/{id}';
  
  // Payment Endpoints
  static const String getPaymentMethods = '/api/payments/methods';
  static const String getWallet = '/api/payments/wallet';
  
  // WebSocket
  static const String wsUrl = 'ws://localhost:8080/v1/ws';
}

class AppConstants {
  // App Info
  static const String appName = 'TaxiTN';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';
  
  // Map Constants
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const double defaultZoom = 15.0;
  static const double defaultLat = 36.8065;  // Tunis
  static const double defaultLng = 10.1815;
  
  // Service Types
  static const List<Map<String, dynamic>> serviceTypes = [
    {
      'id': 'taxi',
      'name': 'Taxi',
      'icon': '🚕',
      'baseFare': 5.0,
      'perKmFare': 2.0,
    },
    {
      'id': 'go',
      'name': 'Go',
      'icon': '🚗',
      'baseFare': 4.0,
      'perKmFare': 1.5,
    },
    {
      'id': 'business',
      'name': 'Business',
      'icon': '🚙',
      'baseFare': 10.0,
      'perKmFare': 3.0,
    },
    {
      'id': 'max',
      'name': 'Max',
      'icon': '🚐',
      'baseFare': 8.0,
      'perKmFare': 2.5,
    },
  ];
}
