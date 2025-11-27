import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/themes/app_colors.dart';

class MotorentDateTimePicker extends StatelessWidget {
  final String label;
  final DateTime? value;
  final String? error;
  final VoidCallback? onPick;
  final bool enabled;

  const MotorentDateTimePicker({
    super.key,
    required this.label,
    required this.value,
    required this.error,
    this.onPick,
    this.enabled = true,
  });

  String _formatDate(DateTime date) {
    final dayName = DateFormat('EEEE').format(date); // Senin
    final dateStr = DateFormat('d MMM yyyy').format(date); // 27 Jan 2025
    final timeStr = DateFormat('HH:mm').format(date); // 14:30

    return "$dayName, $dateStr • $timeStr";
  }

  @override
  Widget build(BuildContext context) {
    final displayText = value != null
        ? _formatDate(value!)
        : "Tap to select date & time";

    final isEmpty = value == null;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: enabled ? onPick : null,
      splashColor: Colors.blue.shade50,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.4,
            color: error != null ? Colors.red : Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LABEL
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            6.toHeightGap(),

            // MAIN ROW
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: isEmpty ? Colors.grey.shade400 : Colors.blue.shade700,
                ),
                10.toWidthGap(),

                Expanded(
                  child: Text(
                    displayText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isEmpty
                          ? Colors.grey.shade500
                          : Colors.grey.shade900,
                    ),
                  ),
                ),
              ],
            ),

            // ERROR MESSAGE
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  error!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
