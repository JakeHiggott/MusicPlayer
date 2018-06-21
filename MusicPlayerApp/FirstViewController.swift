//
//  FirstViewController.swift
//  MusicPlayerApp
//
//  Created by Jake Higgot on 6/18/18.
//  Copyright © 2018 Jake Higgott. All rights reserved.
//

import UIKit
import AVFoundation


var audioPlayer = AVAudioPlayer()
var isPaused = true

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var songs: [String] = []
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        do
        {
            // Reuse this for pause and play just play with the audio player func
            guard let songPath = getSongPath(selectedSong: songs[indexPath.row]) else { return }
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: songPath) as URL)
            audioPlayer.play()
            isPaused = false
        }
        catch{
           print("ERROR")
        }
    }
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingSongName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    func getSongPath(selectedSong: String) -> String? {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3"){
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count - 1]
                    mySong = mySong.replacingOccurrences(of: "_-_", with: " ")
                    mySong = mySong.replacingOccurrences(of: "_", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    
                    if mySong == selectedSong {
                        return song.path
                    }
                }
            }
            
        }
        catch
        {
            print("ERROR")
            return nil
        }
        
        return nil
    }

    func gettingSongName()
    {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3"){
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count - 1]
                    mySong = mySong.replacingOccurrences(of: "_-_", with: " ")
                    mySong = mySong.replacingOccurrences(of: "_", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                    print(mySong)
                   
                }
            }
            myTableView!.reloadData()
        }
        catch
        {
            print("ERROR")
        }
    }
    @IBAction func play(_ sender: Any)
    {
        if isPaused == true {
            audioPlayer.play()
            isPaused = false
        } else {
            return
        }
        
    }
    @IBAction func pause(_ sender: Any)
    {
        audioPlayer.pause()
        isPaused = true
    }
    @IBAction func restart(_ sender: Any)
    {
        return
        // For test REMEMBER TO REMOVE
    }
    
    
    
}

