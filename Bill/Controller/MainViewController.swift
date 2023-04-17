import UIKit

final class MainViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Bill"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cashLabel")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter invoice the amount and click \"Calculator\""
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Bold", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calculate", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let totalBillView = TotalBillView()
    let personsView = PersonsView()
    let tipsView = TipsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        addTap()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(totalBillView)
        view.addSubview(personsView)
        view.addSubview(calculateButton)
        view.addSubview(tipsView)
    }
    
    @objc func calculateButtonTapped() {
        guard let totalBill = totalBillView.summTextField.text,
              let totalBillInt = Int(totalBill) else { return }
        
        let sum = totalBillInt + totalBillInt * tipsView.tipCount / 100
        let persons = personsView.counter

        if persons == 0 {
            descriptionLabel.text = "Enter person count"
            descriptionLabel.textColor = .red
        } else {
            let result = sum / persons
            descriptionLabel.text = "\(result) per person"
            descriptionLabel.textColor = .black
        }
    }
    
    func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension MainViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            totalBillView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            totalBillView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalBillView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalBillView.heightAnchor.constraint(equalToConstant: 130),
            
            personsView.topAnchor.constraint(equalTo: totalBillView.bottomAnchor, constant: 10),
            personsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            personsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            personsView.heightAnchor.constraint(equalToConstant: 130),
            
            tipsView.topAnchor.constraint(equalTo: personsView.bottomAnchor, constant: 10),
            tipsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tipsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tipsView.heightAnchor.constraint(equalToConstant: 100),
            
            calculateButton.topAnchor.constraint(equalTo: tipsView.bottomAnchor, constant: 10),
            calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculateButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
