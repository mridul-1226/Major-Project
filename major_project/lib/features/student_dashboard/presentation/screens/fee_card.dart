import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'student_dashboard_screen.dart';

class FeeCard extends StatelessWidget {
  final String semester;

  const FeeCard({
    super.key,
    required this.semester,
  });

  Color _getFeeStatusColor(FeeStatus status) {
    switch (status) {
      case FeeStatus.lessThanFifty:
        return Colors.red;
      case FeeStatus.betweenFiftyAndNinety:
        return Colors.orange;
      case FeeStatus.complete:
        return Colors.green;
    }
  }

  String _getFeeStatusText(FeeStatus status) {
    switch (status) {
      case FeeStatus.lessThanFifty:
        return 'Less than 50% paid';
      case FeeStatus.betweenFiftyAndNinety:
        return '50-99% paid';
      case FeeStatus.complete:
        return 'Fully paid';
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    const FeeStatus currentStatus = FeeStatus.betweenFiftyAndNinety;

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1a237e).withOpacity(0.9),
            const Color(0xFF3949ab).withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  semester,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.school, color: Colors.white, size: 30),
              ],
            ),
          ),

          // Fee Status
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _getFeeStatusColor(currentStatus).withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _getFeeStatusColor(currentStatus),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: _getFeeStatusColor(currentStatus),
                ),
                const SizedBox(width: 10),
                Text(
                  _getFeeStatusText(currentStatus),
                  style: TextStyle(
                    color: _getFeeStatusColor(currentStatus),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Fee Details Button
                ElevatedButton(
                  onPressed: () => _launchURL(
                      'https://formbuilder.ccavenue.com/live/rec-sonbhadra'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1a237e),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description),
                      SizedBox(width: 8),
                      Text(
                        'View Fee Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Submit Fee Button
                ElevatedButton(
                  onPressed: () =>
                      _launchURL('https://fee-payment-website.com'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment),
                      SizedBox(width: 8),
                      Text(
                        'Pay Fee Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
