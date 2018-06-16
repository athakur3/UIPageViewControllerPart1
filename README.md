EVERYTHING ABOUT PAGEVIEWCONTROLLERS.
====

PART 1
===

---

Background
---

This repository documents Part 1 of the multi-part series that implements exhaustive and in-depth concepts about PageViewControllers in iOS. 

---

Repository Specification
---

**Details about UIPageViewController for this Part**   
* Transition Style is Page Curl (Interface builder)
* Double sided propery is false (Interface builder)
* Spine location can be min or max (Interface builder)
* Delegate and Data Source are nil 
* Gesture based navigation is not included
* Total of 6 View Controllers for this example
* Storyboard IDs in Interface Builder



**How to Use**

The document has one useful content in Main storyboard file and in MainPageViewController.swift file.  
Below is the implementation that is used to provide content to PageViewController.  

---

```
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
 *  If spine location setting is Min or Max and double sided property is set to false
 *  The above mentioned properties can be setup from Interface Builder. UIPageViewController object's Attributes inspector
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
```

---

Note
---

The implementation and content providing using dataSource will be implemented in future part of this series.

---

