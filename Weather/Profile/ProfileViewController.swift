//
//  ProfileViewController.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import UIKit
import Combine
import MBProgressHUD
class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var displayPicture: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var city: BindingTextField!
    
    var hud: MBProgressHUD?
    weak var coordinator: MainCoordinator?
    var viewModel : ProfileViewModel!
    private var bindings:Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSetup()
        setupBindings()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cityEntered(_ sender: Any) {
        self.hud = displayLoader(view: self.view, label: "Fetching Weather")
        viewModel.fetchWeatherDetails()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        cell.item = viewModel.weather?.list[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather?.list.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = self.viewModel.weather?.list[indexPath.row] {
            self.coordinator?.toDetailsViewController(item: list)
        }
        
    }
    func profileSetup(){
        self.username.text = self.viewModel.user.username
        self.displayPicture.image = self.viewModel.user.image
        self.bio.text = self.viewModel.user.bio
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    func setupBindings(){
        bindings = [
            viewModel.$weather.receive(on: RunLoop.main)
                .sink{ [weak self] weather in
                    self?.hud?.hide(animated: true)
                    self?.tableview.reloadData()
                },
            viewModel.$alert.receive(on: RunLoop.main)
                .sink{ [weak self] alert in
                    self?.hud?.hide(animated: true)
                    guard let alert = alert else { return }
                    self?.showAlert(title: alert.title, message: alert.message)
                }
        ]
        city.defaultText { [weak self] text in
            self?.viewModel.city = text
        }
        city.bind { [weak self] text in
            self?.viewModel.city = text
        }
        
    }
    
}
