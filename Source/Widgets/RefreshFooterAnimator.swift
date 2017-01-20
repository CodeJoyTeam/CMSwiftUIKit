//
//  RefreshFooterAnimator.swift
//  SwiftTemple
//
//  Created by Fang on 2016/10/24.
//  Copyright © 2016年 yfdyf. All rights reserved.
//

import UIKit
import ESPullToRefresh
import RxSwift
import RxCocoa

class RefreshFooterAnimator: UIView ,ESRefreshAnimatorProtocol{
    public let loadingMoreDescription: String = "加载更多数据"
    public let noMoreDataDescription: String  = "没有更多的数据"
    public let loadingDescription: String     = "数据加载中..."
    public let refreshDidStart:PublishSubject<Bool> = PublishSubject()

    public var view: UIView {
        return self
    }
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var trigger: CGFloat = 48.0
    public var executeIncremental: CGFloat = 48.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        titleLabel.text = loadingMoreDescription
        addSubview(titleLabel)
        addSubview(indicatorView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let h = s.height
        titleLabel.frame = self.bounds
        indicatorView.center = CGPoint.init(x: 60.0, y: h / 2.0)
    }

    fileprivate let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    fileprivate let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()

}

extension RefreshFooterAnimator:ESRefreshProtocol{
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        refreshDidStart.onNext(true)
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        refreshDidStart.onNext(false)

    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        // do nothing
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        switch state {
        case .refreshing :
            titleLabel.text = indicatorView.isHidden ? noMoreDataDescription: loadingDescription
            break
        case .autoRefreshing :
            titleLabel.text = indicatorView.isHidden ? noMoreDataDescription: loadingDescription
            break
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
            break
        default:
            titleLabel.text = loadingMoreDescription
            break
        }
    }

}
