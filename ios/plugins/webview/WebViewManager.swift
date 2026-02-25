import UIKit
import WebKit

class WebViewManager {

    static let shared = WebViewManager()

    private var webViewController: UIViewController?
    private var isVisible: Bool = false

    func open(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

    guard
        let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
        let window = windowScene.windows.first(where: { $0.isKeyWindow }),
        let rootVC = window.rootViewController
    else {
        print("RootViewController not found")
        return
    }
        }

        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen

        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.load(URLRequest(url: url))

        vc.view.backgroundColor = .white
        vc.view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor)
        ])

        // Close button
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)

        vc.view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -16)
        ])

        rootVC.present(vc, animated: true)

        webViewController = vc
        isVisible = true
    }

    @objc func close() {
        webViewController?.dismiss(animated: true)
        webViewController = nil
        isVisible = false
    }

    func is_webview_visible() -> Bool {
        return isVisible
    }
}
