class SocialLink {
  final String platform;
  final String url;

  SocialLink({required this.platform, required this.url});
}

class Project {
  final String title;
  final String description;
  final String link;

  Project({required this.title, required this.description, required this.link});
}

class Portfolio {
  String name;
  String profilePhotoUrl;
  String bio;
  List<SocialLink> socialLinks;
  List<Project> projects;
  List<String> skills;

  Portfolio({
    required this.name,
    required this.profilePhotoUrl,
    required this.bio,
    required this.socialLinks,
    required this.projects,
    required this.skills,
  });

  // Factory method to create dummy data
  factory Portfolio.dummy() {
    return Portfolio(
      name: 'John Doe',
      profilePhotoUrl: 'https://i.pravatar.cc/150?img=3',
      bio: 'A passionate developer with experience in Flutter and web technologies.',
      socialLinks: [
        SocialLink(platform: 'GitHub', url: 'https://github.com/johndoe'),
        SocialLink(platform: 'LinkedIn', url: 'https://linkedin.com/in/johndoe'),
        SocialLink(platform: 'Twitter', url: 'https://twitter.com/johndoe'),
      ],
      projects: [
        Project(
          title: 'Portfolio Builder',
          description: 'A Flutter Web app to build portfolios easily.',
          link: 'https://github.com/johndoe/portfolio-builder',
        ),
        Project(
          title: 'Chat App',
          description: 'A real-time chat application using Firebase.',
          link: 'https://github.com/johndoe/chat-app',
        ),
      ],
      skills: ['Flutter', 'Dart', 'Firebase', 'UI/UX Design', 'JavaScript'],
    );
  }
}
