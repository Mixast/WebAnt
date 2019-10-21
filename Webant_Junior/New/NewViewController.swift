import UIKit

class NewViewController: UIViewController {
    private var sizeWidthCell = CGFloat()
    private var sizeHeightCell = CGFloat()
    let imageProfile = ImageProfile.instance
    let interactive = CustomInteractiveTransition()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var tasks = [URLSessionDataTask?](repeating: nil, count: 100)
    
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
//        if self.view.frame.size.width < self.view.frame.size.height {
        sizeWidthCell = collectionView.frame.size.width / 2.2
        sizeHeightCell = collectionView.frame.size.height / 4.5
//        } else {
//            if self.view.frame.size.width < 1024 {
//                sizeWidthCell = collectionView.frame.size.width / 2.5
//                sizeHeightCell = collectionView.frame.size.height / 4
//            } else {
//                sizeWidthCell = collectionView.frame.size.width / 3
//                sizeHeightCell = collectionView.frame.size.height / 4
//            }
//        }
        
//        if self.imageProfile.colectionImageUrl.count == 0 {
//            let colleeferf = ["https://u.kanobu.ru/editor/images/41/561022c0-0500-4e6f-916e-f4a859d3046f.jpg", "https://i.ytimg.com/vi/2kftq_Nauv0/mqdefault.jpg", "https://i.ytimg.com/vi/8lXZPM_AYIA/mqdefault.jpg", "https://14.img.avito.st/640x480/5900281614.jpg", "https://img11.postila.ru/resize?w=604&src=%2Fdata%2Fc1%2Fb9%2F30%2Fb4%2Fc1b930b44274d4afe7abaea5cf4e7f12356afc2dc7051ea68eb2498e2ec21654.jpg", "https://i.ytimg.com/vi/W0DQsaQwDfo/mqdefault.jpg" , "http://perfect-magazine.ru/wp-content/uploads/2019/08/podium_jizni_1_w1200-768x1152.jpg", "https://coubsecure-s.akamaihd.net/get/b99/p/coub/simple/cw_timeline_pic/c22c3d9e735/b773a4a44d4070bc28684/big_1543939317_image.jpg", "https://cs8.pikabu.ru/post_img/big/2016/10/25/3/147736454813177854.jpg", "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/1a730d21-a624-4c4f-bc2e-0931ae15263f/dd6zuoq-7723254c-0dc6-4339-81e7-43f3fe4740df.png/v1/fill/w_1280,h_1821,q_80,strp/gtht_by_iamamango123_dd6zuoq-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTgyMSIsInBhdGgiOiJcL2ZcLzFhNzMwZDIxLWE2MjQtNGM0Zi1iYzJlLTA5MzFhZTE1MjYzZlwvZGQ2enVvcS03NzIzMjU0Yy0wZGM2LTQzMzktODFlNy00M2YzZmU0NzQwZGYucG5nIiwid2lkdGgiOiI8PTEyODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.Hd-9JV8I8OC9mfGA46q1PKK0QMBX99pRuWdAh30bj0o"]
//
//            for i in 1...colleeferf.count { self.imageProfile.colectionImageUrl.append(colleeferf[i-1])
//
//                var profile = Profile()
//                profile.previewImageData = Data()
//                profile.description = "Интересный факт: Суммарное экранное время Тони Старка в «Войне бесконечности» и «Финале» составляет 3001 сек."
//                self.imageProfile.colectionImageData.append(profile)
//            }
//            self.backgroundImage.isHidden = true
//        }
        
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        collectionView.addSubview(refreshControl)

    }
    @objc private func refreshData(_ sender: Any) {
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        self.imageProfile.fillingUrlImage(order: 100, page: 1, limit: 100) {
            DispatchQueue.main.async {
                if self.imageProfile.colectionImageUrl.count != 0 {
                    self.collectionView.isHidden = false
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                } else {
                    self.backgroundImage.isHidden = false
                    self.showAlert(massage: "", title: "Update failed")
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let inetReachability = InternetReachability()!
          
          inetReachability.whenReachable = { _ in
            DispatchQueue.main.async {
                print("Internet is OK!")
//                if self.imageProfile.colectionImageUrl.count == 0 {
//                    self.imageProfile.fillingUrlImage(order: 100, page: 1, limit: 100) {
//                        DispatchQueue.main.async {
//                            if self.imageProfile.colectionImageUrl.count != 0 {
//                                self.collectionView.isHidden = false
//                                self.collectionView.reloadData()
//                            } else {
//                                self.backgroundImage.isHidden = false
//                            }
//                        }
//                    }
//                }
            }
          }
          inetReachability.whenUnreachable = { _ in
              DispatchQueue.main.async {
                  print("Internet connection FAILED!")
                self.backgroundImage.isHidden = false
                self.collectionView.isHidden = true
                
              }
          }
          
          do {
              try inetReachability.startNotifier()
          } catch {
              print("Could not start notifier")
          }
          
          NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: inetReachability)
    }
    
    @objc func internetChanged(note:Notification) {
        
        let reachability =  note.object as! InternetReachability
        
        if reachability.connection != .none {
            if imageProfile.colectionImageUrl.count == 0 {
                imageProfile.fillingUrlImage(order: 100, page: 1, limit: 100) {
                    DispatchQueue.main.async {
                        if self.imageProfile.colectionImageUrl.count != 0 {
                            self.collectionView.isHidden = false
                            self.collectionView.reloadData()
                            self.backgroundImage.isHidden = true
                        } else {
                            self.backgroundImage.isHidden = false
                        }
                    }
                }
            }
        } else {
            print("No Internet connection! /n Please, check your internet connection")
            
        }
    }
}

//     MARK: - Collection View main

extension NewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageProfile.colectionImageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sizeWidthCell, height: sizeHeightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        if self.imageProfile.colectionImageData[indexPath.row].fullImageData == Data() {
            DispatchQueue.global().async {
                self.requestImage(forIndex: indexPath)
            }
            cell.image.image = #imageLiteral(resourceName: "No internet")
        } else {
            guard let image = UIImage(data: self.imageProfile.colectionImageData[indexPath.row].fullImageData) else {
                return cell
            }
            cell.image.image = image
        }
        let tapGestureRecognizer = MyTapGesture(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.tag = indexPath.row
        cell.image.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    @objc func imageTapped(tapGestureRecognizer: MyTapGesture) {
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewControler") as? InfoViewControler {
            detailVC.transportLine = tapGestureRecognizer.tag
            self.interactive.viewController = detailVC
            self.navigationController?.delegate = self
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}


//     MARK: - Collection View DataSourcePrefetching
extension NewViewController: UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if self.imageProfile.colectionImageData[indexPath.row].fullImageData == Data() {
                DispatchQueue.global().async {
                    self.requestImage(forIndex: indexPath)
                }
            }
        }
    }
    
    func requestImage(forIndex: IndexPath) {
        if self.imageProfile.colectionImageData[forIndex.row].fullImageData != Data() {
            return
        }

        autoreleasepool {
            var task: URLSessionDataTask
            if forIndex.row <= self.tasks.count {
                if self.tasks[forIndex.row] != nil
                    && self.tasks[forIndex.row]!.state == URLSessionTask.State.running {
                    return
                }
                
                task = self.getTask(forIndex: forIndex)
                self.tasks[forIndex.row] = task
                task.resume()
            }
        }
    }
    
    //  URLSessionDataTask
    func getTask(forIndex: IndexPath) -> URLSessionDataTask  {
        
        if self.imageProfile.colectionImageData[forIndex.row].fullImageData != Data() {
            return URLSessionDataTask()
        }
        
        guard let url = URL(string: "http://gallery.dev.webant.ru/media/" + self.imageProfile.colectionImageUrl[forIndex.row]) else {
            return URLSessionDataTask()
        }
//        guard let url = URL(string: self.imageProfile.colectionImageUrl[forIndex.row]) else {
//            return URLSessionDataTask()
//        }
        let imgURL = url
        
        return URLSession.shared.dataTask(with: imgURL) { data, response, error in
            DispatchQueue.global().async {
                guard let data = data, error == nil else { return }
                self.imageProfile.colectionImageData[forIndex.row].fullImageData = data
                
                guard let image = UIImage(data: data)  else { return }
                let newImage = image.resizeImage(image: image, targetSize: CGSize(width: self.sizeWidthCell, height: self.sizeHeightCell))
                guard let newData = newImage.pngData() else { return }
                DispatchQueue.main.async() {
                    self.imageProfile.colectionImageData[forIndex.row].previewImageData = newData
                    self.collectionView.reloadItems(at: [forIndex])
                }
                
            }
        }
    }
}

extension NewViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return animatedTransitionTwo()
        } else if operation == .pop {
            return animatedTransitionTwoDismissed()

        } else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactive.hasStarted ? interactive : nil
    }

}
extension NewViewController {
    private func showAlert (massage: String, title: String) {    // Вывод ошибки если пользователь ввел неправильно данные
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

//     MARK: - Custom UITapGestureRecognizer
class MyTapGesture: UITapGestureRecognizer {
    var tag = Int()
}
