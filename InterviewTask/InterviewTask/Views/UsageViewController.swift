//
//  ResultViewController.swift
//  InterviewTask
//
//  Created by NhiVHY on 14/03/2024.
//

import UIKit

class UsageViewController: UIViewController {
//    MARK: - IBOutlets
    @IBOutlet weak var usageTableview: UITableView!
    
//    MARK: - Properties
    private var viewModel = UsageViewModel()
    
//    MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
//    MARK: - Methods
    func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.usageTableview.reloadData()
            }
        } failHandler: {
            print("Error")
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray5
        title = "Usage"
        setupNavigationBar()
        
        usageTableview.dataSource = self
        usageTableview.delegate = self
        usageTableview.backgroundColor = .clear
        usageTableview.separatorStyle = .none
        usageTableview.register(UINib.init(nibName: "ChartTableViewCell", bundle: .main), forCellReuseIdentifier: "ChartTableViewCell")
        usageTableview.register(UINib.init(nibName: "TotalTableViewCell", bundle: .main), forCellReuseIdentifier: "TotalTableViewCell")
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let imgBack = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.backIndicatorImage = imgBack
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension UsageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartTableViewCell", for: indexPath) as? ChartTableViewCell else { return UITableViewCell() }
            guard let firstDate = viewModel.usageData?.usageHistories.first?.dateValue,
                  let lastDate = viewModel.usageData?.usageHistories.last?.dateValue else  { return UITableViewCell() }
            cell.configData(data: viewModel.usageData,
                            avgUsage: viewModel.avgUsage,
                            avgConsumption: viewModel.avgConsumption,
                            firstDate: firstDate,
                            lastDate: lastDate)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell", for: indexPath) as? TotalTableViewCell else { return UITableViewCell() }
            cell.configData(approxCost: viewModel.usageData?.approxTotalCost ?? 0, approxElectricity: viewModel.usageData?.approxTotalElectricity ?? 0)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
