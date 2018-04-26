//
//  ViewController.swift
//  Dicee
//
//  Created by iMac on 23/03/2018.
//  Copyright © 2018 Zajerao. All rights reserved.

import UIKit
import AVFoundation //importing the sound playing library

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    var randomDiceIndex1 : Int = 8  //had to ensure zero was not taken from global var; using 8
    var randomDiceIndex2 : Int = 9  //had to ensure zero was not taken from global var; using 9
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var lydSpiller1 : AVAudioPlayer!  // Must have exclamation mark or build fails.
    // Define a variable to use the AVAudioPlayer class.
    var lydSpiller2 : AVAudioPlayer!  // Must have exclamation mark or build fails.
    // Define a variable to use the AVAudioPlayer class.
    let lydeneAvTallene = ["1", "2", "3", "4", "5", "6"]
    // Define an array of the names of the sound files to be played (without the extension)
    
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDiceImages()  //to call
                                //on loading the view,
                                //on shake and
                                //on button press
        readOutDice()  //to call
                                //on loading the view,
                                //on shake and
                                //on button press
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        updateDiceImages()
        readOutDice()
        
        }
    
    
    func updateDiceImages (){
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))

//      print("random values: \(randomDiceIndex1), \(randomDiceIndex2)")
        
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
    }
    
    
    func readOutDice () {
    

        let lydFilNavn1 : String = lydeneAvTallene[randomDiceIndex1]
        let lydFilNavn2 : String = lydeneAvTallene[randomDiceIndex2]
          //  Using another array to pick positions 0-5 for a sound filename; tried let lydFilNavn : String = String(randomDiceIndex1) but it failed as random included zero "0"
        
        print("Die1 @ array pos \(randomDiceIndex1), name \(lydFilNavn1)\nDie2 @ array pos, \(randomDiceIndex2) name \(lydFilNavn2)")
        //  Plays audio file matching die 1 number
        
       
        let lydURL1 = Bundle.main.url(forResource: lydFilNavn1, withExtension: "wav")
        let lydURL2 = Bundle.main.url(forResource: lydFilNavn2, withExtension: "wav")
        //  the soundfile to play is referred as a URL; forResource is the file name and withExtension is the file extension, .wav, .aiff, etc
        
        do {
            lydSpiller1 = try AVAudioPlayer(contentsOf: lydURL1!)
        }
        catch {
            print(error)
        }
        // It is required to use a do-try-catch block for AVAudioPlayer before actually playing
        
        lydSpiller1.play()
        
        // TODO  //
        // The 2nd sound file plays over the first.
        // We should condition the 2nd player on the completion of the 1st.
        // I read that to ensure playback has stopped we could use audioPlayerDidFinishPlaying(_:successfully:) delegate method but did not know how to implement it here. Yet.
        // Some parts nicked from github:
//            func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//
//                if flag == true {
//                    print("the finish playing is: \(flag) so now, what?")
//                }
//
//               audioPlayerDidFinishPlaying(lydSpiller1, successfully: true)
        
                    do {
                        lydSpiller2 = try AVAudioPlayer(contentsOf: lydURL2!)
                    }
                    catch {
                        print(error)
                    }
                    
                    lydSpiller2.play()
                }
    
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
        readOutDice()
        
    }
    
}









