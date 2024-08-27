//
//  WaklKingPathWidget.swift
//  WaklKingPathWidget
//
//  Created by student on 2024/08/27.
//

import WidgetKit
import SwiftUI

//provider -> sets up our entry point and timeline for when to refresh
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        //getting widget data
        let userDefaults = UserDefaults(suiteName: "group.co.za.openwindow.walking-path")
        let totalSteps = userDefaults?.double(forKey: "totalSteps")
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, steps: totalSteps?.rounded(.towardZero) ?? 0)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

//model of our widget data
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    var steps: Double = 0 //default == 0
}

//SwiftUI View, what we see on the widget
struct WaklKingPathWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily // represents all the different widget types

    var body: some View {
        
        switch widgetFamily {
        case .systemSmall:
            VStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(5)
                
                //display time
                Text("Today")
                Text(entry.date, style: .date)
            }
            
        case .systemMedium:
            HStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(5)
                
                //display time
                Text(entry.date, style: .date)
            }
            
        case .systemLarge:
            VStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(5)
                
                //display time
                Text("Today")
                Text(entry.date, style: .date)
            }
            
        case .systemExtraLarge:
            VStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(5)
                
                //display time
                Text("Today")
                Text(entry.date, style: .date)
            }
            
        case .accessoryCircular:
            VStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps)")
                    .font(.headline)
                    .padding(5)
            }
            
        case .accessoryRectangular:
            HStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(2)
            }
            
        case .accessoryInline:
            HStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(5)
            }
            
        @unknown default:
            VStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                
                Text("\(entry.steps) Steps")
                    .font(.headline)
                    .padding(5)
                
                //display time
                Text("Today")
                Text(entry.date, style: .date)
            }
            
        }
        
    }
}

struct WaklKingPathWidget: Widget {
    let kind: String = "WaklKingPathWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WaklKingPathWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) { //<-- change preview
    WaklKingPathWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
