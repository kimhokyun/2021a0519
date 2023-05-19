//
//  ViewController2.swift
//  2021a0519
//
//  Created by hokyun Kim on 2023/05/19.
//

import UIKit

class ViewController2: UIViewController {
    var id : Int?
    var responseData : DataDetail?
    var chartDetail : ChartDetail?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var melodizerLabel: UILabel!
    @IBOutlet weak var lyricistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(id: self.id ?? 0)
        lyricistLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func fetchData(id: Int) {
        guard let url = URL(string: "http://localhost:3300/v1/chart/detail/\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let Data = try decoder.decode(DataDetail.self, from: data)
                self.responseData = Data
                self.chartDetail = Data.chart
                DispatchQueue.main.async {
                    print(self.chartDetail)
                    self.patchUI()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func patchUI(){
        guard let uidata = chartDetail else { return }
        titleLabel.text = uidata.title
        singerLabel.text = uidata.singer
        melodizerLabel.text = uidata.melodizer
        lyricistLabel.text = uidata.lyricist
        genreLabel.text = uidata.genre
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


/*
 
 struct ChartDetail :Codable{
     let id : Int
     let title : String
     let singer : String
     let melodizer : String
     let lyricist : String
     let genre : String
 }
 */
