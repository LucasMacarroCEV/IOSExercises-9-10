
import UIKit

class MeetingRoom {
    var name: String
    var date: String
    var people: Int
    
    init (name: String, date: String, people: Int) {
        self.name = name
        self.date = date
        self.people = people
    }
}
var meetingRooms = [MeetingRoom] ()
var reservedMeetingRooms = [MeetingRoom] ()

class Ex10ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showRoomsBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        SetMeetingRooms()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetingRooms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = meetingRooms[indexPath.row].name + " - " + String(meetingRooms[indexPath.row].people) + " personas | " + meetingRooms[indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        DisplayReserveRoomAlert(roomID: indexPath.row)
    }
    
    func SetMeetingRooms() {
        let roomNum = GetRandomNumber(max: 12, min: 1)
        repeat {
            meetingRooms.append(MeetingRoom(name: GetRandomName(),date: GetRandomDate(), people: GetRandomPeople()))
        } while meetingRooms.count < roomNum
        tableView.reloadData()
    }
    
    func DisplayReserveRoomAlert(roomID: Int) {
        let alert = UIAlertController(title: "¿Quieres reservar esta sala?", message: "\(meetingRooms[roomID].name) - \(meetingRooms[roomID].people) personas - \(meetingRooms[roomID].date)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { action in
            reservedMeetingRooms.append(meetingRooms[roomID])
            meetingRooms.remove(at: roomID)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func GetRandomNumber(max: Int, min: Int = 0) -> Int {
        return Int.random(in: min..<max)
    }
    func GetRandomName() -> String {
        var nums = [Int] ()
        var num: Int
        repeat {
            num = GetRandomNumber(max: 20, min: 1)
        } while nums.contains(num)
        nums.append(num)
        return "Sala " + String(num)
    }
    func GetRandomPeople() -> Int {
        var nums = [Int] ()
        var num: Int
        repeat {
            num = GetRandomNumber(max: 20, min: 1)
        } while nums.contains(num)
        nums.append(num)
        return num
    }
    func GetRandomDate() -> String{
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        guard
            let days = calendar.range(of: .day, in: .month, for: date),
            let randomDay = days.randomElement()
        else {
                return "ERROR"
        }
        dateComponents.setValue(randomDay, for: .day)
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd-MM-yyyy"
        let stringDate = formatter.string(from: calendar.date(from: dateComponents)!)
        return stringDate
    }
    
    @IBAction func showRooms(_ sender: Any) {
        RoomsPopUpViewController.ShowPopup(parentVC: self)
    }
}
