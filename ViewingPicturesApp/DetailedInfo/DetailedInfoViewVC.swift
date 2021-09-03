//
//  DetailedInfoViewVC.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-08-31.
//
import UIKit
import SnapKit

class DetailedInfoViewVC: UIView {
    
    //MARK: - constants
    private enum Constants {
        static let imageToLabels: CGFloat = 30
        static let leadingInset: CGFloat = 50
        static let spacingBetweenLabelsInset: CGFloat = 10
        static let spacingBetweenSections: CGFloat = 20
    }
    //MARK: - Configure elements of View
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private lazy var rickAndMortyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let liveStatusLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "Live status"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let statusDescriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let genderDescriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
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
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let locationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupElements()
        setupConstraintsForElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configure elements on the screen
    private func setupElements() {
        addSubview(containerView)
        containerView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        containerView.addSubview(rickAndMortyImageView)
        containerView.addSubview(titleNameLabel)
        containerView.addSubview(liveStatusLabel)
        containerView.addSubview(statusDescriptionLabel)
        containerView.addSubview(genderLabel)
        containerView.addSubview(genderDescriptionLabel)
        containerView.addSubview(locationTitleLabel)
        containerView.addSubview(locationDescriptionLabel)
    }
    
    private func setupConstraintsForElements() {
        containerView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalTo(self)
            maker.trailing.equalTo(self)
            maker.bottom.equalToSuperview()
            maker.height.equalTo(self).priority(.low)
        }
        
        rickAndMortyImageView.snp.makeConstraints { maker in
            maker.top.equalTo(containerView.snp.top)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        titleNameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(rickAndMortyImageView.snp.bottom).offset(Constants.spacingBetweenSections)
        }
        
        liveStatusLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleNameLabel.snp.bottom).offset(Constants.imageToLabels)
        }
        statusDescriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(liveStatusLabel.snp.bottom).offset(Constants.spacingBetweenLabelsInset)
        }
        
        genderLabel.snp.makeConstraints { maker in
            maker.top.equalTo(statusDescriptionLabel.snp.bottom).offset(Constants.spacingBetweenSections)
        }
        genderDescriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(genderLabel.snp.bottom).offset(Constants.spacingBetweenLabelsInset)
        }
        
        locationTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(genderDescriptionLabel.snp.bottom).offset(Constants.spacingBetweenSections)
        }
        locationDescriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(locationTitleLabel.snp.bottom).offset(Constants.spacingBetweenLabelsInset)
        }
    }
    
    func bind(data: GeneralTableViewCellModel) {
        getImage(urlString: data.image)
        titleNameLabel.text = data.name
        statusDescriptionLabel.text = data.status
        genderDescriptionLabel.text = data.gender
        locationDescriptionLabel.text = data.location
        
        DataManager().saveData(name: titleNameLabel.text ?? "No data", status: statusDescriptionLabel.text ?? "No data", gender: genderLabel.text ?? "No data", location: locationTitleLabel.text ?? "No data", image: data.image)
    }
    
    //MARK: - Getting image from API
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
