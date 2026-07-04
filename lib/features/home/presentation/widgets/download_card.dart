import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DownloadCard extends StatelessWidget {
  final String title;
  final String source;
  final String size;
  final String duration;
  final String imageUrl;

  const DownloadCard({
    super.key,
    required this.title,
    required this.source,
    required this.size,
    required this.duration,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceContainerHighest),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Image
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: 200,
            height: 300,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.surfaceContainerHigh,
              child: const Icon(Icons.image, color: AppColors.onSurfaceVariant),
            ),
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.background.withAlpha(230), // 0.9 * 255
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '$source • $size',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withAlpha(204), // 0.8 * 255
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(
                      color: AppColors.onSurface,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
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
