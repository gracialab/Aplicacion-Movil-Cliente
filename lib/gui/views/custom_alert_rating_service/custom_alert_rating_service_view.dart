import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/gui/views/custom_alert_rating_service/custom_alert_rating_service_controller.dart';
import 'package:mr_fix/gui/views/custom_alert_rating_service/alert_rating_service_widget/title_modal_rating.dart';

class CustomAlertModalRating extends StatefulWidget {
  const CustomAlertModalRating({
    Key? key,
    this.onTap,
    this.title,
    this.imageExpert,
    this.description = "Describe tu Experiencia",
  }) : super(key: key);

  final String? title;
  final String description;
  final String? imageExpert;
  final void Function()? onTap;

  @override
  State<CustomAlertModalRating> createState() => _CustomAlertModalRatingState();
}

class _CustomAlertModalRatingState extends State<CustomAlertModalRating> {
  double rating = 0;
  late CustomALertRatingServiceController controller;
  @override
  void initState() {
    controller = CustomALertRatingServiceController(context)..fieldController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleModalRating(title: widget.title!),
          const SizedBox(height: 15),
          CircleAvatar(
            backgroundColor: ColorsAppTheme.greyAppPalette[100],
            backgroundImage: NetworkImage(
              widget.imageExpert!,
            ),
            radius: 60,
          ),
          const SizedBox(height: 10),
          buildRating(),
          const SizedBox(height: 15),
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormInput(
            hintText: "",
            controller: controller.fieldController,
          ),
          const SizedBox(height: 15),
          ButtonWidget(
            label: "Calificar",
            onTap: () {
              useNavigatePop(context);
              widget.onTap!.call();
            },
          ),
        ],
      ),
    );
  }

  Widget buildRating() => RatingBar.builder(
        initialRating: 2,
        minRating: 1,
        allowHalfRating: true,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) => setState(() {
          this.rating = rating;
        }),
        updateOnDrag: true,
      );
}
