import 'package:flutter/material.dart';
import 'package:mr_fix/gui/views/custom_alert_rating_service/custom_alert_rating_service_view.dart';
import 'package:mr_fix/gui/views/map_view/map_view.dart';
import 'package:mr_fix/gui/templates/main_template.dart';
import 'package:mr_fix/gui/views/login_view/login_view.dart';
import 'package:mr_fix/gui/views/profile_view/profile_view.dart';
import 'package:mr_fix/gui/views/register_view/register_view.dart';
import 'package:mr_fix/gui/views/add_cards_view/add_cards_view.dart';
import 'package:mr_fix/gui/views/list_cards_view/list_cards_view.dart';
import 'package:mr_fix/gui/views/help_center_view/help_center_view.dart';
import 'package:mr_fix/gui/views/list_address_view/list_address_view.dart';
import 'package:mr_fix/gui/views/edit_profile_view/edit_profile_view.dart';
import 'package:mr_fix/gui/views/legal_document_view/legal_docu_view.dart';
import 'package:mr_fix/gui/views/notifications_view/notification_view.dart';
import 'package:mr_fix/gui/views/dynamic_rates_view/dynamic_rates_view.dart';
import 'package:mr_fix/gui/views/search_address_view/search_address_view.dart';
import 'package:mr_fix/gui/views/confirm_address_view/confirm_address_view.dart';
import 'package:mr_fix/gui/views/purchase_summary_view/purchase_summary_view.dart';
import 'package:mr_fix/gui/views/purchase_summary_view/confirm_purchase_view.dart';
import 'package:mr_fix/gui/views/password_recovery_view/password_recovery_view.dart';
import 'package:mr_fix/gui/views/confirm_init_service_view/confirm_init_service_view.dart';
import 'package:mr_fix/gui/views/information_documents_or_help_view/documents_or_help_view.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routesMap = {
      '/': MaterialPageRoute(
        builder: (_) => const LoginView(),
      ),
      'passRecovery': MaterialPageRoute(
        builder: (_) => const PasswordRecoeryView(),
      ),
      'register': MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
      'main': MaterialPageRoute(
        builder: (_) => const MainTemplate(),
      ),
      'profile': MaterialPageRoute(
        builder: (_) => const ProfileView(),
      ),
      'listAddress': MaterialPageRoute(
        builder: (_) => const ListAddressView(),
        settings: settings,
      ),
      'addCards': MaterialPageRoute(
        builder: (_) => const AddCardsView(),
      ),
      'alertDialogRating': MaterialPageRoute(
        builder: (_) => const CustomAlertModalRating(),
      ),
      'legalDocuments': MaterialPageRoute(
        builder: (_) => const DocumentsOrHelpView(),
      ),
      'dynamicRates': MaterialPageRoute(
        builder: (_) => const DynamicRatesView(),
      ),
      'purchaseSummary': MaterialPageRoute(
        builder: (_) => const PurshaseSummaryView(),
      ),
      'confirmAddress': MaterialPageRoute(
        builder: (_) => const ConfirmAddressView(),
      ),
      'searchAddress': MaterialPageRoute(
        builder: (_) => const SearchAddress(),
      ),
      'notifications': MaterialPageRoute(
        builder: (_) => const NotificationView(),
      ),
      'legal_document': MaterialPageRoute(
        builder: (_) => const LegalDocumentView(),
      ),
      'help_center': MaterialPageRoute(
        builder: (_) => const HelpCenterView(),
      ),
      'list_card_credtis': MaterialPageRoute(
        builder: (_) => const ListCreditsCards(),
      ),
      'map_view': MaterialPageRoute(
        builder: (_) => const MapView(),
      ),
      'edit_profile': MaterialPageRoute(
        builder: (_) => const EditProfile(),
      ),
      'confirm_purchase': MaterialPageRoute(
        builder: (_) => const ConfirmPurchase(),
      ),
      'confirm_init_service': MaterialPageRoute(
        builder: (_) => const ConfirmInitService(),
      ),
    };

    return routesMap[settings.name!] ?? routesMap['/']!;
  }
}
