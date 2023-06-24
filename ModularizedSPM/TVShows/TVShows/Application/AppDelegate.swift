import UIKit
import TVShowsScreenModules
import TVShowsCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let wireframe = LoginWireframe()
        navigationController.setRootWireframe(wireframe)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}
