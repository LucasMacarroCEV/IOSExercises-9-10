
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ex9BTN: UIButton!
    @IBOutlet weak var ex10BTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoToEx9(_ sender: Any) {
        performSegue(withIdentifier: "ToEx9", sender: nil)
    }
    @IBAction func GoToEx10(_ sender: Any) {
        
    }
}
