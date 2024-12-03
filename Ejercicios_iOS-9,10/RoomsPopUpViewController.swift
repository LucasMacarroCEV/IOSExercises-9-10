
import UIKit

class RoomsPopUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBTN: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservedMeetingRooms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2ID", for: indexPath)
        cell.textLabel?.text = reservedMeetingRooms[indexPath.row].name + " - " + String(reservedMeetingRooms[indexPath.row].people) + " personas | " + reservedMeetingRooms[indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DisplayCancelResAlert(roomID: indexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    static func ShowPopup(parentVC: UIViewController){
        if let popUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoomsPopUpViewController") as? RoomsPopUpViewController {
            popUpViewController.modalPresentationStyle = .custom
            popUpViewController.modalTransitionStyle = .crossDissolve
            parentVC.present(popUpViewController, animated: true)
        }
    }
    
    func DisplayCancelResAlert(roomID: Int) {
        let alert = UIAlertController(title: "¿Quieres cancelar esta reserva?", message: "\(reservedMeetingRooms[roomID].name) - \(reservedMeetingRooms[roomID].people) personas - \(reservedMeetingRooms[roomID].date)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.destructive, handler: { action in
            meetingRooms.append(reservedMeetingRooms[roomID])
            reservedMeetingRooms.remove(at: roomID)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
