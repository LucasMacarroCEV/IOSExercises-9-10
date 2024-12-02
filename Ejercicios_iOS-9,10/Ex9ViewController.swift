
import UIKit

class Ex9ViewController: UIViewController {
    
    @IBOutlet weak var sleepHoursSlider: UISlider!
    @IBOutlet weak var workHoursSlider: UISlider!
    @IBOutlet weak var questionsL: UILabel!
    @IBOutlet weak var yesBTN: UIButton!
    @IBOutlet weak var noBTN: UIButton!
    @IBOutlet weak var calculateBTN: UIButton!
    @IBOutlet weak var resultL: UILabel!
    @IBOutlet weak var ageTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Answering();
    }
    
    class Question {
        var question: String;
        var yesPuntuation: Int;
        var noPuntuation: Int;
        
        init (question: String, yesPun: Int, noPun: Int) {
            self.question = question;
            self.yesPuntuation = yesPun;
            self.noPuntuation = noPun;
        }
    }
    var questionsArray: [Question] = [
        Question(question: "¿Practicas ejercicio con frecuencia?", yesPun: 7, noPun: -7),
        Question(question: "¿Consumes algún tipo de estupefaciente?", yesPun: -14, noPun: 4),
        Question(question: "¿Consumes alcohol con frecuencia?", yesPun: -12, noPun: 3),
        Question(question: "¿Acaricias muchos perros?", yesPun: 11, noPun: -8)
    ]
    var questionsIndex: Int = 0;
    var lifeExpectancy: Int = 80;
    var leisureDays: Int = 0;
    
    func Answering() {
        yesBTN.isEnabled = true;
        noBTN.isEnabled = true;
        calculateBTN.isEnabled = false;
        SetResultText(result: "Proporciona toda la información solicitada");
    }
    func Result() {
        yesBTN.isEnabled = false;
        noBTN.isEnabled = false;
        calculateBTN.isEnabled = true;
        SetResultText(result: "Presiona el botón para realizar el cálculo");
    }
    func Error() {
        yesBTN.isEnabled = false;
        noBTN.isEnabled = false;
        calculateBTN.isEnabled = false;
        SetResultText(result: "Introduce una edad coherente");
    }
    
    func GetSleepSliderValue() -> Float {
        return sleepHoursSlider.value;
    }
    func GetWorkSliderValue() -> Float {
        return workHoursSlider.value;
    }
    func SetQuestionsText(question: String) {
        questionsL.text = question;
    }
    func SetResultText(result: String) {
        resultL.text = result;
    }
    
    func ValidateAge() -> Bool {
        if ageTF.text!.isEmpty {return false}
        if ageTF.text!.count > 3 {return false}
        if Int(ageTF.text!)! > 70 {return false}
        for char in ageTF.text! {
            if !char.isNumber {return false}
        }
        return true
    }
    func NextQuestion(years: Int) {
        lifeExpectancy += years;
        questionsIndex += 1;
        if questionsIndex == questionsArray.count {
            Result();
        }
        else {
            SetQuestionsText(question: questionsArray[questionsIndex].question);
        }
    }
    func Calculate() {
        let currentLifeExpectancy: Int = lifeExpectancy - Int(ageTF.text!)!;
        var lifeExpHours: Int = (currentLifeExpectancy*365)*24;
        lifeExpHours -= ((Int(GetWorkSliderValue())*365)*(currentLifeExpectancy-10));
        lifeExpHours -= ((Int(GetSleepSliderValue())*365)*currentLifeExpectancy);
        
        if (lifeExpHours/24) < 0 {
            SetResultText(result: "Suerte tienes de seguir viv@")
        }
        else {
            SetResultText(result: "Te quedan aproximadamente " + String(lifeExpHours/24) + " días de ocio");
        }
    }
    
    @IBAction func Writing(_ sender: Any) {
        if !ValidateAge() {
            Error()
        }
        else {Answering()}
    }
    @IBAction func pressYesButton(_ sender: Any) {
        NextQuestion(years: questionsArray[questionsIndex].yesPuntuation);
    }
    @IBAction func pressNoButton(_ sender: Any) {
        NextQuestion(years: questionsArray[questionsIndex].noPuntuation);
    }
    @IBAction func pressCalculateButton(_ sender: Any) {
        Calculate()
    }
    
}
