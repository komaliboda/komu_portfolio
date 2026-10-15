import 'package:flutter/material.dart';

void main() => runApp(const VishnuPortfolio());

class VishnuPortfolio extends StatelessWidget {
  const VishnuPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vishnupriya Boda | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F5F1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7655A6),
          brightness: Brightness.light,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  static const purple = Color(0xFF7655A6);
  static const ink = Color(0xFF292536);
  static const muted = Color(0xFF706C79);

  String currentPage = 'Profile';

  final pages = const [
    'Profile',
    'Education',
    'Projects',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 760;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 36 : 18,
                vertical: 20,
              ),
              child: Column(
                children: [
                  _header(wide),
                  const SizedBox(height: 22),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: currentPage == 'Profile'
                          ? _profilePage(wide)
                          : _detailsPage(currentPage),
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

  Widget _header(bool wide) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 21,
          backgroundColor: purple,
          child: Text(
            'V',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(width: 11),
        const Text(
          'VISHNUPRIYA BODA',
          style: TextStyle(
            color: ink,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        if (wide)
          Wrap(
            spacing: 4,
            children: pages.map(_navButton).toList(),
          )
        else
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded, color: ink),
            onSelected: (page) => setState(() => currentPage = page),
            itemBuilder: (context) => pages
                .map((page) => PopupMenuItem(value: page, child: Text(page)))
                .toList(),
          ),
      ],
    );
  }

  Widget _navButton(String page) {
    final selected = page == currentPage;

    return TextButton(
      onPressed: () => setState(() => currentPage = page),
      style: TextButton.styleFrom(
        foregroundColor: selected ? purple : muted,
      ),
      child: Text(
        page,
        style: TextStyle(fontWeight: selected ? FontWeight.bold : null),
      ),
    );
  }

  Widget _profilePage(bool wide) {
    return SingleChildScrollView(
      key: const ValueKey('Profile'),
      child: Column(
        children: [
          _profileCard(wide),
          const SizedBox(height: 20),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _aboutCard()),
                const SizedBox(width: 20),
                Expanded(child: _skillsCard()),
              ],
            )
          else ...[
            _aboutCard(),
            const SizedBox(height: 16),
            _skillsCard(),
          ],
        ],
      ),
    );
  }

  Widget _profileCard(bool wide) {
    final photo = Container(
      width: wide ? 230 : 190,
      height: wide ? 260 : 220,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE9E1F2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: purple.withValues(alpha: 0.2), width: 2),
      ),
      child: Image.asset(
        'assets/profile.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.person_rounded,
          size: 100,
          color: purple,
        ),
      ),
    );

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'HELLO, I’M',
          style: TextStyle(
            color: purple,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Vishnupriya Boda',
          style: TextStyle(
            color: ink,
            fontSize: wide ? 40 : 32,
            height: 1.12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Data Science Student  •  Developer  •  Learner',
          style: TextStyle(color: muted, fontSize: 16),
        ),
        const SizedBox(height: 18),
        const Text(
          'I enjoy learning technology, solving problems, and creating useful projects.',
          style: TextStyle(color: muted, height: 1.6, fontSize: 15),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: () => setState(() => currentPage = 'Projects'),
              icon: const Icon(Icons.work_outline_rounded),
              label: const Text('View projects'),
              style: FilledButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => setState(() => currentPage = 'Contact'),
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text('Contact'),
              style: OutlinedButton.styleFrom(foregroundColor: purple),
            ),
          ],
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: wide
          ? Row(
              children: [
                photo,
                const SizedBox(width: 32),
                Expanded(child: intro),
              ],
            )
          : Column(
              children: [
                photo,
                const SizedBox(height: 24),
                intro,
              ],
            ),
    );
  }

  Widget _aboutCard() {
    return _card(
      title: 'About Me',
      child: const Text(
        'I’m pursuing a B.Tech in Computer Science with a focus on Data Science. '
        'I’m interested in software development, data, and learning how technology '
        'can solve real-world problems.',
        style: TextStyle(color: muted, height: 1.75, fontSize: 15),
      ),
    );
  }

  Widget _skillsCard() {
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

    return _card(
      title: 'Skills',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skills
            .map(
              (skill) => Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: purple,
                      size: 19,
                    ),
                    const SizedBox(width: 10),
                    Text(skill, style: const TextStyle(color: ink, fontSize: 15)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _detailsPage(String page) {
    late String title;
    late List<Widget> content;

    switch (page) {
      case 'Education':
        title = 'Education';
        content = [
          _infoTile(
            'B.Tech in Computer Science (Data Science)',
            'Malineni Lakshmaiaha Engineering College\nCGPA: 8.8 / 10',
          ),
          const SizedBox(height: 14),
          _infoTile(
            'Intermediate',
            'Bhavana Junior College\nScore: 9.26',
          ),
        ];
      case 'Projects':
        title = 'Projects';
        content = [
          _infoTile(
            'Crop Monitoring System Using Plant Scanning',
            'A project focused on crop monitoring through plant scanning.',
          ),
          const SizedBox(height: 14),
          _infoTile(
            'Intelligent Data Capture Schedule Linking Layer',
            'Hackathon project involving OCR, NLP, intelligent data capture, '
                'and schedule linking for infrastructure.',
          ),
        ];
      default:
        title = 'Contact';
        content = [
          const Text(
            'I’d be happy to connect about projects, learning, or opportunities.',
            style: TextStyle(color: muted, height: 1.7),
          ),
          const SizedBox(height: 18),
          const _ContactLine(
            icon: Icons.email_outlined,
            value: 'vishnu@123',
          ),
          const SizedBox(height: 12),
          const _ContactLine(
            icon: Icons.phone_outlined,
            value: 'Add your phone number',
          ),
          const SizedBox(height: 12),
          const _ContactLine(
            icon: Icons.link_rounded,
            value: 'Add your GitHub profile',
          ),
        ];
    }

    return SingleChildScrollView(
      key: ValueKey(page),
      child: _card(
        title: title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ink.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ink,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _infoTile(String title, String detail) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F0F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ink,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(detail, style: const TextStyle(color: muted, height: 1.6)),
        ],
      ),
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 0), // Keeps this row layout simple.
        Icon(icon, color: const Color(0xFF7655A6)),
        const SizedBox(width: 12),
        Text(value, style: const TextStyle(color: Color(0xFF292536))),
      ],
    );
  }
}