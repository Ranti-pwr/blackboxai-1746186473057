import 'package:flutter/material.dart';
import '../models/portfolio.dart';
import '../themes.dart';

class PortfolioProvider extends ChangeNotifier {
  Portfolio _portfolio = Portfolio.dummy();
  Portfolio get portfolio => _portfolio;

  ThemeType _currentTheme = ThemeType.minimalist;
  ThemeType get currentTheme => _currentTheme;

  ThemeData get currentThemeData {
    switch (_currentTheme) {
      case ThemeType.minimalist:
        return Themes.minimalistTheme;
      case ThemeType.dark:
        return Themes.darkTheme;
      case ThemeType.colorful:
        return Themes.colorfulTheme;
    }
  }

  void updateName(String name) {
    _portfolio.name = name;
    notifyListeners();
  }

  void updateProfilePhotoUrl(String url) {
    _portfolio.profilePhotoUrl = url;
    notifyListeners();
  }

  void updateBio(String bio) {
    _portfolio.bio = bio;
    notifyListeners();
  }

  void updateSocialLinks(List<SocialLink> links) {
    _portfolio.socialLinks = links;
    notifyListeners();
  }

  void updateProjects(List<Project> projects) {
    _portfolio.projects = projects;
    notifyListeners();
  }

  void updateSkills(List<String> skills) {
    _portfolio.skills = skills;
    notifyListeners();
  }

  void changeTheme(ThemeType theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
