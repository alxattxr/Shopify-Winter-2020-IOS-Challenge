//
//  GameBoardVC.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-12.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import UIKit

class GameBoardVC: UIViewController {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var cards = [Card]()
    var player1 = Player()
    var player2 = Player()
    lazy var game = Game()
    
    
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func suffleCards(_ sender: Any) {
        shuffleCards()
    }
    
    var arOfOpenCards = [IndexPath]()
    
    let shopColor = UIColor(red:0.61, green:0.81, blue:0.22, alpha:1.0)
    let shopifyImage = UIImage(named: "shopifyIcon")!
    let test = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1ScoreLabel.text = String(player1.score)
        player1NameLabel.text = player1.name
        player2ScoreLabel.text = String(player2.score)
        player2NameLabel.text = player2.name
        turnLabel.text = "Turn: \(game.turn)"

    }
}

/*
Extensions below to free some space
from the base UIViewController
*/

//MARK: - Functions/Logic
extension GameBoardVC {
    func swichTurns(){
        if (game.turn == player1.name){
            return game.turn = player2.name
        }
        return game.turn = player1.name
    }
    
    func incrementScore(){
        if (game.turn == player1.name) {
            player1.score += 1
            player1ScoreLabel.text = String(player1.score)
            isGameOver(player: player1)
            
        } else {
            player2.score += 1
            player2ScoreLabel.text = String(player2.score)
            isGameOver(player: player2)
        }

    }
    
    func isGameOver(player: Player){
        if(player.score == game.win){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ModalType.GameOver.rawValue) as! GameOverModalVC
            vc.player = player.name
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func checkForMatch() -> Bool? {
        var tempAr = [String]()
        for card in arOfOpenCards {
            tempAr.append(cards[card.item].name)
        }
        
        if (Array(Set(tempAr)).count < 2) {
            if (arOfOpenCards.count == cards[arOfOpenCards[0].item].relations) {
                return true
            }
            return nil
        }
        return false
    }
    
    func openCard(for cell: CardView, at indexPath: IndexPath) {
        cell.setView(with: UIColor.white, anImage: cards[indexPath.item].image)
        cell.testView.cardFlip()
        self.cards[indexPath.item].isOpen = true
        arOfOpenCards.append(indexPath) // keep track of open cells
        shuffleButton.isHidden = true //we can only shuffle cards when no card are open on the board
    }
    
    func closeCards(collectionView: UICollectionView) {
        for card in arOfOpenCards {
            let cell = collectionView.cellForItem(at: card) as! CardView
            cell.setView(with: shopColor, anImage: shopifyImage)
            cell.testView.cardFlip()
            self.cards[card.item].isOpen = false
        }
        
        emptyTempAr()
    }
    
    func emptyTempAr() {
        arOfOpenCards = [IndexPath]()
        shuffleButton.isHidden = false
    }
    
    func shuffleCards(){
        var cardAr = cardToFind().shuffled()
        var cellAr = availableCells().shuffled()

        for index in 0..<cardAr.count {
            cards[cellAr[index].item] = cardAr[index]
        }

    }
    
    func availableCells() -> [IndexPath] {
        var tempCellIndex = [IndexPath]()
        
        for card in 0..<self.cards.count{
            let indexPath = (IndexPath(item: card, section: 0))
            let cell = collectionView.cellForItem(at: indexPath) as! CardView
            if !cell.testView.isHidden {
                tempCellIndex.append(indexPath)
            }
        }
        return tempCellIndex
    }
    
    func cardToFind() -> [Card] {
        var tempCardAr = [Card]()
        for card in cards {
            if !card.found {
               tempCardAr.append(card)
            }
        }
        return tempCardAr
    }
    
}


//MARK: - Layout / CollectionView
extension GameBoardVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //prevent overlap
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView = collectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CardView
        cell.setView(with: UIColor(red:0.61, green:0.81, blue:0.22, alpha:1.0), anImage: shopifyImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardView
        
        openCard(for: cell, at: indexPath)
        
        guard let match = checkForMatch() else { return }
        if (match) {
            incrementScore()
            arOfOpenCards.sort()
            for card in arOfOpenCards.reversed() {
                self.cards[card.item].isOpen = false
                self.cards[card.item].found = true
                let cell = collectionView.cellForItem(at: card) as! CardView
                cell.removeCard()
            }
            emptyTempAr()
        } else if(!match) {
            collectionView.allowsSelection = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(700), execute: {
                self.closeCards(collectionView: collectionView)
                collectionView.allowsSelection = true
            })
            swichTurns()
            turnLabel.text = "Turn: \(game.turn)"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !cards[indexPath.item].isOpen //Not open 'opened' cards
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-120)/6
        let height = (collectionView.frame.height-110)/10
        
        return CGSize(width: width, height: height)
    }
    
}

