import 'package:cleanapp/src/config/routes/app_routes.dart';
import 'package:cleanapp/src/config/themes/app_theme.dart';
import 'package:cleanapp/src/core/utils/constants.dart';
import 'package:cleanapp/src/persentation/provider/news_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:cleanapp/src/injection.dart' as di;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<NewsListNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kMaterialAppTitle,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        theme: AppTheme.light,
      ),
    );
  }
}
