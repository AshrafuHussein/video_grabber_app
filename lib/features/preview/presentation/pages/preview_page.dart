import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../../../domain/entities/video_info.dart';
import '../../bloc/preview_bloc.dart';
import '../../../../core/theme/app_colors.dart';

class PreviewPage extends StatefulWidget {
  final VideoInfo videoInfo;

  const PreviewPage({super.key, required this.videoInfo});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoInfo.directUrl),
      httpHeaders: widget.videoInfo.httpHeaders,
    )..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.play();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: BlocConsumer<PreviewBloc, PreviewState>(
        listener: (context, state) {
          if (state is DownloadComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Download Complete')),
            );
          } else if (state is DownloadFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Download Failed: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (_controller.value.isInitialized)
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(_controller),
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 64,
                            color: Colors.white.withAlpha(128),
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying ? _controller.pause() : _controller.play();
                            });
                          },
                        ),
                      ],
                    ),
                  )
                else
                  const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.videoInfo.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Platform: ${widget.videoInfo.platform.name.toUpperCase()}',
                        style: const TextStyle(color: AppColors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 24),
                      if (state is Downloading)
                        Column(
                          children: [
                            LinearProgressIndicator(value: state.progress),
                            const SizedBox(height: 8),
                            Text('${(state.progress * 100).toInt()}%'),
                          ],
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              context.read<PreviewBloc>().add(DownloadRequested(widget.videoInfo));
                            },
                            icon: const Icon(Icons.download),
                            label: const Text('Download to Gallery'),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
