//
//  MovieDetailsViewController.swift
//  NachosTime
//
//  Created by Carmelo Gallo on 30/09/2018.
//  Copyright © 2018 Carmelo Gallo. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieDetailsDisplayLogic: class {
    func displayCastSections(viewModel: MovieImageSectionViewModel)
    func displayCrewSections(viewModel: MovieImageSectionViewModel)
    func displaySimilarSection(viewModel: MovieImageSectionViewModel)
    func removeSection(section: MovieImageSectionViewController)
}

class MovieDetailsViewController: UIViewController {

    // MARK: - UI objects
    
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView(frame: .zero)
    private var backdropImageView = UIImageView(frame: .zero)
    private let voteLabel = UILabel(frame: .zero)
    private let starImageView = UIImageView(image: UIImage(named: "star"))
    private let genresLabel = UILabel(frame: .zero)
    private let overviewLabel = UILabel(frame: .zero)
    private let sectionsStackView = UIStackView(frame: .zero)

    // MARK: - Business logic

    private var viewModel: MovieDetailsBusinessLogic

    // MARK: - Object lifecycle
    
    required init(viewModel: MovieDetailsBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure
        configureUI()
        configureConstraints()
        // backdropImageView
        loadBackdropImage()
        // interactor
        viewModel.getSections()
    }
    
    // MARK: - Private methods
    
    private func loadBackdropImage() {
        guard let path = viewModel.backdropPath else {
            return
        }

        let imageTransition = ImageTransition.fade(0.5)
        backdropImageView.kf.indicatorType = .activity
        (backdropImageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
        backdropImageView.kf.setImage(with: URL(string: path), options: [.transition(imageTransition)])
    }

}

// MARK: - MovieDetailsDisplayLogic

extension MovieDetailsViewController: MovieDetailsDisplayLogic {

    func displayCastSections(viewModel: MovieImageSectionViewModel) {
        let castSectionViewController = MovieImageSectionViewController(viewModel: viewModel)
        addChild(castSectionViewController)
        sectionsStackView.addArrangedSubview(castSectionViewController.view)
        castSectionViewController.didMove(toParent: self)
    }

    func displayCrewSections(viewModel: MovieImageSectionViewModel) {
        let crewSectionViewController = MovieImageSectionViewController(viewModel: viewModel)
        addChild(crewSectionViewController)
        sectionsStackView.addArrangedSubview(crewSectionViewController.view)
        crewSectionViewController.didMove(toParent: self)
    }

    func displaySimilarSection(viewModel: MovieImageSectionViewModel) {
        let sectionViewController = MovieImageSectionViewController(viewModel: viewModel)
        addChild(sectionViewController)
        sectionsStackView.addArrangedSubview(sectionViewController.view)
        sectionViewController.didMove(toParent: self)
    }

    func removeSection(section: MovieImageSectionViewController) {
        section.willMove(toParent: nil)
        sectionsStackView.removeArrangedSubview(section.view)
        section.removeFromParent()
    }

}

// MARK: - Configure

private extension MovieDetailsViewController {

    func configureUI() {
        // navigationController
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .never

        // view
        view.backgroundColor = .black

        // scrollView
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)

        // contentView
        contentView.backgroundColor = .clear
        scrollView.addSubview(contentView)

        // imageView
        backdropImageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        contentView.addSubview(backdropImageView)

        // starImageView
        starImageView.backgroundColor = .clear
        contentView.addSubview(starImageView)

        // voteLabel
        voteLabel.accessibilityIdentifier = "MovieDetails.Movie.Vote"
        voteLabel.text = String(viewModel.voteAverage)
        voteLabel.font = UIFont.systemFont(ofSize: 16)
        voteLabel.textColor = .white
        contentView.addSubview(voteLabel)

        // genresLabel
        genresLabel.accessibilityIdentifier = "MovieDetails.Movie.Genres"
        genresLabel.text = viewModel.genres
        genresLabel.font = UIFont.boldSystemFont(ofSize: 12)
        genresLabel.textColor = .white
        genresLabel.numberOfLines = 0
        contentView.addSubview(genresLabel)

        // overviewLabel
        overviewLabel.accessibilityIdentifier = "MovieDetails.Movie.Overview"
        overviewLabel.text = viewModel.overview
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
        contentView.addSubview(overviewLabel)

        // sectionsStackView
        sectionsStackView.axis = .vertical
        sectionsStackView.spacing = 16
        contentView.addSubview(sectionsStackView)
    }

    func configureConstraints() {
        starImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        starImageView.setContentHuggingPriority(.required, for: .horizontal)
        voteLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        voteLabel.setContentHuggingPriority(.required, for: .horizontal)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionsStackView.translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // imageView
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: view.bounds.width / 16 * 9),
            // genresLabel
            genresLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 8),
            genresLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            // starImageView
            starImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 8),
            starImageView.leadingAnchor.constraint(greaterThanOrEqualTo: genresLabel.trailingAnchor, constant: 8),
            // voteLabel
            voteLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            voteLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 3),
            voteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            // overviewLabel
            overviewLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            // sectionsStackView
            sectionsStackView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            sectionsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            sectionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            sectionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ]

        NSLayoutConstraint.activate(constraints)
    }

}
