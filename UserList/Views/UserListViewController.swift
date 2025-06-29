//
//  ViewController.swift
//  UserList
//
//  Created by Vishwa Fernando on 2025-06-29.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()
    private let viewModel = UserListViewModel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let refreshControl = UIRefreshControl()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredUsers: [User] = []
    private var isSearching: Bool {
        return !searchController.searchBar.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        view.backgroundColor = .white

        setupSearchController()
        setupTableView()
        setupLoading()
        setupBindings()
        setupRefreshControl()
        viewModel.fetchUsers()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        viewModel.fetchUsers()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func setupLoading() {
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)

        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.frame = CGRect(x: 20, y: 200, width: view.frame.width - 40, height: 100)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
    }

    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.errorLabel.isHidden = true
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }

        viewModel.onError = { [weak self] error in
            self?.loadingIndicator.stopAnimating()
            self?.errorLabel.isHidden = false
            self?.errorLabel.text = error
            self?.refreshControl.endRefreshing()
        }

        loadingIndicator.startAnimating()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredUsers.count : viewModel.userCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = isSearching ? filteredUsers[indexPath.row] : viewModel.user(at: indexPath.row)

       
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        cell.textLabel?.text = user.fullName
            cell.detailTextLabel?.text = user.email
        cell.imageView?.image = UIImage(systemName: "person.crop.circle") 

          // Load thumbnail asynchronously
          if let url = URL(string: user.picture.thumbnail) {
              URLSession.shared.dataTask(with: url) { data, _, _ in
                  if let data = data {
                      DispatchQueue.main.async {
                          cell.imageView?.image = UIImage(data: data)
                          cell.setNeedsLayout()
                      }
                  }
              }.resume()
          }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = isSearching ? filteredUsers[indexPath.row] : viewModel.user(at: indexPath.row)
        let detailVC = UserDetailViewController(user: selectedUser)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.lowercased() else { return }

        filteredUsers = viewModel.users.filter {
            $0.fullName.lowercased().contains(query)
        }
        tableView.reloadData()
    }
}
