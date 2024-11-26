import 'package:flutter/material.dart';
import 'package:quranmemmorize_pkm/widgets/navigation.dart';
import 'package:intl/intl.dart';
import 'package:quranmemmorize_pkm/core/constant/app_colors.dart';

class Event {
  final String title;
  final String subtitle;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Event({
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
  });
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime selectedDate;
  late DateTime currentMonth;
  final Map<DateTime, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month);

    // Example events
    final date = DateTime(2024, 2, 24);
    events[date] = [
      Event(
        title: 'Ziyadah Quran',
        subtitle: '1 Halaman',
        startTime: const TimeOfDay(hour: 11, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
      ),
      Event(
        title: 'Murojaiah Hafalan',
        subtitle: '',
        startTime: const TimeOfDay(hour: 11, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            _buildCalendarCard(),
            const SizedBox(height: 16),
            _buildDateHeader(),
            Expanded(
              child: _buildTimelineEvents(),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColors.dashboardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCalendarHeader(),
                const SizedBox(height: 20),
                _buildCalendarDays(),
                const SizedBox(height: 20),
                _buildSetReminderButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            setState(() {
              currentMonth =
                  DateTime(currentMonth.year, currentMonth.month - 1);
            });
          },
        ),
        Text(
          DateFormat('MMMM').format(currentMonth).toLowerCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          onPressed: () {
            setState(() {
              currentMonth =
                  DateTime(currentMonth.year, currentMonth.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildCalendarDays() {
    final days = ['fri', 'sat', 'sun', 'mon', 'tue'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(5, (index) {
        final day = days[index];
        final date = currentMonth.add(Duration(days: index + 12));
        final isSelected = date.day == selectedDate.day;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Column(
            children: [
              Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSelected ? AppColors.primaryColor : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSetReminderButton() {
    return Container(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => _showAddEventDialog(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Set reminder',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          DateFormat('EEEE, d\'th\'').format(selectedDate),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.dashboardColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineEvents() {
    final dayEvents = events[DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day)] ??
        [];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 24, // 24 hours
      itemBuilder: (context, hour) {
        final currentEvents = dayEvents
            .where((event) =>
                event.startTime.hour <= hour && event.endTime.hour > hour)
            .toList();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  ...currentEvents.map((event) => _buildEventCard(event)),
                  Container(
                    height: 24,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: event.title == 'Ziyadah Quran'
          ? AppColors.dashboardSecondColor
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.dashboardColor,
              ),
            ),
            if (event.subtitle.isNotEmpty)
              Text(
                event.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            const SizedBox(height: 8),
            Text(
              '${event.startTime.format(context)} - ${event.endTime.format(context)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddEventDialog() async {
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime != null) {
      final TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(hours: 1)),
        ),
      );

      if (endTime != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Event'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Event Title'),
                  onSubmitted: (title) {
                    if (title.isNotEmpty) {
                      setState(() {
                        final date = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                        );
                        events[date] = [
                          ...events[date] ?? [],
                          Event(
                            title: title,
                            subtitle: '',
                            startTime: startTime,
                            endTime: endTime,
                          ),
                        ];
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
