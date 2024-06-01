import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medi_mate/constants.dart';
import 'package:medi_mate/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'global_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.request();
  await Permission.scheduleExactAlarm.request();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Pill Reminder',
          theme: ThemeData.dark().copyWith(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kScaffoldColor,
            appBarTheme: AppBarTheme(
              toolbarHeight: 7.h,
              backgroundColor: kScaffoldColor,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: kSecondaryColor,
                size: 20,
              ),
              titleTextStyle: GoogleFonts.mulish(
                color: kTextColor,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontSize: 16,
              ),
            ),
            textTheme: TextTheme(
              displaySmall: const TextStyle(
                fontSize: 28,
                color: kSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
              headlineMedium: GoogleFonts.aleo(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: kPrimaryColor,
              ),
              headlineSmall: GoogleFonts.aleo(
                fontSize: 16,
                color: kTextColor,
              ),
              titleLarge: GoogleFonts.aleo(
                fontSize: 14,
                color: kTextColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
              displayLarge: GoogleFonts.jimNightshade(
                fontSize: 35,
                color: kScaffoldColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
              titleMedium:
                  GoogleFonts.poppins(fontSize: 15, color: kPrimaryColor),
              titleSmall:
                  GoogleFonts.poppins(fontSize: 12, color: kTextLightColor),
              bodySmall: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: kTextColor,
              ),
              bodyMedium: GoogleFonts.aleo(
                fontSize: 12,
                color: kTextColor,
              ),
              bodyLarge: GoogleFonts.aleo(
                fontSize: 14,
                color: kTextColor,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      }),
    );
  }

  @override
  void dispose() {
    globalBloc!.dispose();
    super.dispose();
  }
}
