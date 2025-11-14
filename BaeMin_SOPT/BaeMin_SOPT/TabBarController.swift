import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = FeedViewController()
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(resource: .tabIcon), tag: 0)
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .baeminMint300
        secondVC.tabBarItem = UITabBarItem(title: "장보기·쇼핑", image: UIImage(resource: .tabIcon1), tag: 1)
        
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .baeminBackgroundPurple
        thirdVC.tabBarItem = UITabBarItem(title: "찜", image: UIImage(resource: .tabIcon2), tag: 2)
        
        let fourthVC = UIViewController()
        fourthVC.view.backgroundColor = .baeminMint500
        fourthVC.tabBarItem = UITabBarItem(title: "주문내역", image: UIImage(resource: .tabIcon3), tag: 3)
        
        let fifthVC = UIViewController()
        fifthVC.view.backgroundColor = .baeminPurple
        fifthVC.tabBarItem = UITabBarItem(title: "마이배민", image: UIImage(resource: .tabIcon4), tag: 4)

        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .baeminBlack
    }
}

