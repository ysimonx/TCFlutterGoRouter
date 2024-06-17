import 'package:tc_serverside_plugin/events/TCCustomEvent.dart';
// import 'package:tc_serverside_plugin/events/TCLoginEvent.dart';
import 'package:tc_serverside_plugin/tc_serverside.dart';
import 'dart:io' show Platform;

class TC {
  TCServerside serverside = TCServerside();

  static int TC_SITE_ID = 0000; // defines this site account ID
  static int TC_PRIVACY_ID = 0; // defines this privacy ID
  static String sourceKey = "xxxxxxxxxxxxxxxxxxxx";

  TC() {
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        serverside.initServerSide(TC.TC_SITE_ID, TC.sourceKey);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> sendCustomEvent(
      {required String page_name,
      required String key,
      required dynamic value}) async {
    //  await serverside.enableRunningInBackground();
    // await serverside.enableServerSide();
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        Future<void>.delayed(
          const Duration(milliseconds: 10),
          () async {
            serverside.execute(makeTCCustomEvent(
                key: key, value: value, page_name: page_name));
          },
        );
      } catch (e) {
        print(e.toString());
      }
    }
    return;
  }

  static TCCustomEvent makeTCCustomEvent(
      {required String page_name,
      required String key,
      required dynamic value}) {
    var event = TCCustomEvent("custom_event");
    event.pageName = page_name;
    event.pageType = "event_page_type";
    if (value is int) {
      event.addAdditionalPropertyWithIntValue(key, value);
    }
    if (value is List) {
      event.addAdditionalPropertyWithListValue(key, value);
    }
    if (value is Map) {
      event.addAdditionalPropertyWithMapValue(key, value);
    }
    if (value is double) {
      event.addAdditionalPropertyWithDoubleValue(key, value);
    }
    if (value is bool) {
      event.addAdditionalPropertyWithBooleanValue(key, value);
    }
    if (value is String) {
      event.addAdditionalProperty(key, value);
    }
    event.addAdditionalProperty("test_code", "test_code_value");
    return event;
  }
}
