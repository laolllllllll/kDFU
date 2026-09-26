import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.isOpaque = false
        webView.backgroundColor = .black
        
        // 禁用橡皮筋和滚动
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        
        view.addSubview(webView)
        
        // 加载本地HTML
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html"),
           let htmlDir = Bundle.main.resourcePath {
            let htmlURL = URL(fileURLWithPath: htmlPath)
            let baseURL = URL(fileURLWithPath: htmlDir, isDirectory: true)
            do {
                let htmlContent = try String(contentsOfFile: htmlPath, encoding: .utf8)
                webView.loadHTMLString(htmlContent, baseURL: baseURL)
            } catch {
                print("加载HTML失败: \(error)")
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
