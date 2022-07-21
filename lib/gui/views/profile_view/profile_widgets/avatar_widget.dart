import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: ColorsAppTheme.greyAppPalette[100],
          backgroundImage: const NetworkImage(
            "https://api.time.com/wp-content/uploads/2018/12/square-meghan-markle-person-of-the-year-2018.jpg?quality=85",
          ),
          radius: 50,
        ),
        Positioned(
          top: 5,
          right: -2,
          child: GestureDetector(
            onTap: () => useNavigatePushName(context, 'edit_profile'),
            child: _icon(context),
          ),
        )
      ],
    );
  }

  Widget _icon(BuildContext context) => Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          Feather.edit_2,
          color: Theme.of(context).colorScheme.primary,
          size: 16,
        ),
      );
}
