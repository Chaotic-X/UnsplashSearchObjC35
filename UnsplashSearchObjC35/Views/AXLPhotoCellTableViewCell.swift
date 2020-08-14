//
//  AXLPhotoCellTableViewCell.swift
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

import UIKit

class AXLPhotoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var altDrescriptionLabel: UILabel!
    
    var photoCell: AXLPhoto? {
        didSet{
                self.updateCellWith()
        }
    }
    
    func updateCellWith() {
        if let photoCell = photoCell {
//            guard photoCell.altDescription == photoCell.altDescription else { return }
            AXLPhotoController.sharedInstance().fetchThumbImage(photoCell) { (image) in
                var firstName = ""
                var lstName = ""
                var nilDescription = ""
                DispatchQueue.main.async {
   
                    self.fullNameLabel.text = photoCell.firstName + " " +  photoCell.lastName
                    self.altDrescriptionLabel.text = photoCell.altDescription
                }
            }
        }
    }
    
}

extension Optional where Wrapped: Collection {

    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }

}
