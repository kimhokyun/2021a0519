//
//  ViewController.swift
//  2021a0519
//
//  Created by hokyun Kim on 2023/05/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var domesticButton: UIButton!
    @IBOutlet weak var overseasButton: UIButton!
    
    
    var responseData : Data = Data(chartList: [])
    var chartList : [Chart] = []
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData(chartType: "domestic")
        
        startTimer()
        
        self.domesticButton.setTitleColor(.red, for: .normal)
        self.overseasButton.setTitleColor(.black, for: .normal)
        self.domesticButton.setTitle("국내", for: .normal)
        self.overseasButton.setTitle("해외", for: .normal)

    }
    
    func fetchData(chartType: String) {
        guard let url = URL(string: "http://localhost:3300/v1/chart/\(chartType)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let Data = try decoder.decode(Data.self, from: data)
                self.responseData = Data
                self.chartList = Data.chartList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.chartList)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm:ss"
        let currentTime = formatter.string(from: Date())
        currentTimeLabel.text = currentTime
    }
    
    @IBAction func showDomestic(_ sender: Any) {
        fetchData(chartType: "domestic")
        self.domesticButton.setTitleColor(.red, for: .normal)
        self.overseasButton.setTitleColor(.black, for: .normal)
        self.domesticButton.setTitle("국내", for: .normal)
        self.overseasButton.setTitle("해외", for: .normal)
        
    }
    
    @IBAction func showOverseas(_ sender: Any) {
        fetchData(chartType: "overseas")
        self.domesticButton.setTitleColor(.black, for: .normal)
        self.overseasButton.setTitleColor(.red, for: .normal)
        self.domesticButton.setTitle("국내", for: .normal)
        self.overseasButton.setTitle("해외", for: .normal)
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let chart = self.chartList[indexPath.row]
        cell.imageUrlImageView.image = UIImage(named: chart.imageUrl ?? "")
        cell.rankLabel.text = "\(String(describing: chart.rank))"
        cell.titleLabel.text = chart.title
        cell.singerLabel.text = chart.singer

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.chartList[indexPath.row].id
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true)
    }

}

