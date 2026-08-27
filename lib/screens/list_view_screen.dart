import 'package:flutter/material.dart';

// ============================================================
// HOME
// ============================================================

class DemoListAndGridViewScreen extends StatelessWidget {
  const DemoListAndGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DemoCard(
            icon: Icons.list,
            title: 'ListView',
            description: 'Danh sách item theo chiều dọc',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ListViewDemoScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _DemoCard(
            icon: Icons.grid_view,
            title: 'GridView',
            description: 'Danh sách item dạng lưới',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GridViewDemoScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          _DemoCard(
            icon: Icons.article,
            title: 'SingleChildScrollView',
            description: 'Scroll một nội dung lớn',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const SingleChildScrollViewDemoScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// 1. LIST VIEW
// ============================================================

class ListViewDemoScreen extends StatelessWidget {
  const ListViewDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      'Widget',
      'Layout',
      'Styling',
      'State',
      'Navigation',
      'API',
      'Storage',
      'Testing',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Demo'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = "${lessons[index]}1";

          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(lesson),
            subtitle: const Text('Flutter lesson'),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You selected: $lesson',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// 2. GRID VIEW
// ============================================================

class GridViewDemoScreen extends StatelessWidget {
  const GridViewDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      'Widget',
      'Layout',
      'Styling',
      'State',
      'Navigation',
      'API',
      'Storage',
      'Testing',
      'Animation',
      'Performance',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView Demo'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'You selected: ${lessons[index]}',
                    ),
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.book,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lessons[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// 3. SINGLE CHILD SCROLL VIEW
// ============================================================

class SingleChildScrollViewDemoScreen
    extends StatelessWidget {
  const SingleChildScrollViewDemoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SingleChildScrollView Demo',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutter',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Flutter is an open-source UI toolkit '
                  'for building applications.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'What is Flutter?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Flutter allows developers to build '
                  'applications for multiple platforms '
                  'using a single codebase.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Flutter Features',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _FeatureItem(
                      icon: Icons.speed,
                      text: 'Fast development',
                    ),
                    _FeatureItem(
                      icon: Icons.phone_android,
                      text: 'Cross-platform',
                    ),
                    _FeatureItem(
                      icon: Icons.refresh,
                      text: 'Hot reload',
                    ),
                    _FeatureItem(
                      icon: Icons.widgets,
                      text: 'Widget-based UI',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Why learn Flutter?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Flutter provides a reactive UI model. '
                  'The interface is constructed from widgets, '
                  'and widgets can be composed together to '
                  'build complex screens.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 500),

            const Center(
              child: Text(
                'End of content',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}