//
//  widget.swift
//  widget
//
//  Created by Yohey Kuwa on 2023/03/26.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        iTunesStyle()
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct iTunesStyle: View{
    let gradient1 = LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.8), .gray.opacity(0.3), .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack{
            gradient1
            Image("brushedMetal")
                .resizable()
                .blur(radius: 1)
                .blendMode(.softLight)
            VStack{
                VStack{
                    Text("Now Playing")
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(.chicagoText)
                        .shadow(color: .chicagoText, radius: 1)
                    
                    ZStack{
                        Capsule()
                            .foregroundColor(.chicagoBG)
                            .frame(height: 100)
                            .shadow(radius: 2, y: -4)
                            .shadow(color: .white.opacity(0.8), radius: 2, y: 4)
                        
                        Text("Out Of Time - The Weeknd")
                            .font(.title3)
                            .lineLimit(1)
                            .foregroundColor(.chicagoText)
                            .shadow(color: .chicagoText, radius: 1)
                            .padding()
                    }
                }
                .padding(.bottom)
                
                if widgetFamily == .systemLarge{
                    Spacer()
                    ///Text("Now Playing")
                        ///.fontWeight(.bold)
                        ///.lineLimit(1)
                        ///.foregroundColor(.chicagoText)
                        ///.shadow(color: .chicagoText, radius: 1)
                        ///.padding(5)
                    
                    ZStack{
                        ContainerRelativeShape()
                            .foregroundColor(.white)
                            .shadow(radius: 2, y: -4)
                            .shadow(color: .white.opacity(0.8), radius: 2, y: 4)
                        Image("dawnFM small")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(4)
                            ///.clipShape(ContainerRelativeShape())
                            .shadow(radius: 4)
                            .padding()

                    }
                    ///.padding()
                }
            }
            .padding()
           
        }
    }
}

struct WinXP: View{
    @Environment(\.widgetFamily) var widgetFamily
    let gradient1 = LinearGradient(gradient: Gradient(colors: [.white.opacity(0.5), .black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    let padding1: CGFloat = 2
    
    var body: some View{
        GeometryReader { geo in
            ZStack{
                Image("WinXP BG")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                VStack{
                    ZStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.winXP_BG)
                                .cornerRadius(5)
                                .shadow(radius: padding1)
                            gradient1
                                .blur(radius: padding1)
                                .padding(padding1)
                            Rectangle()
                                .foregroundColor(.winXP_BG)
                                .padding(padding1)
                                .blur(radius: padding1)
                        }
                        
                        Text("Win")
                            .font(.custom("Baskerville", size: 18))
                            .fontWeight(.bold)
                    }
                }
                .padding(50)
            }
        }
    }
}
