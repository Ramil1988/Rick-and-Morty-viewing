//
//  GeneralViewTVC.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-08-31.
//

import UIKit

class GeneralViewTVC: UITableViewCell {
    
    //MARK: - Configure elements of View
    private lazy var rickAndMortyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 190).isActive = true
        imageView.backgroundColor = .yellow
        return imageView
    }()

    private let titleNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "Last known location:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let locationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.sizeToFit()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.sizeToFit()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Configure elements on the screen
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubview(stackView)
        contentView.addSubview(descriptionStackView)

        descriptionStackView.addArrangedSubview(titleNameLabel)
        descriptionStackView.addArrangedSubview(statusLabel)
        descriptionStackView.addArrangedSubview(locationTitleLabel)
        descriptionStackView.addArrangedSubview(locationDescriptionLabel)

        stackView.addArrangedSubview(rickAndMortyImageView)
        stackView.addArrangedSubview(descriptionStackView)
    }

    func bind(data: GeneralTableViewCellModel) {
        getImage(urlString: data.image)
        titleNameLabel.text = data.name
        statusLabel.text = data.status
        locationDescriptionLabel.text = data.location
        
    }
    
    private func getImage(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.rickAndMortyImageView.image = UIImage(data: data)!
                }
            }
            task.resume()
        }
    }
}
