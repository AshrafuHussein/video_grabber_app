import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/extraction_bloc.dart';
import '../../../history/bloc/history_bloc.dart';
import '../widgets/download_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ExtractionBloc, ExtractionState>(
          listener: (context, state) {
            if (state is ExtractionSuccess) {
              context.push('/preview', extra: state.videoInfo);
            } else if (state is InstagramAuthRequired) {
              _showInstagramAuthDialog(context);
            } else if (state is ExtractionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is UnsupportedPlatform) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppColors.onSurface),
            onPressed: () {},
          ),
          title: Text(
            'GrabIt',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.onSurface),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      hintText: 'Paste a TikTok, Instagram, or X link here',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.content_paste, color: AppColors.onSurfaceVariant),
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data?.text != null) {
                          _urlController.text = data!.text!;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<ExtractionBloc, ExtractionState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: state is ExtractionLoading
                          ? null
                          : () {
                              if (_urlController.text.isNotEmpty) {
                                context.read<ExtractionBloc>().add(LinkPasted(_urlController.text));
                              }
                            },
                      icon: state is ExtractionLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.download),
                      label: Text(state is ExtractionLoading ? 'Extracting...' : 'Fetch Video'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSourceChip(Icons.tag, 'TikTok'),
                  const SizedBox(width: 8),
                  _buildSourceChip(Icons.photo_camera, 'Instagram'),
                  const SizedBox(width: 8),
                  _buildSourceChip(Icons.close, 'X'),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Downloads',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.onSurface,
                        ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/history'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, state) {
                    if (state is HistoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HistoryLoaded) {
                      if (state.history.isEmpty) {
                        return const Center(child: Text('No recent downloads'));
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.history.take(5).length,
                        separatorBuilder: (context, index) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final item = state.history[index];
                          return DownloadCard(
                            title: item.title,
                            source: item.platform.name.toUpperCase(),
                            size: '${(item.fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB',
                            duration: '00:00',
                            imageUrl: item.thumbnailUrl ?? '',
                          );
                        },
                      );
                    }
                    return const Center(child: Text('No recent downloads'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstagramAuthDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('Instagram requires you to be logged in to download this video. Would you like to login now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/instagram-login');
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
