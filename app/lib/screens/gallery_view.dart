import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../providers/app_provider.dart';
import 'image_viewer.dart';

class GalleryView extends ConsumerStatefulWidget {
  const GalleryView({super.key});

  @override
  ConsumerState<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends ConsumerState<GalleryView> {
  late AppProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = ref.watch(appProvider);
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          leading: const Icon(Icons.search_outlined),
          hintText: "Search for images...",
          onChanged: (value) => _provider.searchImages(value),
          onSubmitted: (value) => _provider.searchImages(value),
          // hintStyle: WidgetStatePropertyAll(Styles.brownActionText_15_400_4),
        ),
      ),
      body: _provider.loading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              child:
                  _provider.queryImages == null ||
                      _provider.queryImages!.isEmpty
                  ? const Center(child: Text("No images found"))
                  : _list(),
            ),
    );
  }

  _list() {
    var size = MediaQuery.of(context).size;
    if (size.width > 599) {
      var count = size.width ~/ 400;
      return _gridView(count);
    } else {
      return _listView();
    }
  }

  _listView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _provider.queryImages?.length,
      itemBuilder: (context, index) {
        final img = _provider.queryImages?[index];
        return ListTile(
          onTap: () {
            _provider.selectedImage = img;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ImageViewer()),
            );
          },
          leading: SizedBox(
            height: 70,
            width: 70,
            child: CachedNetworkImage(
              imageUrl: img?.previewUrl ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Text(
            img?.tags ?? "No Tags",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "By: ${img?.user ?? "Unknown"}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }

  _gridView(int count) {
    return MasonryGridView.count(
      crossAxisCount: count, // 2 columns
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      itemCount: _provider.queryImages?.length,
      itemBuilder: (context, index) {
        final img = _provider.queryImages?[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: img?.webformatUrl ?? "",
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}
