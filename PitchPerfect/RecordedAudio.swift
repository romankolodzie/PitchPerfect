//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Roman Kolodzie on 2/24/16.
//  Copyright © 2016 RomanKolodzie. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathURL: NSURL!
    var title: String!
    
    init(filePathURL: NSURL, title: String){
        self.filePathURL = filePathURL
        self.title = title
    }
    
}