//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let cardView = UIView()
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let pokemonImage = UIImageView()
    private let mainStack = UIStackView()
    private let statsStack = UIStackView()
    private let abilitiesLabel = UILabel()
    private let heightLabel = UILabel()
    private let weightLabel = UILabel()
    private let sizeStack = UIStackView()
    
    private let viewModel: PokemonDetailViewModel
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let statsScrollView = UIScrollView()
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
        Task {
            await viewModel.getInformation()
        }
    }
    
    private func setupUI() {
        setupCard()
        setupMainStack()
        setupLabel()
        setupTypeLabel()
        setupImage()
        setupStats()
        setupStatsScroll()
        setupAbilities()
        setupHeightLabel()
        setupWeightLabel()
        setupSizeStack()
        setupHierarchy()
        setupConstraints()
    }
    
    private func bindViewModel() {
        viewModel.onPokemonDetailChanged = { [weak self] pokemons in
            self?.updateUI()
        }
        viewModel.onError = { [weak self] error in
            self?.showError(error)
        }
        viewModel.onLoading = { [weak self] isLoading in
            self?.setLoading(isLoading)
        }
        viewModel.onUpdateImage = { [weak self] image in
            if let image = image {
                self?.pokemonImage.image = image
            }
        }
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
    
    func setupStatsScroll() {
        statsScrollView.showsHorizontalScrollIndicator = false
        statsScrollView.alwaysBounceHorizontal = true
    }
    
    func setupCard() {
        cardView.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 6)
        cardView.layer.shadowRadius = 10
    }
    
    func setupLabel() {
        nameLabel.font = .systemFont(ofSize: 32, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .label
    }
    
    func setupTypeLabel() {
        typeLabel.textAlignment = .center
        typeLabel.font = .systemFont(ofSize: 18, weight: .medium)
        typeLabel.textColor = .secondaryLabel
    }
    
    func setupImage() {
        pokemonImage.contentMode = .scaleAspectFit
        pokemonImage.layer.cornerRadius = 20
        pokemonImage.clipsToBounds = true
        pokemonImage.backgroundColor = .white
        pokemonImage.image = UIImage(named: "placeHolder")
    }
        
    func setupStats() {
        statsStack.axis = .horizontal
        statsStack.distribution = .fill
        statsStack.spacing = 20
    }

    func setupAbilities() {
        abilitiesLabel.numberOfLines = 0
        abilitiesLabel.textAlignment = .center
        abilitiesLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
        
    func setupHeightLabel() {
        heightLabel.textAlignment = .center
        heightLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func setupWeightLabel() {
        weightLabel.textAlignment = .center
        weightLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func setupMainStack() {
        mainStack.axis = .vertical
        mainStack.spacing = 32
        mainStack.distribution = .fill
        mainStack.alignment = .fill
        mainStack.setContentHuggingPriority(.required, for: .vertical)
    }
    
    func updateUI() {
        nameLabel.text = viewModel.pokemonDetail.name?.uppercased() ?? ""
        typeLabel.text = viewModel.pokemonDetail.totalTypes
        abilitiesLabel.text = "Abilities: \(viewModel.pokemonDetail.totalAbilities)"
        heightLabel.text = "Height: \(viewModel.pokemonDetail.height ?? 0)"
        weightLabel.text = "Weight: \(viewModel.pokemonDetail.weight ?? 0)"
        resetStats()
        guard let stats = viewModel.pokemonDetail.stats else {
            return
        }
        stats.forEach { stat in
            addStat(name: stat.stat?.name ?? "",
                    value: stat.baseStat ?? 0)
        }
    }
    
    func addStat(name: String, value: Int) {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center

        let title = UILabel()
        title.text = name.uppercased()
        title.font = .boldSystemFont(ofSize: 18)

        let number = UILabel()
        number.text = "\(value)"
        number.font = .systemFont(ofSize: 14)

        stack.addArrangedSubview(title)
        stack.addArrangedSubview(number)
        statsStack.addArrangedSubview(stack)
    }
    
    func setupSizeStack() {
        sizeStack.axis = .horizontal
        sizeStack.distribution = .fillProportionally
        sizeStack.spacing = 80
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
    
    private func setupHierarchy() {
        view.addSubview(cardView)
        view.addSubview(activityIndicator)
        cardView.addSubview(mainStack)
        mainStack.addArrangedSubview(nameLabel)
        mainStack.addArrangedSubview(typeLabel)
        mainStack.addArrangedSubview(pokemonImage)
        mainStack.addArrangedSubview(statsScrollView)
        statsScrollView.addSubview(statsStack)
        mainStack.setCustomSpacing(50, after: statsScrollView)
        mainStack.addArrangedSubview(abilitiesLabel)
        mainStack.setCustomSpacing(80, after: abilitiesLabel)
        mainStack.addArrangedSubview(sizeStack)
        sizeStack.addArrangedSubview(heightLabel)
        sizeStack.addArrangedSubview(weightLabel)
    }
    
    private func setupConstraints() {
        [cardView, mainStack, pokemonImage, activityIndicator, statsScrollView, statsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            pokemonImage.heightAnchor.constraint(equalToConstant: 220),

            statsScrollView.heightAnchor.constraint(equalToConstant: 70),
            
            statsStack.topAnchor.constraint(equalTo: statsScrollView.contentLayoutGuide.topAnchor),
            statsStack.leadingAnchor.constraint(equalTo: statsScrollView.contentLayoutGuide.leadingAnchor),
            statsStack.trailingAnchor.constraint(equalTo: statsScrollView.contentLayoutGuide.trailingAnchor),
            statsStack.bottomAnchor.constraint(equalTo: statsScrollView.contentLayoutGuide.bottomAnchor),
            statsStack.heightAnchor.constraint(equalTo: statsScrollView.frameLayoutGuide.heightAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func resetStats() {
        statsStack.arrangedSubviews.forEach {
            statsStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

