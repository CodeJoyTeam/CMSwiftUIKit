//
//  Reactive+BindingExtensions.swift
//  YFStore
//
//  Created by Fang on 2016/11/29.
//  Base on Aerolitec Template
//  Copyright © 2016年 yfdyf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ESPullToRefresh
import Kingfisher

//MARK:UIButton
extension Reactive  where Base: UIButton{
    /// 绑定 `tag` 属性.
    public var tag: UIBindingObserver<Base, Int> {
        return UIBindingObserver(UIElement: self.base) { button, tag in
            button.tag = tag
        }
    }
    /// 绑定 `textColor` 属性.
    public var textColor: UIBindingObserver<Base, UIColor> {
        return UIBindingObserver(UIElement: self.base) { button, textColor in
            button.setTitleColor(textColor, for: .normal)
        }
    }
    /// 绑定 `text` 属性.
    public var text: UIBindingObserver<Base, String> {
        return UIBindingObserver(UIElement: self.base) { button, text in
            button.setTitle(text, for: .normal)
        }
    }
    /// 绑定 `borderColor` 属性.
    public var borderColor: UIBindingObserver<Base, UIColor> {
        return UIBindingObserver(UIElement: self.base) { button, borderColor in
            button.layer.borderColor = borderColor.cgColor
        }
    }
}

//MARK:UIView
extension Reactive where Base: UIView {
    /// 绑定 `hidden` 属性.
    public var isHidden: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: self.base) { view, hidden in
            view.isHidden = hidden
        }
    }
    /// 绑定 `alpha` 属性.
    public var alpha: UIBindingObserver<Base, CGFloat> {
        return UIBindingObserver(UIElement: self.base) { view, alpha in
            view.alpha = alpha
        }
    }
    
    /// 绑定 `backgroundColor` 属性.
    public var backgroundColor: UIBindingObserver<Base, UIColor> {
        return UIBindingObserver(UIElement: self.base) { view, color in
            view.backgroundColor = color
        }
    }

    
}

//MARK:CMSubtitleButton
extension Reactive where Base: CMSubtitleButton {
    var primarytitle:UIBindingObserver<Base,String>{
        return UIBindingObserver(UIElement: self.base){ button,title in
            button.primaryLabel.text = title
        }
    }
    var subtitle:UIBindingObserver<Base,String>{
        return UIBindingObserver(UIElement: self.base){ button,title in
            button.subtitleLabel.text = title
        }
    }

}

//MARK:UITableView
extension Reactive where Base: UITableView {
    var stopPullToRefresh:UIBindingObserver<Base,Bool>{
        return UIBindingObserver(UIElement: self.base) { tableView, stop in
            tableView.es_stopPullToRefresh()
        }
    }
    var stopLoadingMore:UIBindingObserver<Base,Bool>{
        return UIBindingObserver(UIElement: self.base) { tableView, stop in
            tableView.es_stopLoadingMore()
        }
    }
    var noticeNoMoreData:UIBindingObserver<Base,Bool>{
        return UIBindingObserver(UIElement: self.base) { tableView, noMore in
            if noMore {
                tableView.es_noticeNoMoreData()
            }else{
                tableView.es_stopLoadingMore()
            }
        }
    }
}

//MARK:UIImageView
extension Reactive where Base: UIImageView {
    var uImage:UIBindingObserver<Base,URL>{
        return UIBindingObserver(UIElement: self.base) { imageView, url in
            imageView.kf.setImage(with: url,
                                  placeholder: CMDefaultTheme.theme.placeholderImage,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
    }
    
    public var image: UIBindingObserver<Base, UIImage> {
        return UIBindingObserver(UIElement: self.base) { imageView, image in
            imageView.image = image
        }
    }
}

//MARK:UILabel
extension Reactive where Base:UILabel{
    public var textColor: UIBindingObserver<Base, UIColor> {
        return UIBindingObserver(UIElement: self.base) { label, textColor in
            label.textColor = textColor
        }
    }
    
    public var textFont: UIBindingObserver<Base, UIFont> {
        return UIBindingObserver(UIElement: self.base) { label, font in
            label.font = font
        }
    }

}
//MARK:CMEvaluationToolView
extension Reactive where Base:CMEvaluationToolView{
    var starShineCount: UIBindingObserver<Base, Int> {
        return UIBindingObserver(UIElement: self.base) { view, starShineCount in
            view.starShineCount = starShineCount
        }
    }
    
}




