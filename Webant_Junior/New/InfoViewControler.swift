import UIKit

class InfoViewControler: UIViewController {
    var transportLine = 0
    let imageProfile = ImageProfile.instance

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var beckImageView: UIImageView!
    @IBOutlet weak var lowerImageView: UIImageView!
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designFor(image: mainImageView)
        designFor(image: beckImageView)
        designFor(image: lowerImageView)
        
        mainImageView.image = UIImage(data: imageProfile.colectionImageData[transportLine].fullImageData)
        
        if transportLine+1 < imageProfile.colectionImageData.count {
            beckImageView.image = UIImage(data: imageProfile.colectionImageData[transportLine+1].fullImageData)
        } else {
            beckImageView.isHidden = true
        }
        
        if transportLine+2 < imageProfile.colectionImageData.count {
            lowerImageView.image = UIImage(data: imageProfile.colectionImageData[transportLine+2].fullImageData)
        } else {
            lowerImageView.isHidden = true
        }
        
        textView.text = imageProfile.colectionImageData[transportLine].description
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeUp)  //Ловим свайп
        self.view.addGestureRecognizer(swipeDown)  //Ловим свайп
    }
    
    //     MARK: - Переход по свайпу вправо
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizer.Direction.down:
                print("down")
                
                if self.transportLine + 1 < self.imageProfile.colectionImageData.count {
                    self.transportLine += 1
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.4, animations: {
                            
                            self.mainImageView.image = UIImage(data: self.imageProfile.colectionImageData[self.transportLine].fullImageData)
                            self.textView.text = self.imageProfile.colectionImageData[self.transportLine].description
                            
                            if self.transportLine+1 < self.imageProfile.colectionImageData.count {
                                if self.imageProfile.colectionImageData[self.transportLine+1].fullImageData == Data() {
                                    self.beckImageView.isHidden = false
                                    self.beckImageView.image = #imageLiteral(resourceName: "No internet")
                                    guard let url = URL(string: self.imageProfile.colectionImageUrl[self.transportLine+1]) else {
                                        return
                                    }

                                    let queue = DispatchQueue.global(qos: .utility)
                                    queue.async {
                                        if let data = try? Data(contentsOf: url) {
                                            DispatchQueue.main.async { [weak self] in
                                                guard let self = self else { return }
                                                let index = self.transportLine+1
                                                if index < self.imageProfile.colectionImageData.count {
                                                    self.imageProfile.colectionImageData[index].fullImageData = data
                                                    DispatchQueue.main.async {
                                                        self.beckImageView.image = UIImage(data: self.imageProfile.colectionImageData[index].fullImageData)
                                                    }
                                                }
                                            }
                                        }
                                        if self.transportLine+2 < self.imageProfile.colectionImageData.count {
                                            if let newUrl = URL(string: self.imageProfile.colectionImageUrl[self.transportLine+2]) {
                                                if let data = try? Data(contentsOf: newUrl) {
                                                    DispatchQueue.main.async { [weak self] in
                                                        guard let self = self else { return }
                                                        let index = self.transportLine+2
                                                        if index < self.imageProfile.colectionImageData.count { self.imageProfile.colectionImageData[index].fullImageData = data
                                                            DispatchQueue.main.async {
                                                                self.lowerImageView.image = UIImage(data: self.imageProfile.colectionImageData[index].fullImageData)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {
                                
                                self.beckImageView.image = UIImage(data: self.imageProfile.colectionImageData[self.transportLine+1].fullImageData)
                                }
                            } else {
                                self.beckImageView.isHidden = true
                            }
                            if self.transportLine+2 < self.imageProfile.colectionImageData.count {
                                if self.imageProfile.colectionImageData[self.transportLine+2].fullImageData == Data() {
                                    self.lowerImageView.isHidden = false
                                    self.lowerImageView.image = #imageLiteral(resourceName: "No internet")
                                } else {
                                self.lowerImageView.image = UIImage(data: self.imageProfile.colectionImageData[self.transportLine+2].fullImageData)
                                }
                            } else {
                                self.lowerImageView.isHidden = true
                            }
                        })
                    }
                }
            case UISwipeGestureRecognizer.Direction.up:
                print("up")
                if self.transportLine > 0 {
                    self.transportLine -= 1
                }
                if self.transportLine < self.imageProfile.colectionImageData.count {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.4, animations: {
                            self.mainImageView.image = UIImage(data: self.imageProfile.colectionImageData[self.transportLine].fullImageData)
                            self.textView.text = self.imageProfile.colectionImageData[self.transportLine].description
                            
                            if self.transportLine+1 < self.imageProfile.colectionImageData.count {
                                self.beckImageView.isHidden = false
                                self.beckImageView.image = UIImage(data: self.imageProfile.colectionImageData[self.transportLine+1].fullImageData)
                            } else {
                                self.beckImageView.isHidden = true
                            }
                            
                            if self.transportLine+2 < self.imageProfile.colectionImageData.count {
                                self.lowerImageView.isHidden = false
                                self.lowerImageView.image = UIImage(data: self.imageProfile.colectionImageData[self.transportLine+2].fullImageData)
                            } else {
                                self.lowerImageView.isHidden = true
                            }
                        })
                    }
                }
            default:
                break
            }
        }
    }
    
}
