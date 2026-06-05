import 'package:flutter/material.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/hero_section.dart';
import '../components/animated_background.dart';
import '../widgets/certification_section.dart';
import '../widgets/services_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _certKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _active = 'Home';
  final double _navHeight = 76;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final double anchor = _navHeight + 8;
    String best = _active;
    double bestTop = double.infinity;

    final items = <_SectionRef>[
      _SectionRef('Home', _homeKey),
      _SectionRef('Certification', _certKey),
      _SectionRef('Services', _servicesKey),
      _SectionRef('Projects', _projectsKey),
      _SectionRef('About', _contactKey),
    ];

    for (final item in items) {
      final ctx = item.key.currentContext;
      final box = ctx?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;

      final top = box.localToGlobal(Offset.zero).dy;
      final delta = (top - anchor).abs();
      if (top <= anchor + 60 && delta < bestTop) {
        bestTop = delta;
        best = item.id;
      }
    }

    if (best != _active) setState(() => _active = best);
  }

  void _scrollTo(String sectionId) {
    if (!_scrollController.hasClients) return;

    GlobalKey targetKey;
    switch (sectionId) {
      case 'Home':
        targetKey = _homeKey;
        break;
      case 'Certification':
        targetKey = _certKey;
        break;
      case 'Services':
        targetKey = _servicesKey;
        break;
      case 'Projects':
        targetKey = _projectsKey;
        break;
      case 'About':
      case 'contact':
        targetKey = _contactKey;
        break;
      default:
        return;
    }

    final ctx = targetKey.currentContext;
    final box = ctx?.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final top = box.localToGlobal(Offset.zero).dy;
    final current = _scrollController.offset;
    final target = (current + top) - (_navHeight + 12);

    _scrollController.animateTo(
      target.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          Positioned.fill(child: IgnorePointer(child: Container(color: Colors.black.withOpacity(0.28)))),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavBarDelegate(
                  minExtent: 64,
                  maxExtent: _navHeight,
                  child: NavigationBarWidget(
                    onNavigate: _scrollTo,
                    activeSection: _active,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _Section(
                          key: _homeKey,
                          child: HeroSection(
                            linkedinUrl: 'https://www.linkedin.com/in/taha-saqib-821154334/',
                            onViewMyWork: () => _scrollTo('Projects'),
                            onContact: () => _scrollTo('About'),
                          ),
                        ),
                        const SizedBox(height: 60),
                        _Section(key: _certKey, child: const CertificationSection()),
                        const SizedBox(height: 60),
                        _Section(key: _servicesKey, child: const ServicesSection()),
                        const SizedBox(height: 60),
                        _Section(key: _projectsKey, child: const ProjectsSection()),
                        const SizedBox(height: 60),
                        _Section(key: _contactKey, child: const ContactSection()),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionRef {
  final String id;
  final GlobalKey key;
  const _SectionRef(this.id, this.key);
}

class _Section extends StatelessWidget {
  final Widget child;
  const _Section({required Key key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) => child;
}

class _NavBarDelegate extends SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final Widget child;
  const _NavBarDelegate({required this.minExtent, required this.maxExtent, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 6), color: Colors.transparent, child: child);
  }

  @override
  bool shouldRebuild(covariant _NavBarDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.child != child;
  }
}