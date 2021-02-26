//
//  TimerPageVC.swift
//  Matchday
//
//  Created by Lachy Pound on 22/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class TimerPageVC: UIViewController {
    
    let scoreCell = "scoreCell"
    
    var timerArray = [["Start", "14:02"],["End", "14:34"],["Total", "32"]]
    var scoreArray = [Score]()
    var quarter: Quarter? {
        didSet {
            print("setting quarter in timer")
            // find the time and set the timerArray accordingly
            if quarter?.startTime == nil {
                timerArray = [["Start", "Not Started"],["End", "-"],["Total", "-"]]
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "pm"
                guard let startTime = quarter?.startTime else {return}
                let startTimeString = dateFormatter.string(from: startTime)
                if quarter?.finishTime == nil {
                    timerArray = [["Start", startTimeString],["End", "Not Finished"],["Total", "-"]]
                } else {
                    guard let finishTime = quarter?.finishTime else {return}
                    let finishTimeString = dateFormatter.string(from: finishTime)
                    let totalQuarterTime = quarter?.finishTime?.timeIntervalSince(startTime)
                    let totalQuarterTimeString = totalQuarterTime?.stringTime
                    timerArray = [["Start", startTimeString],["End", finishTimeString],["Total", "\(totalQuarterTimeString ?? "Interval not calculated")"]]
                }
            }
            // do the same for score
            var sortedArray = [Score]()
            guard let scores = quarter?.score?.allObjects as? [Score] else {return}
            for score in scores {
                switch score.teamType {
                case "home":
                    sortedArray.insert(score, at: 0)
                case "away":
                    sortedArray.append(score)
                case "mutual":
                    sortedArray.append(score)
                default:
                    sortedArray.append(score)
                }
            }
            scoreArray = sortedArray
            tableView.reloadData()
        }
    }
    
    let clockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(imageLiteralResourceName: "goal_posts").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.PaletteColour.Green.newGreen
        return imageView
    }()
    let controllerPageTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Elements"
        title.textColor = UIColor.PaletteColour.Green.newGreen
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    private func setUpView() {
        view.backgroundColor = view.provideBackgroundColour()
//        view.addSubview(clockImage)
        view.addSubview(tableView)
//        view.addSubview(controllerPageTitle)
        tableView.register(ScoreCellView.self, forCellReuseIdentifier: scoreCell)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    func combineScore(goals: Int, points: Int) -> String {
        var combinedScore = ""
        let totalGoalScore = 6 * goals
        let totalScore = String(totalGoalScore + points)
        let goalString = String(goals)
        let pointString = String(points)
        combinedScore = "\(goalString).\(pointString) (\(totalScore))"
        return combinedScore
    }
}

extension TimerPageVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Header 1"
        } else {
            return "Header 2"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return timerArray.count
        } else {
            return scoreArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        if indexPath.section == 0 {
            cell.detailTextLabel?.text = timerArray[indexPath.row][1]
            cell.textLabel?.text = timerArray[indexPath.row][0]
        } else {
//            cell.detailTextLabel?.text = scoreArray[indexPath.row][1]
//            cell.textLabel?.text = scoreArray[indexPath.row][0]
            let cell = tableView.dequeueReusableCell(withIdentifier: scoreCell, for: indexPath) as! ScoreCellView
            cell.score = scoreArray[indexPath.row]
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension TimerPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = ControlBookHeaderView()
            headerView.image.image = UIImage(imageLiteralResourceName: "Timer_2").withRenderingMode(.alwaysTemplate)
            headerView.title.text = "Timings"
            return headerView
        } else {
            let headerView = ScoreHeaderView()
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
