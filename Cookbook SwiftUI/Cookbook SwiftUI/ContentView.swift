//
//  ContentView.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        print("date: ", Date())
    }

    var body: some View {
        NavigationStack {
            List {
                chap1
                chap2
                chap3
                chap4
                chap5
                chap7
                chap9
                chap10
                chap11
                chap12
                chap14
                chap100
            }
            .listStyle(.grouped)
        }
    }
    
    var chap1: some View {
        Section {
            NavigationLink("The Stacks") {
                TheStacks()
            }
            NavigationLink("Formatted Text") {
                FormattedText()
            }
            NavigationLink("Buttons") {
                Buttons()
            }
            NavigationLink("Pickers") {
                Pickers()
            }
            NavigationLink("View Modifiers") {
                ViewModifiers()
            }
            NavigationLink("View Builder") {
                ViewBuilders()
            }
            NavigationLink("SFSymbols") {
                SFSymbols()
            }
            NavigationLink("UIKit To SwiftUI") {
                UIKitToSwiftUI()
            }
            NavigationLink("More Views And Controls") {
                MoreViewsAndControls()
            }
        } header: {
            Text("Basic Views & Controls")
        }
    }
    
    var chap2: some View {
        Section {
            NavigationLink("Scroll View") {
                ScrollViews()
            }
            NavigationLink("Static List") {
                StaticList()
            }
            NavigationLink("Searchable List") {
                SearchableList()
            }
        } header: {
            Text("Scrollable Content")
        }
    }
    
    var chap3: some View {
        Section {
            NavigationLink("Lazy Stacks") {
                LazyStacks()
            }
            NavigationLink("Lazy Grids") {
                LazyGrids()
            }
            NavigationLink("ScrollView Readers") {
                ScrollViewReaders()
            }
            NavigationLink("Expanding Lists") {
                ExpandingLists()
            }
            NavigationLink("Disclosure Groups") {
                DisclosureGroups()
            }
            NavigationLink("ToDoList for Widgets") {
                ToDoList()
            }
        } header: {
            Text("Advanced Components")
        }
    }
    
    var chap4: some View {
        Section {
            NavigationLink("Scroll View") {
                ScrollViews()
            }
            NavigationLink("Static List") {
                StaticList()
            }
            NavigationLink("Searchable List") {
                SearchableList()
            }
        } header: {
            Text("Preview")
        }
    }
    
    var chap5: some View {
        Section {
            NavigationLink("Sign Up View") {
                SignUpView()
            }
            NavigationLink("Focus And Submit") {
                FocusAndSubmit()
            }
            NavigationLink("Multi Column Table") {
                MultiColumnTable()
            }
            NavigationLink("Two Dimensional Layout") {
                TwoDimensionalLayout()
            }
        } header: {
            Text("New Components and Grouping Views with Container Views")
        }
    }
    
    var chap7: some View {
        Section {
            NavigationLink("Simple Navigation") {
                SimpleNavigation()
            }
            NavigationLink("Modern Navigation") {
                ModernNavigation()
            }
            NavigationLink("Multi-column Navigation") {
                MultiColumnNavigation()
            }
            NavigationLink("TabViews") {
                TabViews()
            }
        } header: {
            Text("Navigation Containers")
        }
    }
    
    var chap9: some View {
        Section {
            NavigationLink("Basic Animations") {
                BasicAnimations()
            }
            NavigationLink("Animate Triangle Shape") {
                AnimateTriangleShape()
            }
            NavigationLink("Banner With A Spring Animation") {
                BannerWithASpringAnimation()
            }
            NavigationLink("Delayed Animations") {
                DelayedAnimations()
            }
            NavigationLink("Delayed Animations (Buttons)") {
                DelayedButtonsAnimations()
            }
            NavigationLink("Multiple Animations") {
                MultipleAnimations()
            }
            NavigationLink("Chained Animations") {
                ChainedAnimations()
            }
            NavigationLink("Custom Animations") {
                CustomAnimations()
            }
            NavigationLink("Custom View Transition") {
                CustomViewTransition()
            }
            NavigationLink("Hero View Transition") {
                HeroViewTransition()
            }
            NavigationLink("Stretchable Header") {
                StretchableHeader()
            }
            NavigationLink("Swipeable Cards") {
                SwipeableCards()
            }
        } header: {
            Text("Animating")
        }
    }
    
    var chap10: some View {
        Section {
            NavigationLink("Static Todo List") {
                StaticTodoList()
            }
            NavigationLink("CoreLocation") {
                SwiftUICoreLocation(locationManager: LocationManager())
            }
            NavigationLink("Counter") {
                Counter()
            }
            NavigationLink("MusicPlayer") {
                MusicPlayerView()
            }
            NavigationLink("Reminders") {
                Reminders()
            }
            
            
        } header: {
            Text("Driving SwiftUI with Data")
        }
    }
    var chap11: some View {
        Section {
            NavigationLink("Combine CoreLocation") {
                CombineCoreLocationView()
            }
            NavigationLink("StopWatch") {
                StopWatch()
            }
//            NavigationLink("FormValidation") {
//                FormValidation()
//            }
        } header: {
            Text("Driving SwiftUI with Combine")
        }
    }
    var chap12: some View {
        Section {
            NavigationLink("AsyncAwait") {
                AsyncAwaitSwiftUI()
            }
            NavigationLink("Infinite Scrolling") {
                InfiniteScrolling()
            }
        } header: {
            Text("Concurrency")
        }
    }
    
    var chap14: some View {
        Section {
            NavigationLink("SwiftUI CoreData Stack") {
                SwiftUICoreDataStack()
            }
            NavigationLink("Infinite Scrolling") {
                InfiniteScrolling()
            }
        } header: {
            Text("Data")
        }
    }
    
    var chap100: some View {
        Section {
            NavigationLink("Pinch To Zoom") {
                PinchToZoom()
            }
        } header: {
            Text("Gesture")
        }
    }
}

