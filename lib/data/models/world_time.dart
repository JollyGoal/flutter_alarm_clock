import 'package:flutter/cupertino.dart';

import 'models.dart';

class WorldTime {
  final String location;
  final UtcOffset utcOffset;

  const WorldTime({
    @required this.location,
    @required this.utcOffset,
  });

  get name => location.split("/").last;
}
