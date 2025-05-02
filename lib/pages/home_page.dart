import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/portfolio_provider.dart';
import '../widgets/editor_form.dart';
import '../widgets/preview.dart';
import '../themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Builder'),
        actions: [
          PopupMenuButton<ThemeType>(
            onSelected: (theme) {
              provider.changeTheme(theme);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeType.minimalist,
                child: Text('Minimalist'),
              ),
              const PopupMenuItem(
                value: ThemeType.dark,
                child: Text('Dark Mode'),
              ),
              const PopupMenuItem(
                value: ThemeType.colorful,
                child: Text('Colorful'),
              ),
            ],
            icon: const Icon(Icons.palette),
            tooltip: 'Select Theme',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Desktop layout: side by side
            return Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: EditorForm(),
                  ),
                ),
                VerticalDivider(width: 1),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Preview(),
                  ),
                ),
              ],
            );
          } else {
            // Mobile layout: stacked
            return SingleChildScrollView(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: EditorForm(),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Preview(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
