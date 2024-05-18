import 'package:invitation/model/guest_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Provides services for launching URLs, specifically for WhatsApp.
class UrlLauncherServices {

  static UrlLauncherServices? _instance;

  /// Singleton instance of the [UrlLauncherServices] class.
  ///
  /// Ensures that only one instance of the class exists.
  UrlLauncherServices._internal();

  /// Creates a new instance of the [UrlLauncherServices] class.
  factory UrlLauncherServices.instanceFor() {
    return _instance ??= UrlLauncherServices._internal();
  }

  /// Gets the singleton instance of the [UrlLauncherServices] class.
  static UrlLauncherServices get instance {
    return UrlLauncherServices.instanceFor();
  }

  /// Launches the WhatsApp app and sends a message to the specified number.
  ///
  /// Returns a [Future<bool>] indicating whether the launch was successful.
  Future<bool> sendToWhatsApp([Guest? guest]) async {
    Guest g = guest??Guest(
      name: "",
      number: ""
    );
    // +91
    try {
      Uri uri = Uri(
        scheme: "https",
        host: "wa.me",
        path: "/+91${g.number}",
        queryParameters: {
          "text": '''
સ્નેહી શ્રી *${g.name??""}* 

Message.....
          '''
        },
      );
      return await launchUrl(uri);
    } catch (_) {
      return false;
    }
  }
}
