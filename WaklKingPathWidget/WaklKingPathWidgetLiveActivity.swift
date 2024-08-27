//
//  WaklKingPathWidgetLiveActivity.swift
//  WaklKingPathWidget
//
//  Created by student on 2024/08/27.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WaklKingPathWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WaklKingPathWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WaklKingPathWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WaklKingPathWidgetAttributes {
    fileprivate static var preview: WaklKingPathWidgetAttributes {
        WaklKingPathWidgetAttributes(name: "World")
    }
}

extension WaklKingPathWidgetAttributes.ContentState {
    fileprivate static var smiley: WaklKingPathWidgetAttributes.ContentState {
        WaklKingPathWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WaklKingPathWidgetAttributes.ContentState {
         WaklKingPathWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WaklKingPathWidgetAttributes.preview) {
   WaklKingPathWidgetLiveActivity()
} contentStates: {
    WaklKingPathWidgetAttributes.ContentState.smiley
    WaklKingPathWidgetAttributes.ContentState.starEyes
}
