import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(LoadHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download History'),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.records.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final record = state.records[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  tileColor: AppColors.surfaceContainer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  leading: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                      image: record.thumbnailUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(record.thumbnailUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: record.thumbnailUrl.isEmpty
                        ? const Icon(Icons.movie, color: AppColors.primary)
                        : null,
                  ),
                  title: Text(
                    record.title,
                    style: const TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${record.platform.name.toUpperCase()} • ${(record.fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB • ${DateFormat('yyyy-MM-dd').format(record.downloadedAt)}',
                    style: const TextStyle(color: AppColors.onSurfaceVariant),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.error),
                    onPressed: () {
                      context.read<HistoryBloc>().add(DeleteRecord(record.id));
                    },
                  ),
                );
              },
            );
          } else if (state is HistoryEmpty) {
            return const Center(child: Text('No downloads yet'));
          } else if (state is HistoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
