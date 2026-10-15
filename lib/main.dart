import 'package:flutter/material.dart';

void main() {
  runApp(const KomaliPortfolio());
}

class KomaliPortfolio extends StatelessWidget {
  const KomaliPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komali Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100E19),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB38AFF),
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  static const purple = Color(0xFFB38AFF);
  static const muted = Color(0xFFAAA5B8);

  String selectedSection = 'Home';

  final List<String> sections = const [
    'Home',
    'About Me',
    'Skills',
    'Education',
    'Projects',
    'Contact',
  ];

  void openSection(String section) {
    setState(() {
      selectedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wideScreen = MediaQuery.sizeOf(context).width >= 760;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: wideScreen ? 40 : 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  _buildNavigation(wideScreen),
                  const SizedBox(height: 24),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _buildCurrentPage(wideScreen),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation(bool wideScreen) {
    return Row(
      children: [
        const Text(
          'K.',
          style: TextStyle(
            color: purple,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'KOMALI',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const Spacer(),
        if (wideScreen)
          Wrap(
            spacing: 4,
            children: sections.map(_navigationButton).toList(),
          )
        else
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: openSection,
            itemBuilder: (context) => sections
                .map(
                  (section) => PopupMenuItem<String>(
                    value: section,
                    child: Text(section),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _navigationButton(String section) {
    final isSelected = selectedSection == section;

    return TextButton(
      onPressed: () => openSection(section),
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? purple : muted,
      ),
      child: Text(
        section,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildCurrentPage(bool wideScreen) {
    switch (selectedSection) {
      case 'About Me':
        return _aboutPage();
      case 'Skills':
        return _skillsPage();
      case 'Education':
        return _educationPage();
      case 'Projects':
        return _projectsPage();
      case 'Contact':
        return _contactPage();
      default:
        return _homePage(wideScreen);
    }
  }

  Widget _homePage(bool wideScreen) {
    final photo = Container(
      width: wideScreen ? 300 : 220,
      height: wideScreen ? 350 : 260,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF211B30),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: purple.withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: purple.withValues(alpha: 0.15),
            blurRadius: 40,
          ),
        ],
      ),
      child: Image.asset(
        'assets/profile.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.person, size: 100, color: purple),
        ),
      ),
    );

    final introduction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'HELLO, I’M KOMALI',
          style: TextStyle(
            color: purple,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Data Science Student\nDeveloper & Learner',
          style: TextStyle(
            fontSize: wideScreen ? 42 : 34,
            height: 1.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Welcome to my portfolio. Explore my background, skills, education, '
          'and projects using the buttons above.',
          style: TextStyle(color: muted, fontSize: 16, height: 1.7),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => openSection('About Me'),
              icon: const Icon(Icons.person_outline),
              label: const Text('About me'),
              style: FilledButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: const Color(0xFF171020),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => openSection('Projects'),
              icon: const Icon(Icons.work_outline),
              label: const Text('View projects'),
            ),
          ],
        ),
      ],
    );

    return SingleChildScrollView(
      key: const ValueKey('Home'),
      child: Container(
        constraints: const BoxConstraints(minHeight: 500),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF1B1727), Color(0xFF12101A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: wideScreen
            ? Row(
                children: [
                  Expanded(child: introduction),
                  const SizedBox(width: 36),
                  photo,
                ],
              )
            : Column(
                children: [
                  photo,
                  const SizedBox(height: 30),
                  introduction,
                ],
              ),
      ),
    );
  }

  Widget _aboutPage() {
    return _sectionPage(
      'About Me',
      [
        const Text(
          'Hello! I’m Komali, a B.Tech Computer Science student specializing '
          'in Data Science. I enjoy learning new technologies, solving '
          'problems, and building projects that can be useful in the real world.',
          style: TextStyle(color: muted, fontSize: 17, height: 1.8),
        ),
        const SizedBox(height: 24),
        _detailCard('My focus', 'Data Science, software development, and learning'),
        const SizedBox(height: 14),
        _detailCard('My goal', 'To keep growing as a developer and contribute to meaningful projects'),
      ],
    );
  }

  Widget _skillsPage() {
    const skills = [
      'Python',
      'Java',
      'SQL',
      'Data Science',
      'Flutter and Dart',
      'Git and GitHub',
      'HTML and CSS',
      'OCR',
      'Natural Language Processing (NLP)',
    ];

    return _sectionPage(
      'Skills',
      [
        const Text(
          'Technologies and topics I have worked with:',
          style: TextStyle(color: muted, fontSize: 16),
        ),
        const SizedBox(height: 20),
        ...skills.map(
          (skill) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: purple,
                  size: 21,
                ),
                const SizedBox(width: 12),
                Text(skill, style: const TextStyle(fontSize: 17)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _educationPage() {
    return _sectionPage(
      'Education',
      [
        _detailCard(
          'B.Tech in Computer Science (Data Science)',
          'Malineni Lakshmaiaha Engineering College\nCGPA: 8.8 / 10',
        ),
        const SizedBox(height: 16),
        _detailCard(
          'Intermediate',
          'Bhavana Junior College\nScore: 9.26',
        ),
      ],
    );
  }

  Widget _projectsPage() {
    return _sectionPage(
      'Projects',
      [
        _detailCard(
          'Crop Monitoring System Using Plant Scanning',
          'A project focused on crop monitoring through plant scanning.',
        ),
        const SizedBox(height: 16),
        _detailCard(
          'Intelligent Data Capture Schedule Linking Layer',
          'A hackathon project involving OCR, NLP, intelligent data capture, '
              'and schedule linking for infrastructure.',
        ),
      ],
    );
  }

  Widget _contactPage() {
    return _sectionPage(
      'Contact',
      [
        const Text(
          'I’d be happy to connect about projects, learning, or opportunities.',
          style: TextStyle(color: muted, fontSize: 16, height: 1.7),
        ),
        const SizedBox(height: 22),
        _contactLine(Icons.email_outlined, 'komu@gmail.com'),
        _contactLine(Icons.phone_outlined, 'Add your phone number'),
        _contactLine(Icons.link_rounded, 'Add your GitHub profile'),
        const SizedBox(height: 10),
        const Text(
          'Replace the sample email and contact details with your real information before sharing.',
          style: TextStyle(color: muted, fontSize: 12),
        ),
      ],
    );
  }

  Widget _sectionPage(String title, List<Widget> content) {
    return SingleChildScrollView(
      key: ValueKey(title),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xFF191622),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 24),
            ...content,
          ],
        ),
      ),
    );
  }

  Widget _detailCard(String title, String detail) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF211B30),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            detail,
            style: const TextStyle(color: muted, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _contactLine(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: purple),
          const SizedBox(width: 12),
          Flexible(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}