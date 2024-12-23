import 'package:dogs/core/navigation_service.dart';
import 'package:dogs/core/providers.dart';
import 'package:dogs/features/dogs/presentation/views/dogs_view.dart';
import 'package:dogs/core/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const Dogs());
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
