import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ExpandableDescription extends StatefulWidget {
  final String text;
  final int collapsedLength;

  const ExpandableDescription({
    super.key,
    required this.text,
    this.collapsedLength = 140,
  });

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isLongText = widget.text.length > widget.collapsedLength;
    final displayText = (!_isExpanded && isLongText)
        ? '${widget.text.substring(0, widget.collapsedLength)}... '
        : '${widget.text} ';

    final actionLabel = _isExpanded ? 'Read less' : 'Read more';

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 14,
          height: 1.6,
          color: kGrey,
        ),
        children: [
          TextSpan(text: displayText),
          if (isLongText)
            TextSpan(
              text: actionLabel,
              style: const TextStyle(
                color: Color(0xFF00A64A),
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
            ),
        ],
      ),
    );
  }
}
