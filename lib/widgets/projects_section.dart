import 'package:flutter/material.dart';
import '../components/custom_badge.dart';
// ignore: unused_import
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your real data/images
    final projects = const [
      Project(
        tag: 'Mobile Application',
        title: 'Weekly Meal Plans for Hostel Students',
        desc: 'Flutter app with auth, payments, and admin panel.',
        imageAsset: 'assets/images/project_food.png',
      ),
      Project(
        tag: 'Web Site',
        title: 'Apptopus',
        desc: 'Marketing site with responsive design and content CMS.',
        imageAsset: 'assets/images/project_business.png',
      ),
      Project(
        tag: 'Mobile Application',
        title: 'Finance Tracker',
        desc: 'Cross‑platform Finance with real‑time tracking.',
        imageAsset: 'assets/images/project_finance.png',
      ),
      
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 20.0;
        int columns = 3;
        if (constraints.maxWidth < 1100) columns = 2;
        if (constraints.maxWidth < 760) columns = 1;

        final itemWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Featured Projects', style: AppTextStyles.sectionTitle),
            const SizedBox(height: 16),
            Text('Some of my recent work', style: AppTextStyles.subtitle),
            const SizedBox(height: 28),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: projects
                  .map((p) => ProjectCard(project: p, width: itemWidth))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class Project {
  final String tag;
  final String title;
  final String desc;
  final String imageAsset;
  const Project({
    required this.tag,
    required this.title,
    required this.desc,
    required this.imageAsset,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final double width;
  const ProjectCard({super.key, required this.project, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // Clip children so badges/images can’t overflow and overlap the next card
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // let content define height (prevents vertical overflow)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image block with fixed aspect ratio – avoids tall images pushing into next card
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                project.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.black12),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Use a non-positioned badge; no absolute overlays
                const SizedBox(height: 4),
                CustomBadge(
                  label: project.tag,
                  variant: BadgeVariant.filled,
                  uppercase: false,
                ),
                const SizedBox(height: 12),

                Text(project.title, style: AppTextStyles.cardTitle),
                const SizedBox(height: 8),

                Text(
                  project.desc,
                  style: AppTextStyles.body.copyWith(color: Colors.white70),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    // CustomButton(
                    //   label: 'Details',
                    //   variant: ButtonVariant.primary,
                    //   icon: const Icon(LucideIcons.info, color: Colors.black),
                    //   onPressed: () {},
                    // ),
                    // const SizedBox(width: 12),
                    // CustomButton(
                    //   label: 'Visit',
                    //   variant: ButtonVariant.outline,
                    //   icon: const Icon(LucideIcons.link, color: primaryYellow),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}