import 'package:flutter/material.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/property/screens/property_list_screen.dart';
import 'features/property/screens/add_property_screen.dart';
import 'features/property/screens/edit_property_screen.dart';
import 'features/client/screens/client_list_screen.dart';
import 'features/viewing/screens/log_viewing_screen.dart';
import 'features/viewing/screens/viewing_history_screen.dart';
import 'features/appointment/screens/dashboard_screen.dart';
import 'features/appointment/screens/appointment_screen.dart';
import 'features/appointment/screens/profile_screen.dart';
import 'features/appointment/screens/settings_screen.dart';
import 'features/appointment/screens/activity_log_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String properties = '/properties';
  static const String addProperty = '/add-property';
  static const String editProperty = '/edit-property';
  static const String clients = '/clients';
  static const String logViewing = '/log-viewing';
  static const String viewingHistory = '/viewing-history';
  static const String appointments = '/appointments';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String activityLog = '/activity-log';

  static Map<String, WidgetBuilder> get routes => {
    initial: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    dashboard: (context) => const DashboardScreen(),
    properties: (context) => const PropertyListScreen(),
    addProperty: (context) => const AddPropertyScreen(),
    editProperty: (context) => const EditPropertyScreen(),
    clients: (context) => const ClientListScreen(),
    logViewing: (context) => const LogViewingScreen(),
    viewingHistory: (context) => const ViewingHistoryScreen(),
    appointments: (context) => const AppointmentScreen(),
    profile: (context) => const ProfileScreen(),
    settings: (context) => const SettingsScreen(),
    activityLog: (context) => const ActivityLogScreen(),
  };
}
