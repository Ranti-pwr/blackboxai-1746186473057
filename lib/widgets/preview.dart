import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/portfolio_provider.dart';

class Preview extends StatelessWidget {
  const Preview({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<PortfolioProvider>().portfolio;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Column(
          key: ValueKey(portfolio.name + portfolio.bio),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(portfolio.profilePhotoUrl),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                portfolio.name,
                style: theme.textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                portfolio.bio,
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            if (portfolio.socialLinks.isNotEmpty) ...[
              Text('Social Links', style: theme.textTheme.headline6),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: portfolio.socialLinks.map((link) {
                  return ActionChip(
                    label: Text(link.platform),
                    onPressed: () => _launchUrl(link.url),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            if (portfolio.projects.isNotEmpty) ...[
              Text('Projects', style: theme.textTheme.headline6),
              const SizedBox(height: 8),
              Column(
                children: portfolio.projects.map((project) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(project.title),
                      subtitle: Text(project.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _launchUrl(project.link),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            if (portfolio.skills.isNotEmpty) ...[
              Text('Skills', style: theme.textTheme.headline6),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: portfolio.skills.map((skill) {
                  return Chip(label: Text(skill));
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
