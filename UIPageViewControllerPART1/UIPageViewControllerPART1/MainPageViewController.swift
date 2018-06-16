//
//  ViewController.swift
//  UIPageViewControllerPART1
//
//  Created by Akshansh on 16/06/18.
//  Copyright © 2018 Akshansh. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    var currentPageIndexForMinMaxSpine = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMinMaxSpinePageSet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/**** ****                                  **** ****
 *  If setting is Min spine and double sided false
 **** ****                                 **** ****/
extension MainPageViewController {
    
    fileprivate func setupMinMaxSpinePageSet() {
        setupViewControllersMinMaxSpine(pageIndex: currentPageIndexForMinMaxSpine)
        
        let minmaxSpineTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(minmaxSpinePageTapped))
        self.view.addGestureRecognizer(minmaxSpineTapGestureRecognizer)
    }
    
    fileprivate func setupViewControllersMinMaxSpine(pageIndex: Int) {
        self.view.isUserInteractionEnabled = false
        
        if pageIndex == GlobalSetup.contentViewControllers.count {
            self.currentPageIndexForMinMaxSpine = 0
            setViewControllers([GlobalSetup.contentViewControllers[0]], direction: .forward, animated: true, completion: {
                print("The success status is: \($0), We are on Page number \(self.currentPageIndexForMinMaxSpine + 1)")
                self.view.isUserInteractionEnabled = true
            })
        } else {
            setViewControllers([GlobalSetup.contentViewControllers[pageIndex]], direction: .forward, animated: true, completion: {
                print("The success status is: \($0), We are on Page number \(pageIndex + 1)")
                self.view.isUserInteractionEnabled = true
            })
        }
    }
    
    @objc func minmaxSpinePageTapped() {
        currentPageIndexForMinMaxSpine += 1
        setupViewControllersMinMaxSpine(pageIndex: currentPageIndexForMinMaxSpine)
    }
    
}


struct GlobalSetup {
    
    static func getViewController(id: String) -> UIViewController! {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    static var contentViewControllers = {
        return ["MyFirstViewController", "MySecondViewController", "MyThirdViewController", "MyFourthViewController", "MyFifthViewController", "MySixthViewController"].map({getViewController(id: $0)!})
    }()
    
    static var backContentController = {
        return UIViewController()
    }()
}
