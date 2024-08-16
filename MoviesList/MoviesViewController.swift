//
//  ViewController.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 01.08.24.
//

import UIKit


class MoviesViewController: UIViewController , UITableViewDelegate {
    
    
    var moviesViewModel: MoviesViewModelProtocol?
    //var myDelegateDataSource: MyDelegateDatasource =  MyDelegateDatasource()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    
    required init(viewModel: MoviesViewModelProtocol) {
        self.moviesViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
       
        
        if  moviesViewModel  == nil {
            moviesViewModel = MoviesViewModel(moviesService: MoviesService(url: Constants.moviesURL), moviesCells: Observable<[MovieViewModelCell]>([]))
        }
        fetchMovies()
        
        
        moviesViewModel?.moviesCells?.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func fetchMovies() {
        moviesViewModel?.fetchMovies()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.dataSource = myDelegateDataSource
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Logout?", message: message , preferredStyle: .alert)
          
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Logout",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
         
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
            
        }
}



extension MoviesViewController:  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = moviesViewModel?.moviesCells?.value.count {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = moviesViewModel?.moviesCells?.value.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = moviesViewModel?.moviesCells?.value[indexPath.row].name
        return cell
    }
    
    
}
