import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'providers/portfolio_provider.dart';
import 'pages/home_page.dart';
import 'themes.dart';

void main() {
  runApp(const PortfolioBuilderApp());
}

class PortfolioBuilderApp extends StatelessWidget {
  const PortfolioBuilderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PortfolioProvider(),
      child: Consumer<PortfolioProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'Portfolio Builder',
            theme: provider.currentThemeData,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            textTheme: GoogleFonts.openSansTextTheme(
              Theme.of(context).textTheme,
            ),
          );
        },
      ),
    );
  }
}
