import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PttButton extends StatefulWidget {
  final bool isRecording;
  final bool isLoading;
  final Color color;
  final VoidCallback onPressStart;
  final VoidCallback onPressEnd;
  final String languageName;
  final String nativeScript;

  const PttButton({
    super.key,
    required this.isRecording,
    required this.isLoading,
    required this.color,
    required this.onPressStart,
    required this.onPressEnd,
    required this.languageName,
    required this.nativeScript,
  });

  @override
  State<PttButton> createState() => _PttButtonState();
}

class _PttButtonState extends State<PttButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool active = widget.isRecording;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pulse rings behind the button
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (active)
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (_, __) => Transform.scale(
                    scale: _pulseAnim.value,
                    child: Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
              if (active)
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (_, __) => Transform.scale(
                    scale: _pulseAnim.value * 1.15,
                    child: Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withOpacity(0.07),
                      ),
                    ),
                  ),
                ),
              // Main button
              GestureDetector(
                onLongPressStart: (_) => widget.onPressStart(),
                onLongPressEnd: (_) => widget.onPressEnd(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: active ? 95 : 85,
                  height: active ? 95 : 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        widget.color.withOpacity(0.95),
                        widget.color.withOpacity(0.6),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(active ? 0.7 : 0.35),
                        blurRadius: active ? 28 : 14,
                        spreadRadius: active ? 6 : 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: widget.isLoading
                        ? SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 2.5,
                            ),
                          )
                        : Icon(
                            active ? Icons.mic : Icons.mic_none,
                            color: Colors.white,
                            size: 36,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          active ? '● RECORDING – Release to translate' : 'Hold to speak',
          style: GoogleFonts.outfit(
            color: active ? widget.color : Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          widget.nativeScript,
          style: GoogleFonts.notoSans(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
