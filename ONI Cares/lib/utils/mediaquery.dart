import 'package:flutter/material.dart';

class MediaQueryUtils {
  MediaQueryData _mediaQueryData;

  MediaQueryUtils(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  Size get size {
    return _mediaQueryData.size;
  }

  get height {
    return this.size.height;
  }

  get width {
    return this.size.width;
  }
}
