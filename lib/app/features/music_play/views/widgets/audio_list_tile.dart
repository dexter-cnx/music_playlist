import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../models/play_list_model.dart';

class AudioListTitle extends StatelessWidget {
  final AudioItem item;
  final Function onTap;
  final double imageSize;
  final double iconSize;
  final Color? backgroundColor;
  final Color? playIconColor;
  final Icon? playIcon;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  const AudioListTitle({super.key,
    required this.item,
    required this.onTap,
    this.imageSize = 52,
    this.iconSize = 30,
    this.playIconColor,
    this.playIcon,
    this.titleStyle,
    this.subTitleStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap(),
      child: Container(
        color: backgroundColor ?? Colors.white,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: imageFromSource(item.image,size: imageSize),
          ),
          title: Text(
            item.title,style: titleStyle ?? theme.textTheme.titleSmall,),
          subtitle: Text(
            style: subTitleStyle ?? theme.textTheme.bodySmall,
            item.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: Icon(
                Icons.list,
                size: iconSize,
                color: Colors.grey.shade400
            ),
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}
