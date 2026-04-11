import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../constants/theme.dart';

class VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String subtitle;
  final String emoji;

  const VideoPlayerDialog({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.subtitle,
    required this.emoji,
  });

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _videoCtrl;
  ChewieController?          _chewieCtrl;
  bool                       _loading = true;
  String?                    _error;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      _videoCtrl = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await _videoCtrl.initialize();

      _chewieCtrl = ChewieController(
        videoPlayerController: _videoCtrl,
        autoPlay:              true,
        looping:               false,
        allowFullScreen:       true,
        allowMuting:           true,
        showControlsOnInitialize: true,
        materialProgressColors: ChewieProgressColors(
          playedColor:     AppColors.gold,
          handleColor:     AppColors.gold,
          backgroundColor: Colors.white24,
          bufferedColor:   Colors.white38,
        ),
        placeholder: Container(color: Colors.black),
        errorBuilder: (context, errorMessage) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  color: Colors.white54, size: 40),
              const SizedBox(height: 10),
              Text(
                'Could not load video',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54, fontSize: 14),
              ),
            ],
          ),
        ),
      );

      if (mounted) setState(() => _loading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _error   = 'Failed to load video. Check your connection.';
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoCtrl.dispose();
    _chewieCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w        = MediaQuery.of(context).size.width;
    final h        = MediaQuery.of(context).size.height;
    final isMobile = w < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8  : w * 0.08,
        vertical:   isMobile ? 20 : 40,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth:  900,
          maxHeight: h * 0.92,
        ),
        decoration: BoxDecoration(
          color:        const Color(0xFF0D1B2E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // ── Header ──────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 14 : 20, 16,
                isMobile ? 10 : 14, 0,
              ),
              child: Row(
                children: [
                  Text(widget.emoji,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize:   isMobile ? 14 : 17,
                            fontWeight: FontWeight.w700,
                            color:      Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.subtitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color:    AppColors.gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Close button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white60, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Divider(
                color: Colors.white.withOpacity(0.08), height: 1),
            const SizedBox(height: 8),

            // ── Video Player ─────────────────────────────────────
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 9 / 16, // portrait for mobile recordings
                  child: _loading
                      ? _buildLoader()
                      : _error != null
                      ? _buildError()
                      : Chewie(controller: _chewieCtrl!),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color:       AppColors.gold,
            strokeWidth: 2.5,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading video...',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38, fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded,
              color: Colors.white24, size: 44),
          const SizedBox(height: 12),
          Text(
            _error!,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white38, fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}