//
//  ViewController.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-12.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    private var cardsNumber = 0;
    var cards = [Card]()
    var currentGame = Game()
    var player1 = Player(name: "Player 1", score: 0)
    var player2 = Player(name: "Player 2", score: 0)
    var game = Game()
    let network = APIClient()
    
    @IBOutlet weak var numberOfCardsToWinSlider: UISlider!
    @IBOutlet weak var numberOfCardToWinLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var hiddenMessage: UILabel!
    
    
    @IBAction func changeCardsNumber(_ sender: Any) {
        if numberOfCardsToWinSlider.value < 12.0 {
            segmentControl.selectedSegmentIndex = 0
        } else if numberOfCardsToWinSlider.value > 12.0 && numberOfCardsToWinSlider.value < 14.9{
            segmentControl.selectedSegmentIndex = 1
        } else {
            segmentControl.selectedSegmentIndex = 2
        }
        setDifficulty()
        setText()
    }
    
    @IBAction func segmentSelected(_ sender: Any) {
        setDifficulty()
        setText()
    }
    
    @IBAction func player1TextField(_ sender: Any) {
        self.player1.name = player1TextField.text!
    }
    
    @IBAction func player2TextField(_ sender: Any) {
        self.player2.name = player2TextField.text!
    }
    
    //Pass game settings information to the GameBoardVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? GameBoardVC {

            prepareCardsForGame(difficulty: game.difficulty)
            vc.game = Game(win: cardsNumber, turn: randomTurnChoice())
            vc.player1 = self.player1
            vc.player2 = self.player2
            vc.cards = self.cards
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsNumber = Int(numberOfCardsToWinSlider.value) //set label to the current slider value
        segmentControl.setInitialStyle() //Set style for our segment control
        setText()
        setDifficulty()
        startGameButton.layer.borderColor = UIColor.white.cgColor
        startGameButton.layer.borderWidth = 1
        startGameButton.layer.cornerRadius = startGameButton.frame.width/2
        hiddenMessage.textColor = UIColor.clear
        self.hideKeyboardWhenTappedAround()
        
        //Data fetching and passing reponse to array of Card
        network.getShopifyStoreData { (products, error) in
            if error != nil {
                self.currentGame.connection = false
                self.displayModal(type: .ConnectionError)
                
                //Lazy way to rettriger the network call if error => display modal 
                self.viewDidLoad()
            }
        
            if let products = products {
                for prod in products.products {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: URL(string: prod.image.src)!)
                            DispatchQueue.main.async {
                                let image = UIImage(data: data!)!
                                self.cards.append(Card(id: prod.image.id, name: prod.title, image: image))
                        }
                    }
                }
            }
        }
        player1TextField.setMinimalStyleField()
        player2TextField.setMinimalStyleField()
    }
    
}

//MARK: - Functions
private extension MainMenuVC {
    func setText() {
        pointsToWin()
        numberOfCardToWinLabel.text? = "\(cardsNumber)"
    }
    
    func pointsToWin() {
        cardsNumber = Int(numberOfCardsToWinSlider.value)
    }
    
    func setDifficulty() {
        switch(segmentControl.selectedSegmentIndex){
        case 0:
            let green = UIColor(red:0.54, green:0.90, blue:0.51, alpha:1.0)
            mainView.backgroundColorTransition(for: green)
            numberOfCardsToWinSlider.value = 10
            game.difficulty = .Easy
            hiddenMessage.textColor = UIColor.clear // set text to clear to keep styling margins
            break
        case 1:
            let orange = UIColor(red:0.99, green:0.73, blue:0.34, alpha:1.0)
            mainView.backgroundColorTransition(for: orange)
            numberOfCardsToWinSlider.value = 13
            game.difficulty = .Medium
            hiddenMessage.textColor = UIColor.clear
            break
        case 2:
            let red = UIColor(red:1.00, green:0.22, blue:0.22, alpha:1.0)
            mainView.backgroundColorTransition(for: red)
            numberOfCardsToWinSlider.value = numberOfCardsToWinSlider.maximumValue
            game.difficulty = .Hard
            hiddenMessage.textColor = UIColor.lightGray
            break
        default:
            break;
        }
    }
    
    func randomTurnChoice() -> String {
        let number = Int.random(in:0...1)
        
        if number > 0 {
            return player1.name
        }
        return player2.name
    }
    
    func addExtraRelations(){
        let third = cardsNumber/3
        
        for card in 0...third {
            self.cards[card].relations += 1
        }
    }
    
    func prepareCardsForGame(difficulty: Difficulty){
        cards = cards.shuffled()
        let arraySlice = cards.prefix(((cardsNumber*2)-1))
        cards = Array(arraySlice)
    
        
        for card in cards {
            //starting from 1 since we already have one copy in orginal array
            for _ in 1..<card.relations {
                cards.append(card)
            }
        }
        
        if difficulty == .Hard {
            addExtraRelations()
        }
        
        cards = cards.shuffled()
    }
}
