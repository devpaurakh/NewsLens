//
//  OnBoardingVC.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 25/01/2024.
//

import UIKit

class OnBoardingVC: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var slides:[OnBoardingSlide] = []
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            }
            else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    slides = [
        OnBoardingSlide(title: "Welcome to NewsLens", description: "Discover a world of news tailored just for you. Dive into personalized stories and stay informed with NewsLens", image: UIImage(named: "oneboard1")!),
        
        
        OnBoardingSlide(title: "Your News, Your Way", description: ". Choose your interests, set preferences, and enjoy a customized news feed that matches your lifestyle. Start shaping your news journey today!", image: UIImage(named: "onboard2")!),
        
        OnBoardingSlide(title: "Stay Connected, Stay Informed", description: "NewsLens keeps you in the know. Sign up now to access exclusive features and breaking news. Your journey to informed living starts here.", image: UIImage(named: "onboard3")!)
    ]
        
        pageControl.numberOfPages = slides.count
        
    }
    
    
    
    @IBAction func newBtnClicked(_ sender: Any) {
        
        if currentPage == slides.count - 1 {
            
            print("goto the Next page")
            let controller  = storyboard?.instantiateViewController(identifier: "LoginNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnBoarded = true
            present(controller, animated: true, completion: nil)
            
        }
        else{
            
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
       
        
    }
    

    
}

extension OnBoardingVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifire, for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slides[indexPath.row])//this is populate the imageview labels
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
}
