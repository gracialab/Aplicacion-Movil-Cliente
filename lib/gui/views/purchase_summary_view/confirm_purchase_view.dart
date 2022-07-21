import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/paths/local_paths.dart';
import 'package:mr_fix/gui/views/purchase_summary_view/purshase_summary.controller.dart';

class ConfirmPurchase extends StatelessWidget {
  const ConfirmPurchase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, padding.top, 25, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              LocalAppPaths.lottieDone,
              alignment: Alignment.center,
              width: 250,
              height: 250,
              fit: BoxFit.fill,
              repeat: true,
              animate: true,
            ),
            const SizedBox(height: 30),
            Text(
              "Tu servicio ha sido agendado, esta atento a recibir un mensaje con la información del experto que te atenderá.",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, (padding.bottom + 15)),
        child: ButtonWidget(
          label: "Volver al inicio",
          onTap: () => PurshaseSummaryController(context).redirectPage('main'),
        ),
      ),
    );
  }
}
