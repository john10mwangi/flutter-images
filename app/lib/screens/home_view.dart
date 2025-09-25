import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../providers/app_provider.dart';
import 'image_viewer.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late AppProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = ref.read(appProvider);
    _provider.fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    _provider = ref.watch(appProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Trending Pixabay Images")),
      body: _provider.loading
          ? const Center(child: CircularProgressIndicator())
          : _list(),
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
      itemCount: _provider.images?.length,
      itemBuilder: (context, index) {
        final img = _provider.images?[index];
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
      itemCount: _provider.images?.length,
      itemBuilder: (context, index) {
        final img = _provider.images?[index];
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
