import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/common/widgets/app_shimmer.dart';
import 'package:motorent_cons/common/widgets/inapp_webview_page.dart';
import 'package:motorent_cons/extensions/navigation_extension.dart';
import 'package:motorent_cons/features/home/domain/models/banner_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_banners.dart';

const _contentHeight = 200.0;

class PromotionBannersScreen extends ConsumerWidget {
  const PromotionBannersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllBannersProvider);

    return state.when(
      data: (data) => _BannersBody(data),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AppShimmer(height: _contentHeight, width: double.infinity),
        ),
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}

class _BannersBody extends ConsumerStatefulWidget {
  const _BannersBody(this.banners, {super.key});
  final List<PromotionBanner> banners;

  @override
  ConsumerState<_BannersBody> createState() => _BannersBodyState();
}

class _BannersBodyState extends ConsumerState<_BannersBody> {
  late final PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;

      if (_currentPage < widget.banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // kembali ke awal
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }
    if (widget.banners.length == 1) {
      return InkWell(
        onTap: () => _onTapBanner(widget.banners[0].url!),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            widget.banners[0].imageUrl!,
            height: _contentHeight,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => _onTapBanner(widget.banners[_currentPage].url!),
      child: SizedBox(
        height: _contentHeight,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: widget.banners.length,
              itemBuilder: (context, index) {
                final banner = widget.banners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      banner.imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 50),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.banners.asMap().entries.map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == entry.key ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == entry.key
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapBanner(String url) {
    if (url.isNotEmpty) {
      context.push(InAppWebViewPage(initialUrl: url, title: ""));
    }
  }
}
