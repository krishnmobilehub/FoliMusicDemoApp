//
//  MusicListVC.swift
//  FoilMusicDemoApp
//
//

import UIKit

class MusicListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellHeights: [CGFloat] = []
    var expandedRowValue :Int?
    
    enum Const {
        static let closeCellHeight: CGFloat = 185
        static let openCellHeight: CGFloat = 485
        static let rowsCount = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource
extension MusicListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.rowsCount
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as MusicCell = cell else {
            return
        }

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.close(false)
        } else {
            cell.close(true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as? MusicCell  else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MusicCell else {
            return
        }

        var customIndexPath: IndexPath?
        if expandedRowValue != nil {
            if indexPath.row == expandedRowValue {
                cellHeights[indexPath.row] = Const.closeCellHeight
                cell.isOpenCell(with: false)
                expandedRowValue = nil
                tableView.reloadRows(at: [(NSIndexPath(row: indexPath.row, section: 0) as IndexPath)], with: .none)
                return
            } else {
                customIndexPath = IndexPath(row: expandedRowValue ?? 0, section: 0)
                if  let cell = tableView.cellForRow(at: customIndexPath ?? indexPath) as? MusicCell {
                    cellHeights[customIndexPath?.row ?? 0] = Const.closeCellHeight
                    cell.isOpenCell(with: false)
                }
            }
        }
        
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.isOpenCell(with: true)
            expandedRowValue = indexPath.row
        } else {
            cellHeights[customIndexPath?.row ?? 0] = Const.closeCellHeight
        }
        tableView.reloadRows(at: [(NSIndexPath(row: indexPath.row, section: 0) as IndexPath)], with: .none)
    }
}
