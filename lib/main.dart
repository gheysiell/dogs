import 'package:dogs/core/navigation_service.dart';
import 'package:dogs/core/providers.dart';
import 'package:dogs/features/dogs/presentation/views/dogs_view.dart';
import 'package:dogs/core/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const Dogs());
  FlutterNativeSplash.remove();
}

class Dogs extends StatelessWidget {
  const Dogs({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Dogs',
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const DogsView(),
      ),
    );
  }
}
