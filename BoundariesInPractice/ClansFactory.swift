//
//  ClansFactory.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 15/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import SwiftyJSON
import BrightFutures
import Result
import Alamofire

/**
 Clan json representation
 
 {
 "members_count": 90,
 "name": "QBs Special Forces",
 "color": "#27662D",
 "created_at": 1358106810,
 "tag": "QSF",
 "emblems": {
 "x32": {
 "portal": "http://eu.wargaming.net/clans/media/clans/emblems/cl_963/500017963/emblem_32x32.png"
 },
 "x24": {
 "portal": "http://eu.wargaming.net/clans/media/clans/emblems/cl_963/500017963/emblem_24x24.png"
 },
 "x256": {
 "wowp": "http://eu.wargaming.net/clans/media/clans/emblems/cl_963/500017963/emblem_256x256.png"
 },
 "x64": {
 "wot": "http://eu.wargaming.net/clans/media/clans/emblems/cl_963/500017963/emblem_64x64_tank.png",
 "portal": "http://eu.wargaming.net/clans/media/clans/emblems/cl_963/500017963/emblem_64x64.png"
 },
 "x195": {
 "portal": "http://eu.wargaming.net/clans/media/clans/emblems/cl_963/500017963/emblem_195x195.png"
 }
 },
 "clan_id": 500017963
 }
 
*/
struct Clan {
    let id:Int
    let membersCount:Int
    let color: String
    let name : String
    let tag : String
    let emblemUrl : NSURL
    
    init(json:JSON) throws {
        self.id = json["clan_id"].intValue
        self.membersCount = json["members_count"].intValue
        self.color = json["color"].stringValue
        self.name = json["name"].stringValue
        self.tag = json["tag"].stringValue
        self.emblemUrl = NSURL(string: json["emblems"]["x256"]["wowp"].stringValue.stringByReplacingOccurrencesOfString("http", withString: "https"))!
    }
    
}

enum AppErrors : ErrorType {
    case ConvertionError
}

class ClansFactory {
    
    func makeClan(json:JSON) throws -> Clan {
        do {
            let clan = try Clan(json: json)
            return clan
        }
        catch (let error) {
            throw error
        }
    }
    
    func makeClans(input:JSON, output:[Clan]) -> [Clan] {
        if input[0] != nil {
            let head = input[0]
            var json = input.arrayValue
            var out = output
            json.removeAtIndex(0)
            do {
                try out.append(makeClan(head))
            }
            catch(_){
                
            }
            
            return makeClans(JSON(json), output: out)
        }
        else{
            return output
        }
    }
    
    func create(json:JSON) -> [Clan] {
        return makeClans(json, output: [Clan]())
    }
    
}