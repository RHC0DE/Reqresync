//
//  Reqresync
//

import SwiftUI

@main
struct ReqresyncApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            TabView {
                
                PeopleView()
                    .tabItem {
                        
                        Symbols.person
                        Text(Strings.peopleTabLabel)
                        
                    }
                
                SettingsView()
                    .tabItem {
                        
                        Symbols.gear
                        Text(Strings.settingsTabLabel)
                        
                    }
                
            }
            
        }
        
    }
}
