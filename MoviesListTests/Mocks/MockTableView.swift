//
//  MockTableView.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 10.08.24.
//

import Foundation
import UIKit

class MockTableView: UITableView {
    
    var reloadDataCalled = false
    
    override func reloadData() {
         reloadDataCalled = true
    }
}
