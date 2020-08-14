//
//  AXLPhotoListTableViewController.swift
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

import UIKit

class AXLPhotoListTableViewController: UITableViewController {
    
    @IBOutlet weak var photoSearchBar: UISearchBar!
    
    var photos: [AXLPhoto] = []
    {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? AXLPhotoCellTableViewCell else { return UITableViewCell()}
        //        let photoItem = AXLPhotoController.sharedInstance().results[indexPath.row]
        let photoItem = photos[indexPath.row]
        cell.photoCell = photoItem
        return cell
    }
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        //Setting Custom Back Button Text
    //        navigationItem.backBarButtonItem = UIBarButtonItem(
    //            title: "Back search results", style: .plain, target: nil, action: nil)
    //        
    //    }
    
} //End of PhotoListTableViewController

extension AXLPhotoListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = photoSearchBar.text, !searchTerm.isEmpty else { return }
        AXLPhotoController.sharedInstance().fetchSearchResults(searchTerm) { (photos, error) in
            if let photos = photos {
                self.photos = photos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
