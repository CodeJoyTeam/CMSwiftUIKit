//
//  BaseViewController.swift
//  SwiftTemple
//
//  Created by Fang on 2016/10/21.
//  Copyright © 2016年 yfdyf. All rights reserved.
//

import UIKit
import PKHUD
import RxSwift
import RxCocoa
import Toast_Swift

open class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var didSetupConstraints = false
    let refreshHeader = RefreshHeaderAnimator.init(frame: CGRect.zero)
    let refreshFooter = RefreshFooterAnimator.init(frame: CGRect.zero)

    override  open func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = CMDefaultTheme.theme.defaultBackgroundColor
        self.edgesForExtendedLayout = .init(rawValue: 0)
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationNormalUI()
        self.layoutPageSubviews()

    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HUD.hide(animated: true)
        self.removeLoadingView()
    }
    

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func layoutPageSubviews(){
    }
    
    public func showWithLabel(text:String){
        self.hideHUD()
        self.view.makeToast(text, duration: 2.0, position: .center)
    }
    
    public func hideHUD(){
        HUD.hide(animated: true)
    }
    
    public func showSuccessToast(text:String){
        self.hideHUD()
        HUD.flash(.labeledSuccess(title: nil, subtitle: text), delay: 2.0)
    }
    
    public func showErrorToast(text:String){
        self.hideHUD()
        HUD.flash(.labeledError(title: nil, subtitle: text), delay: 2.0)
    }
    
    public func initLoadingView(){
         self.view.addSubview(loadingView)
        loadingView.startAnimating()
    }
    
    public func removeLoadingView(){
        loadingView.stopAnimating()
        loadingView.removeSubviews()
    }
    
    lazy var loadingView:UIImageView={
        let loadingView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, w: 48, h: 48))

        var loadingImages = [UIImage]()
        for i in 0..<29 {
            let image:UIImage = UIImage.init(named: "beating_00"+i.toString)!
            loadingImages.append(image)
        }
        guard loadingImages.count > 0 else {
            return loadingView
        }
        loadingView.animationImages = loadingImages
        loadingView.center = (UIApplication.shared.keyWindow?.center)!
        loadingView.animationDuration = 0.5
        return loadingView
    }()

}

extension BaseViewController{
    ///设置普通导航栏样式
    open func setNavigationNormalUI(){
        UIApplication.shared.statusBarStyle = .default
        if let bgImage = CMDefaultTheme.theme.normalNavBarBgImage {
            self.navigationController?.navigationBar.setBackgroundImage(bgImage,for: .default)
        }
        self.navigationController?.navigationBar.tintColor = CMDefaultTheme.theme.defaultNavbarColor
    }
    
    open func setNavigationCustomUI(){
        UIApplication.shared.statusBarStyle = .lightContent
        if let bgImage = CMDefaultTheme.theme.lightNavBarBgImage {
            self.navigationController?.navigationBar.setBackgroundImage(bgImage,for: .default)
        }
        self.navigationController?.navigationBar.tintColor = CMDefaultTheme.theme.defaultNavbarColor
    }

    ///创建导航栏间隙调整
    public func createNavigationSpaceItem(width:CGFloat) -> UIBarButtonItem{
        let negativeSpaceItem:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpaceItem.width = width
        return negativeSpaceItem
    }
    
    ///设置返回按钮
    public func setBackButton(target: Any?, action: Selector?){
        let leftViews:Array<UIView> = Bundle.main.loadNibNamed("NavigationBarBackView", owner: nil, options: nil)! as! Array<UIView>
        let leftView:UIView = leftViews[0]
        
        let leftItem:UIBarButtonItem = UIBarButtonItem.init(customView: leftView)
        
        let leftSpaceItem:UIBarButtonItem = self.createNavigationSpaceItem(width: -13.5)
        self.navigationItem.leftBarButtonItems = [leftSpaceItem,leftItem]
        
        let backButton:UIButton = leftView.viewWithTag(2) as! UIButton
        backButton.addTarget(target, action: action!, for: .touchUpInside)
    }
    
    ///设置返回关闭按钮
    public func setBackAndCloseButton(target: Any?, action: Selector?,closeAction:Selector?) ->UIButton{
        let leftViews:Array<UIView> = Bundle.main.loadNibNamed("NavigationBarBackView", owner: nil, options: nil)! as! Array<UIView>
        let leftView:UIView = leftViews[0]
        
        let leftItem:UIBarButtonItem = UIBarButtonItem.init(customView: leftView)
        
        let leftSpaceItem:UIBarButtonItem = self.createNavigationSpaceItem(width: -16)
        self.navigationItem.leftBarButtonItems = [leftSpaceItem,leftItem]
        
        let backButton:UIButton = leftView.viewWithTag(2) as! UIButton
        backButton.addTarget(target, action: action!, for: .touchUpInside)
        
        let closeButton:UIButton = leftView.viewWithTag(1) as! UIButton
        closeButton.addTarget(target, action: closeAction!, for: .touchUpInside)
        closeButton.isHidden = true
        return closeButton
        
    }
    
    ///设置标题
    public func setNavigationBarTitle(title:String,color:UIColor,font:UIFont,width:CGFloat){
        let titleLabel:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, w: width, h: 44))
        titleLabel.autoresizingMask = .flexibleLeftMargin
        titleLabel.font = font
        titleLabel.textColor = color
        titleLabel.text = title
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.clipsToBounds = true
        self.navigationItem.titleView = titleLabel
    }
    
    public func setNavigationBarTitle(title:String,color:UIColor,font:UIFont){
        self.setNavigationBarTitle(title: title, color: color, font: font, width: 120)
    }
    
    public func setNavigationBarTitle(title:String){
        self.setNavigationBarTitle(title: title, color:CMDefaultTheme.theme.defaultTitleColor ,font: UIFont.systemFont(ofSize: 17))
    }
    
    ///设置导航栏右侧按钮
    public func setRightButtonImage(name:String,selectImage:String,target:Any?,selector:Selector?){
        let rightBtnItem:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: name), style: .plain, target: target, action: selector)
        self.navigationItem.rightBarButtonItem = rightBtnItem
    }

    ///设置导航栏左侧按钮
    public func setLeftButtonImage(name:String,selectImage:String,target:Any?,selector:Selector?){
        let leftBtnItem:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: name), style: .plain, target: target, action: selector)
        self.navigationItem.leftBarButtonItem = leftBtnItem
    }

}

//MARK:BaseViewController
extension Reactive where Base: BaseViewController {
    public var isNetworkActivityIndicatorVisible: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { viewController, active in
            if active {
                viewController.initLoadingView()
            }else{
                viewController.removeLoadingView()
            }
        }
    }
}


