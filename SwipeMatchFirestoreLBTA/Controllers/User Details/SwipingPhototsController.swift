//
//  SwipingPhototsController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Cole Riggle on 10/23/20.
//  Copyright © 2020 Cole Riggle. All rights reserved.
//

import UIKit

class SwipingPhototsController: UIPageViewController, UIPageViewControllerDataSource {

    let controllers = [
        PhotoController(image: #imageLiteral(resourceName: "boost_circle")),
        PhotoController(image: #imageLiteral(resourceName: "refresh_circle")),
        PhotoController(image: #imageLiteral(resourceName: "like_circle")),
        PhotoController(image: #imageLiteral(resourceName: "super_like_circle")),
        PhotoController(image: #imageLiteral(resourceName: "dismiss_circle"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
}

class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady4c"))
    
    init(image: UIImage) {
        imageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
