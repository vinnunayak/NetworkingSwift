//
//  AlbumsViewModel.swift
//  SwiftyNetwork
//
//  Created by Vinod Nayak Banavath on 19/07/23.
//

import Foundation
import UIKit

typealias AlbumsResponse = (Bool) -> Void

class AlbumsViewModel: NSObject {
    
    var albumsData = [Album]()
    private let networkManager = NetworkManager.shared
    private let jsonParser = JsorParser()
    private let albumsURL = "https://jsonplaceholder.typicode.com/albums"
    
    func fetchAlbumsData(response: @escaping AlbumsResponse) {
        networkManager.get(url: albumsURL) { data, error in
            if let error = error {
                print("Error While Fetching Albums:\(error)")
                response(false)
            }else{
                guard let albums:[Album] = self.jsonParser.parse(data: data) else { return }
                self.albumsData = albums
                response(true)
            }
        }
    }
}

extension AlbumsViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)) " + "\(albumsData[indexPath.row].title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Item: \(albumsData[indexPath.row].title)")
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