#Preview {
    ContentView()
}

extension Item {
    static let data = [
        Item(image: "california", title: "California", details: "California, the most populous state in the United States and the third most extensive by area, is located on the western coast of the USA and is bordered by Oregon to the north, Nevada, to the east and northeast, Arizona to the southeast and it shares an international border with the Mexican state of Baja California to the south."),
        Item(image: "miami", title: "Miami", details: "Miami is an international city at Florida’s south-eastern tip. Its Cuban influence is reflected in the cafes"),
        Item(image: "las-vegas", title: "Las Vegas", details: "Las Vegas, is a resort city famed for its vibrant nightlife, centered around 24-hour casinos and other entertainment options. Its main street and focal point is the Strip, just over 4 miles long.Nevada is a western U.S. state defined by its great expanses of desert, and by the 24-hour casinos and entertainment for which its largest city, Las Vegas, in Nevada’s Mojave Desert."),
        Item(image: "paris", title: "Paris", details: "Paris is the capital and most-populous city of France. Situated on the Seine River, in the north of the country, it is in the centre of the Île-de-France region, also known as the région parisienne. Paris has an area of 105.4 square kilometres and with a population of 2,273,305 people within its city limits is the most populous urban area in the European Union."),
        Item(image: "dublin", title: "Dublin", details: "Dublin, capital of the Republic of Ireland, is on Ireland’s east coast at the mouth of the River Liffey. Its medieval buildings include 13th-century Dublin Castle and imposing St. Patrick’s Cathedral, founded in 1191. Temple Bar is a riverside nightlife and cultural quarter, home to the Irish Film Institute. Bustling, largely pedestrianised Grafton Street is the city’s principal shopping area, also famed for its buskers."),
        Item(image: "bali", title: "Bali", details: "Bali “the world’s best island resort” with its enchanting culture, beaches, dynamic dances and music, with grand mountain views, green rainforests to trek through, rolling waves to surf and deep blue pristine seas to dive in where one can swim with dugongs, dolphins and large mantarays. Covering less than 6,000 square kilometers, this lush isle has startling geographical contrasts; verdant rice terraces and sacred, mist-wreathed volcanoes, white-sand beaches and dense tropical rain forest. as well as being home to one of the world’s most vibrant cultures of  dance and music, lavish ceremonies and artistic achievements."),
        Item(image: "singapore", title: "Singapore", details: "Singapore, an island city-state off southern Malaysia, is a bustling cosmopolitan city that offers a world-class living environment, with a landscape populated by high-rise buildings and gardens, and is a great place to visit for a couple of days if you are travelling to Asia. In circa-1820 Chinatown stands the red-and-gold Buddha’s Tooth Relic Temple, Little India offers colourful souvenirs and Arab Street is lined with fabric shops. Singapore is also known for eclectic street fare, served in hawker centres such as Tiong Bahru and Maxwell Road.")

    ]
}
