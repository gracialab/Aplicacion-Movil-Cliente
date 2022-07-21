import 'package:mr_fix/core/providers/legal_documents_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/core/providers/bottombar_provider.dart';

import 'address_provider.dart';

List<SingleChildWidget> storeProviders = [
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => AddressProvider()),
  ChangeNotifierProvider(create: (_) => PurchaseProvider()),
  ChangeNotifierProvider(create: (_) => BottomBarProvider()),
  ChangeNotifierProvider(create: (_) => LegalDocumentsProvider()),
];
