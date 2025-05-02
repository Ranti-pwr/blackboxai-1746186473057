import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/portfolio.dart';
import '../providers/portfolio_provider.dart';

class EditorForm extends StatefulWidget {
  const EditorForm({Key? key}) : super(key: key);

  @override
  State<EditorForm> createState() => _EditorFormState();
}

class _EditorFormState extends State<EditorForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _profilePhotoController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final portfolio = context.read<PortfolioProvider>().portfolio;
    _nameController = TextEditingController(text: portfolio.name);
    _profilePhotoController = TextEditingController(text: portfolio.profilePhotoUrl);
    _bioController = TextEditingController(text: portfolio.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _profilePhotoController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PortfolioProvider>();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Basic Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => provider.updateName(value),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _profilePhotoController,
              decoration: const InputDecoration(labelText: 'Profile Photo URL'),
              onChanged: (value) => provider.updateProfilePhotoUrl(value),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: 'Bio'),
              maxLines: 3,
              onChanged: (value) => provider.updateBio(value),
            ),
            const SizedBox(height: 16),
            SocialLinksEditor(
              socialLinks: provider.portfolio.socialLinks,
              onChanged: (links) => provider.updateSocialLinks(links),
            ),
            const SizedBox(height: 16),
            ProjectsEditor(
              projects: provider.portfolio.projects,
              onChanged: (projects) => provider.updateProjects(projects),
            ),
            const SizedBox(height: 16),
            SkillsEditor(
              skills: provider.portfolio.skills,
              onChanged: (skills) => provider.updateSkills(skills),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialLinksEditor extends StatefulWidget {
  final List<SocialLink> socialLinks;
  final ValueChanged<List<SocialLink>> onChanged;

  const SocialLinksEditor({Key? key, required this.socialLinks, required this.onChanged}) : super(key: key);

  @override
  State<SocialLinksEditor> createState() => _SocialLinksEditorState();
}

class _SocialLinksEditorState extends State<SocialLinksEditor> {
  late List<SocialLink> _links;

  final _platformController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _links = List.from(widget.socialLinks);
  }

  @override
  void dispose() {
    _platformController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _addLink() {
    final platform = _platformController.text.trim();
    final url = _urlController.text.trim();
    if (platform.isNotEmpty && url.isNotEmpty) {
      setState(() {
        _links.add(SocialLink(platform: platform, url: url));
        widget.onChanged(_links);
        _platformController.clear();
        _urlController.clear();
      });
    }
  }

  void _removeLink(int index) {
    setState(() {
      _links.removeAt(index);
      widget.onChanged(_links);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Social Links', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._links.asMap().entries.map((entry) {
          final index = entry.key;
          final link = entry.value;
          return ListTile(
            title: Text('${link.platform}: ${link.url}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeLink(index),
            ),
          );
        }),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: _platformController,
                decoration: const InputDecoration(labelText: 'Platform'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addLink,
              tooltip: 'Add Social Link',
            ),
          ],
        ),
      ],
    );
  }
}

class ProjectsEditor extends StatefulWidget {
  final List<Project> projects;
  final ValueChanged<List<Project>> onChanged;

  const ProjectsEditor({Key? key, required this.projects, required this.onChanged}) : super(key: key);

  @override
  State<ProjectsEditor> createState() => _ProjectsEditorState();
}

class _ProjectsEditorState extends State<ProjectsEditor> {
  late List<Project> _projects;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _projects = List.from(widget.projects);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _addProject() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final link = _linkController.text.trim();
    if (title.isNotEmpty && description.isNotEmpty && link.isNotEmpty) {
      setState(() {
        _projects.add(Project(title: title, description: description, link: link));
        widget.onChanged(_projects);
        _titleController.clear();
        _descriptionController.clear();
        _linkController.clear();
      });
    }
  }

  void _removeProject(int index) {
    setState(() {
      _projects.removeAt(index);
      widget.onChanged(_projects);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;
          return ListTile(
            title: Text(project.title),
            subtitle: Text(project.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeProject(index),
            ),
          );
        }),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        TextField(
          controller: _linkController,
          decoration: const InputDecoration(labelText: 'Link'),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addProject,
            tooltip: 'Add Project',
          ),
        ),
      ],
    );
  }
}

class SkillsEditor extends StatefulWidget {
  final List<String> skills;
  final ValueChanged<List<String>> onChanged;

  const SkillsEditor({Key? key, required this.skills, required this.onChanged}) : super(key: key);

  @override
  State<SkillsEditor> createState() => _SkillsEditorState();
}

class _SkillsEditorState extends State<SkillsEditor> {
  late List<String> _skills;
  final _skillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _skills = List.from(widget.skills);
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty) {
      setState(() {
        _skills.add(skill);
        widget.onChanged(_skills);
        _skillController.clear();
      });
    }
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
      widget.onChanged(_skills);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return Chip(
              label: Text(skill),
              onDeleted: () => _removeSkill(index),
            );
          }).toList(),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _skillController,
                decoration: const InputDecoration(labelText: 'Add Skill'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addSkill,
              tooltip: 'Add Skill',
            ),
          ],
        ),
      ],
    );
  }
}
