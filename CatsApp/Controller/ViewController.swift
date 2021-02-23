//
//  ViewController.swift
//  CatsApp
//
//  Created by Максим Вечирко on 23.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var load: SubImageModel?
    var model: [ImageModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var selectedIndex: [IndexPath] = []
    var selectedView: UIImageView?
    var basicFrame: CGRect = .zero
    
    override func loadView() {
        super.loadView()
        self.load = SubImageModelImpl()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateCollectionView()
        self.requestImages()
    }
    
    private func configurateCollectionView() {
        self.registerCells()
        let customLayout = CustomLayout()
        customLayout.delegate = self
        self.collectionView.collectionViewLayout = customLayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func registerCells() {
        self.collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }
    
    private func requestImages() {
        self.load?.loadData(completion: { (model) in
            self.model = model
        })
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.configurateCell(images: model , indexPath: indexPath)
        return cell
    }
    
    @objc func dissmissView() {
        guard let index = selectedIndex.firstIndex(where: {$0 == selectedIndex.last!}) else {return}
        let cell = collectionView.cellForItem(at: selectedIndex[index]) as! CollectionCell
        UIView.animate(withDuration: 0.4) {
            self.selectedView?.frame = self.basicFrame
            self.selectedIndex.remove(at: index)
        } completion: { _ in
            self.selectedView?.removeFromSuperview()
            self.collectionView.allowsSelection = true
            cell.imageView.alpha = 1
        }

    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dissmissView))
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        let cardViewFrame = (cell.imageView.superview?.convert(cell.imageView.frame, to: nil))!
        let copyOfCardView = UIImageView(frame: cardViewFrame)
        
        copyOfCardView.layer.cornerRadius = 20
        copyOfCardView.clipsToBounds = true
        copyOfCardView.image = model[indexPath.row].image
        copyOfCardView.isUserInteractionEnabled = true
        copyOfCardView.addGestureRecognizer(gesture)
        view.addSubview(copyOfCardView)
        basicFrame = cardViewFrame
        cell.imageView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            
            copyOfCardView.frame = CGRect(x: 0, y: 150, width: self.view.frame.width, height: cell.imageView.frame.size.height * 2)
            
        } completion: { _ in
            
            self.selectedIndex.append(indexPath)
            self.selectedView = copyOfCardView
            self.collectionView.allowsSelection = false
        }
        
    }
}

extension ViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return model[indexPath.row].image.size
    }
    
    
}


























