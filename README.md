# ZSRouteUtil-Objc

[![Version](https://img.shields.io/cocoapods/v/ZSRouteUtil-Objc.svg?style=flat)](https://cocoapods.org/pods/ZSRouteUtil-Objc)
[![License](https://img.shields.io/cocoapods/l/ZSRouteUtil-Objc.svg?style=flat)](https://cocoapods.org/pods/ZSRouteUtil-Objc)
[![Platform](https://img.shields.io/cocoapods/p/ZSRouteUtil-Objc.svg?style=flat)](https://cocoapods.org/pods/ZSRouteUtil-Objc)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```
class JOSHURLForwardRoute: ZSURLRoute {

    /// scheme 的路由映射
    override class var zs_schemeMap: Dictionary<String, String> {
        
        return ["http*" : "web"]
    }
    
    /// host 的路由映射
    override class var zs_hostMap: Dictionary<String, String> {
        
        return ["www.view.com" : "view"]
    }
    
    /// 需要忽略解析 query 的键
    override class var zs_ignoreQueryKey: Array<String> {
        
        return ["key", "hk"]
    }
    
    /// 需要替换 query 的键值
    override class var zs_replaceQuery: Dictionary<String, String> {
        
        return ["key" : "hahahahaha",
                "hk" : "100"]
    }
    
    /// 是否忽略 scheme、host、path 的大小写
    override class var zs_ignoreCase: Bool {
        
        return true
    }
    
    /// 根据路由规则，找到target
    /// - Parameter result: 路由解析结果
    /// - Returns: 返回路由映射后的target
    override class func zs_routeTarget(result: ZSURLRouteResult) -> ZSURLRouteOutput.Type? {
        
        if result.scheme == "web"
        {
            let project = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            return NSClassFromString(project + "." + result.moudle.capitalized + "Controller") as? ZSURLRouteOutput.Type
        }
        
        return ViewController.self
    }
}
```
```
class JOSHURLRoute: ZSURLRoute {
    
    /// 是否开启路由转发策略
    override class var zs_forwardEnable: Bool {
        
        return true
    }
    
    /// 是否忽略 scheme、host、path 的大小写
    override class var zs_ignoreCase: Bool {
        
        return true
    }
    
    /// 路由转发策略表
    override class var zs_forward: Array<ZSURLRouteForward> {
        
        let forward: ZSURLRouteForward = ZSURLRouteForward()
        forward.zs_host = "***.View.***"
        forward.zs_path = "*/*/*"
        forward.zs_forwardTarget = JOSHURLForwardRoute.self
        
        return [forward]
    }
}
```
```
class ViewController: UIViewController, ZSURLRouteOutput {
    
    func zs_didFinishRoute(result: ZSURLRouteResult) -> ZSURLRouteOutput {
        
        print("scheme: \(result.scheme)")
        print("moudle: \(result.moudle)")
        print("submoudle: \(result.submoudle)")
        print("params: \(result.params)")
        
        print("route: \(result.route)")
        print("ignore query: \(result.ignoreQuery)")
        print("origin route: \(result.originRoute)")
        
        return self.init()
    }
    
    lazy var button: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Route", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonW: CGFloat = 150
        let buttonH: CGFloat = 60
        let buttonX: CGFloat = (view.frame.width - buttonW) * 0.5
        
        button.frame = CGRect(x: buttonX, y: 100, width: buttonW, height: buttonH)
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        
        JOSHURLRoute.zs_push(from: "HTTPS://www.view.com/index.html#/haskl/asdajs?qiuu=https://www.baidu.com?weuu=2iwi&asdjkh=1&q=1&jklasd=asjd&key = 1&askdhjajkshj&hk=88")
    }
    
}
```

```
日志结果
scheme: web
moudle: view
submoudle: /index.html#/haskl/asdajs
params: ["q": "1", "asdjkh": "1", "qiuu": "https://www.baidu.com?weuu=2iwi", "jklasd": "asjd"]
route: HTTPS://www.view.com/index.html%23/haskl/asdajs?key=hahahahaha&hk=100
ignore query: key=hahahahaha&hk=100
origin route: HTTPS://www.view.com/index.html#/haskl/asdajs?qiuu=https://www.baidu.com?weuu=2iwi&asdjkh=1&q=1&jklasd=asjd&key=1&askdhjajkshj&hk=88
```

## 版本日志

### 0.1.0

1. ZSURLRoute 路由操作文件
2. ZSURLRoute+Action 路由动作分类，包含push、pop、present、selectedTabbar
3. ZSURLRoute+Getter 路由获取对象分类
4. ZSURLRoute+Input 路由输入时的映射、属性设置
5. ZSURLRoute+Output 路由输出时的属性、代理
6. ZSURLRouteForward 路由转发策略
7. ZSURLRouteResult 路由解析的结果

## Installation

ZSRouteUtil-Objc is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZSRouteUtil-Objc'
```

## Author

Josh, 376019018@qq.com

## License

ZSRouteUtil-Objc is available under the MIT license. See the LICENSE file for more info.
