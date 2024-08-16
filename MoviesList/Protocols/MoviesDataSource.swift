//
//  MoviesDataSource.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 12.08.24.
//


import UIKit

class MoviesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
