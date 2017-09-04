//
//  PageContentView.swift
//  MYDemo
//
//  Created by 德基 on 2017/8/15.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func selectedpageContentView(_ contentView : PageContentView, currentIndex: Int)

}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    weak var delegate : PageContentViewDelegate?

    var childVCs: [UIViewController]
    weak var parentViewController: UIViewController?

    fileprivate lazy var collectionView: UICollectionView = { [weak self] in

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    init(frame: CGRect,childVCs: [UIViewController],parentVC: UIViewController) {
        
        self.childVCs = childVCs
        self.parentViewController = parentVC
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
            
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        collectionView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       
        guard keyPath == "contentOffset" && object is UIScrollView else {
             super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        let scrollView = object as! UIScrollView
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        let currentIndex = Int(currentOffsetX/scrollViewW)
        delegate?.selectedpageContentView(self, currentIndex: currentIndex)
        
    
       
    }
    deinit {
        
      collectionView.removeObserver(self, forKeyPath: "contentOffset")
    }
}
extension PageContentView: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVCs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
 
   
 
    func setCurrentIndex(_ currentIndex : Int) {
        

        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }


}
