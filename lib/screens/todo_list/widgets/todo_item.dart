import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  const TodoItem({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.onDelete,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onComplete,
            child: Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
