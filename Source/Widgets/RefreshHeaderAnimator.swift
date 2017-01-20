//
//  RefreshHeaderAnimator.swift
//  SwiftTemple
//
//  Created by Fang on 2016/10/24.
//  Copyright © 2016年 yfdyf. All rights reserved.
//

import UIKit
import ESPullToRefresh
import RxSwift
import RxCocoa

public class RefreshHeaderAnimator: UIView,ESRefreshAnimatorProtocol {
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var trigger: CGFloat = 56.0
    public var executeIncremental: CGFloat = 56.0
    public let refreshDidStart:PublishSubject<Bool> = PublishSubject()
    public var state: ESRefreshViewState = .pullToRefresh
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "beating_0000")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RefreshHeaderAnimator:ESRefreshProtocol{
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.imageView.frame = CGRect.init(x: (self.bounds.size.width - 42.5) / 2.0,
                                               y: self.bounds.size.height - 42.5,
                                               width: 42.5,
                                               height: 42.5)
            
            }, completion: {(finished) in
                var images = [UIImage]()
                for idx in 8 ... 29 {
                    if let aImage = UIImage(named: "beating_000\(idx)") {
                        images.append(aImage)
                    }
                }
                self.imageView.animationDuration = 0.5
                self.imageView.animationRepeatCount = 0
                self.imageView.animationImages = images
                self.imageView.startAnimating()
                self.refreshDidStart.onNext(true)
        })
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        imageView.image = UIImage.init(named: "beating_0000")
        imageView.stopAnimating()
        refreshDidStart.onNext(false)
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = max(0.0, min(1.0, progress))
        imageView.frame = CGRect.init(x: (self.bounds.size.width - 42.5) / 2.0,
                                      y: self.bounds.size.height - 42.5 * p,
                                      width: 42.5,
                                      height: 42.5 * p)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        if self.state == state { return }
        self.state = state
        switch state {
        case .pullToRefresh:
            var images = [UIImage]()
            for idx in 0 ... 8 {
                if let aImage = UIImage(named: "beating_000\((8 - idx))") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.2
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "beating_0000")
            imageView.startAnimating()
            break
        case .releaseToRefresh:
            var images = [UIImage]()
            for idx in 0 ... 8 {
                if let aImage = UIImage(named: "beating_000\(idx)") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.2
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "beating_0008")
            imageView.startAnimating()
            break
        default: break
        }
    }

}

