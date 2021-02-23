//
//  CollectionCell.swift
//  CatsApp
//
//  Created by Максим Вечирко on 23.02.2021.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var holderImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true 
    }
    
    func configurateCell(images: [ImageModel], indexPath: IndexPath) {
        self.imageView.image = images[indexPath.row].image
    }

}
