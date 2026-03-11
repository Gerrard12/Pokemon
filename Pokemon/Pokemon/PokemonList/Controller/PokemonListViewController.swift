//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import UIKit

class PokemonListViewController: UIViewController {
    var pokemonSelected: ((Pokemon) -> Void)?
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private(set) var searchController = UISearchController(searchResultsController: nil)
    private(set) var viewModel: PokemonViewModel
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTitle()
        setUpSearch()
        setupSpinner()
        setUpTableView()
        bindViewModel()
        Task {
            await viewModel.loadPokemons()
        }
    }
    
    init( viewModel: PokemonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel() {
        viewModel.onPokemonsChanged = { [weak self] pokemons in
            self?.updateUI(with: pokemons)
        }
        viewModel.onError = { [weak self] error in
            self?.showError(error)
        }
        viewModel.onLoading = { [weak self] isLoading in
            self?.setLoading(isLoading)
        }
    }
    
    private func updateUI(with pokemons: [Pokemon]) {
        self.tableView.reloadData()
    }

    private func showError(_ error: NetworkError) {
        print(error)
    }

    private func setLoading(_ isLoading: Bool) {
        if isLoading {
            startLoading()
        } else {
            stopLoading()
        }
    }
    
    private func setUpTitle() {
    
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInsetAdjustmentBehavior = .automatic
        
    }
    
    func setupSpinner() {
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
    }
    
    private func startLoading() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    private func setUpSearch() {
        searchController.searchBar.placeholder = "Search Pokemon"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
