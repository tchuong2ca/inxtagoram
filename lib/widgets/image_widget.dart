import 'package:flutter/material.dart';

import '../res/images/images.dart';
class ImageWidget {
  static Widget imageNetwork(String? url, double? h, double w) {
    return Container(
      height: h,
      width: w,
      // ignore: unnecessary_null_comparison
      child: url == null
          ? Image.asset(
              Images.load_err,
              height: h,
              width: w,
              fit: BoxFit.cover,
            )
          : Image.network(
              url,
              height: h,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                  ),
                );
              },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image(
              image: AssetImage(Images.load_err),
              height: h, fit: BoxFit.cover,);
          }
            ),
    );
  }

  static Widget imageCover(String? url) {
    return Container(
      child: url == null
          ? Image.asset(
              Images.icCourseDefault,
              fit: BoxFit.cover,
            )
          : Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                  ),
                );
              },
            ),
    );
  }

  static Widget imageNetworkWrapWidth(String? url, double? h, double w) {
    return Container(
      // ignore: unnecessary_null_comparison
      child: url == null||url.isEmpty
          ? Image.asset(
        Images.load_err,
        fit: BoxFit.cover,
      )
          : Image.network(
        url,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
            ),
          );
        },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image(
              image: AssetImage(Images.load_err),
              fit: BoxFit.cover,);
          }
      ),
    );
  }

  static Widget imageNetworkNews(String? url, double? h, double? w) {
    return Container(
      height: h,
      width: w,
      // ignore: unnecessary_null_comparison
      child: url == null
          ? Image.asset(
        Images.icCourseDefault,
        height: h,
        width: w,
        fit: BoxFit.cover,
      )
          : Image.network(
          url,
          height: h,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
              ),
            );
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image(
              image: AssetImage(Images.ic_launcher),
              height: h, fit: BoxFit.cover,);
          },
      ),
    );
  }
}
