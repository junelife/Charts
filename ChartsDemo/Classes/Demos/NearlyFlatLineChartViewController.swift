//
//  NearlyFlatLineChartViewController.swift
//  ChartsDemo
//
//  Created by Joseph Ross on 5/25/17.
//  Copyright © 2017 dcg. All rights reserved.
//

import UIKit
import Charts

@available(iOS 9.0, *)
class NearlyFlatLineChartViewController: UIViewController {
    
    let chartView:LineChartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        chartView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        chartView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        
        let url = Bundle.main.url(forResource: "nearly-flat", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let pointDicts:[[String: Any]] = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [[String: Any]]
        
        let entries = pointDicts.map { (pointDict) -> ChartDataEntry in
            let x:Double = pointDict["x"] as! Double
            let y:Double = pointDict["y"] as! Double
            return ChartDataEntry(x: x, y: y)
        }
        let dataSet = LineChartDataSet(values: entries, label:nil)
        dataSet.drawCirclesEnabled = false
        let colors:[CGColor] = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: [0, 1])!
        dataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90)
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true
        dataSet.colors = [.orange]
        dataSet.lineWidth = 3.0
        dataSet.mode = .linear
        dataSet.setDrawHighlightIndicators(false)
        dataSet.drawValuesEnabled = false
        
        chartView.data = LineChartData(dataSet: dataSet)
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 300000
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.chartDescription?.text = nil
    }
}
