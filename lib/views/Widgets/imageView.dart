import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/AppImages.dart';

class CachedImageView extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  const CachedImageView({ super.key, required this.imageUrl,  this.fit = BoxFit.contain,});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        height:  double.infinity,
        width:  double.infinity,
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) =>
            Center(
                child: Container()
            ),
        // errorWidget: (context, url, error) =>
        //     Center(
        //       child: Image.asset(
        //         height: 30,
        //         width: 30,
        //         fit: fit,
        //         AppImages.noImage,
        //       ),
        //     ),
        errorWidget:  (context, url, error){
          print('image_error $error');
          return Center(
            child: Image.asset(
              fit: fit,
              AppImages.noImage,
            ),
          );
        },
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        placeholderFadeInDuration: Duration.zero,
        // useOldImageOnUrlChange: true,
      );
    }else{
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            fit: fit,
            AppImages.noImage,
          ),
        ),
      );
    }
  }
}

