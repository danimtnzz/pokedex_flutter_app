import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:pokedex_flutter_app/config/provider/provider_setup.dart';
import 'package:pokedex_flutter_app/config/theme/providers/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'config/config.dart';
import 'domain/entities/captured_pokemon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
  }
  Hive.registerAdapter(CapturedPokemonAdapter());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, _) {
          return MaterialApp.router(
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
            title: 'Pokedex App',
            theme: AppTheme().getTheme(themeNotifier.themeColor),
          );
        },
      ),
    );
  }
}
