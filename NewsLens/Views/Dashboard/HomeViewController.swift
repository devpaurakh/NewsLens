//
//  HomeViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 28/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    var articlesList = [NewsList]()
    var newsImages = ["arvind","bbc","dd","file","heo","hero","hq720","terror"]
    var timer:Timer?
    var currentCellIndex = 0
    @IBOutlet var sliderCollection: UICollectionView!
    
    
    @IBOutlet var NewsTableView: UITableView!
    @IBOutlet var collectionViewCatagory: UICollectionView!
    let newsCatagory = ["America", "BBC News", "Germany","Trump"]
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cells for the first collection view
        collectionViewCatagory.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cellCategory")
            // Register cells for the second collection view
        sliderCollection.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: "cellSliderCollectionViewCell")
        timer = Timer.init(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        collectionViewCatagory.delegate = self
        collectionViewCatagory.dataSource = self
        collectionViewCatagory.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellCategory")
        userDef.set(0,forKey: "categoryIndex")
        fetchNewsData()
       
        
    }
    
    @objc func slideToNext(){
        if currentCellIndex < newsImages.count-1{
            currentCellIndex = currentCellIndex +  1
        }else{
            currentCellIndex = 0
        }
        
        sliderCollection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        
    }
    
    
    //Functionj
    
    func fetchNewsData(){
        let url = URL(string: url_USnews)
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler:{ (data, respons,error) in
          guard let data = data, error == nil else
            {
              print("ErrorOccured while Accessing Data")
              return
          }
            var newsFullList:NewsData?
            do{
                newsFullList = try JSONDecoder().decode(NewsData.self, from: data)
            }
            catch{
                print("Error Occured while Decoding\(error)")
            }
            self.articlesList = newsFullList!.articles
            DispatchQueue.main.async {
                self.NewsTableView.reloadData()
            }
            
        })
        dataTask.resume()
    }
    
}
// Extension collection view

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)->Int{
        if collectionView == collectionViewCatagory{
            return newsCatagory.count
        }
        else if collectionView == sliderCollection{
            return newsImages.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCatagory{
            let cell = collectionViewCatagory.dequeueReusableCell(withReuseIdentifier: "cellCategory", for: indexPath) as! CategoryCollectionViewCell
            if userDef.integer(forKey: "categoryIndex") == indexPath.row{
                cell.labelCategory.textColor = .accent
                cell.border.backgroundColor = .accent
            }else{
                cell.labelCategory.textColor = .systemGray2
                cell.border.backgroundColor = .systemGray2
            }
            cell.labelCategory.text = newsCatagory[indexPath.row]
            return cell
        }else if collectionView == sliderCollection{
            let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SliderCollectionViewCell
            cell.sliderImage.image = UIImage(named: newsImages[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        // Store the selected index in UserDefaults
        userDef.set(indexPath.row, forKey: "categoryIndex")
        
        // Add an animation while reloading the collection view
        collectionView.performBatchUpdates({
            // Reload the collection view items
            collectionView.reloadSections(IndexSet(integer: 0))
        }) { (_) in
            
        }
        
    }
}

extension UIImageView{
    func downloadImage(from url:URL){
        contentMode = .scaleAspectFill
        let dataTask = URLSession.shared.dataTask(with: url,completionHandler: {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
            
        })
        dataTask.resume()
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  NewsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        if articlesList[indexPath.row].author != nil{
            cell.newsAuther.text = "Author: \(articlesList[indexPath.row].author!)"
        }
        else {
            cell.newsAuther.text = "- No Author Available"
        }
        cell.newsTitle.text = articlesList[indexPath.row].title
        if articlesList[indexPath.row].urlToImage != nil{
            let url = URL(string: articlesList[indexPath.row].urlToImage!)
            cell.newsImage.downloadImage(from: url!)
            cell.newsImage.contentMode = .scaleAspectFill
        }
        
        else{
            cell.newsImage.image = UIImage(named: "photo")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "NewsContentHome") as? NewsDetailViewController
        
        vc?.newsContent = articlesList[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width, height: sliderCollection.frame.height)
    }
    
}




