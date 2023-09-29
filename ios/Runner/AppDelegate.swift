import UIKit
import Flutter
import GoogleMaps  // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    // Need to get the API key from info.plist
    guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return false }
    guard let mySecretApiKey: String = infoDictionary["GoogleMapsApiKey"] as? String else { return false }
    GMSServices.provideAPIKey(mySecretApiKey)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}