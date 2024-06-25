import 'package:flutter/material.dart';
import '/lesson.dart';
import '/lesson_section_card.dart';

class LessonDetailsPage extends StatefulWidget {
  final Lesson lesson;
  final Function updateProgress;
  final Map<String, dynamic>? progress; // Add progress argument

  const LessonDetailsPage({
    super.key,
    required this.lesson,
    required this.updateProgress,
    this.progress,
  });

  @override
  _LessonDetailsPageState createState() => _LessonDetailsPageState();
}

class _LessonDetailsPageState extends State<LessonDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.lesson.sections.length,
      vsync: this,
      initialIndex: 0, // Set initial index to 0 for the first section
    );

    // Automatically update the progress when the user navigates to a section
    _tabController.addListener(() {
      // Only update if the index has changed
      if (_tabController.index != _tabController.previousIndex) {
        final sectionTitle =
            widget.lesson.sections[_tabController.index].title;
        widget.updateProgress(
            widget.lesson.title, sectionTitle, 1.0);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text(widget.lesson.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          isScrollable: true, // Allow scrolling if tabs are too long
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // Rounded corners for the indicator
            color: Colors.deepPurpleAccent, // Customize the indicator color
          ),
          tabs: widget.lesson.sections
              .map((section) => Tab(text: section.title))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.lesson.sections.map((section) {
          return LessonSectionCard(
            section: section,
            updateProgress: (progress) => widget.updateProgress(
                widget.lesson.title, section.title, progress),
            progress: widget.progress?[section.title], // Pass progress for this section
          );
        }).toList(),
      ),
    );
  }
}