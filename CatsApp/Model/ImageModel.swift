//
//  ImageModel.swift
//  CatsApp
//
//  Created by Максим Вечирко on 23.02.2021.
//

import UIKit

protocol SubImageModel {
    func loadData(completion: @escaping(([ImageModel]) -> ()))
}

struct SubImageModelImpl: SubImageModel {
    
    func loadData(completion: @escaping (([ImageModel]) -> ())) {
        completion(generate())
    }
    
    func generate() -> [ImageModel] {
        let imagesNames = [UIImage(named: "images1")!,
                           UIImage(named: "images2")!,
                           UIImage(named: "images3")!,
                           UIImage(named: "images4")!,
                           UIImage(named: "images5")!,
                           UIImage(named: "images6")!,
                           UIImage(named: "images7")!,
                           UIImage(named: "images8")!,
                           UIImage(named: "images9")!,
                           UIImage(named: "images10")!,
                           UIImage(named: "images11")!
        ]
        var result: [ImageModel] = []
        
        for i in 0..<imagesNames.count {
            result.append(ImageModel(image: imagesNames[i]))
        }
        return result
    }
    
}

struct ImageModel {
    var image: UIImage
}
