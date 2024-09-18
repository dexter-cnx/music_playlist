import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../models/play_list_model.dart';

class PlaylistListTitle extends StatelessWidget {
  final PlayList item;
  final Function onTap;
  final Function onPlay;
  final double imageSize;
  final double playIconSize;
  final Color? playIconColor;
  final Icon? playIcon;
  const PlaylistListTitle({super.key,
    required this.item,
    required this.onTap,
    required this.onPlay,
    this.imageSize = 52,
    this.playIconSize = 30,
    this.playIconColor,
    this.playIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap(),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: imageFromSource(item.image,size: imageSize),
        ),
        title: Text(item.title,style: theme.textTheme.titleSmall,),
        subtitle: Text(
          style: theme.textTheme.bodySmall,
          item.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: playIcon ?? Icon(
              Icons.play_circle_outline,
              size: playIconSize,
              color: playIconColor ?? Colors.grey.shade400
          ),
          onPressed: () => onPlay(),
        ),
      ),
    );
  }
}
