//
//  ViewController.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-08-31.
//

import UIKit

class ViewController: UIViewController {

    private var data: [GeneralTableViewCellModel] = []
    private let networkService = NetworkService()

    private lazy var containerTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GeneralViewTVC.self,
                           forCellReuseIdentifier: String(describing: GeneralViewTVC.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .blue
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        loadDataFromRealm()
        fetchData()
    }

    private func setupConstraints() {
        view.addSubview(containerTableView)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            containerTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func loadDataFromRealm() {
        let savedData = DataManager().getData()
        data = savedData
    }
  
    private func fetchData() {
        networkService.getCharacterFromAF { model in
            let results = model.results
            var models = [GeneralTableViewCellModel]()
            
            for result in results {
                let model = GeneralTableViewCellModel(response: result)
                models.append(model)
                
                DataManager().saveData(name: model.name, status: model.status, gender: model.gender, location: model.location, image: model.image)
            }
            
            self.data = models

            DispatchQueue.main.async {
                self.containerTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailedInfoVC()
        viewController.setupResult(result: data[indexPath.row])
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
                                                                    String(describing: GeneralViewTVC.self),
                                                                    for: indexPath) as? GeneralViewTVC else {
            return UITableViewCell()
        }
        
        let currentData = data[indexPath.row]
        cell.bind(data: currentData)
    
        return cell
    }
}

