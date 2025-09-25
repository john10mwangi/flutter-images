import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_provider.dart';

class ImageViewer extends ConsumerStatefulWidget {
  const ImageViewer({super.key});

  @override
  ConsumerState<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends ConsumerState<ImageViewer> {
  late AppProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = ref.watch(appProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Image Viewer")),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.person),
          //   onPressed: () {
          //     // Implement download functionality
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.share),
          //   onPressed: () {
          //     // Implement share functionality
          //   },
          // ),
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: _provider.selectedImage?.largeImageUrl ?? "",
          placeholder: (context, url) =>
              const CircularProgressIndicator(), // Placeholder while loading
          errorWidget: (context, url, error) =>
              const Icon(Icons.error), // Error widget
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
