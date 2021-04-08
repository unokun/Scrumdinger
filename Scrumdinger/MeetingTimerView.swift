//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Masaaki Uno on 2021/04/07.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpekers: Int
    
    private var degreePerSpecker: Double {
        360.0 / Double(totalSpekers)
    }
    private var startAngle: Angle {
        Angle(degrees: degreePerSpecker * Double(speakerIndex) + 1.0)
    }
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreePerSpecker - 1.0)
    }
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.origin.x + rect.size.width / 2.0,
                             y: rect.origin.y + rect.size.height / 2.0)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
    
}

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    var scrumColor: Color
    private var currentSpeaker: String { speakers.first(where: { !$0.isCompleted })?.name ?? "someone" }
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            VStack {
                Text(currentSpeaker)
                    .font(.title)
                Text("is speaking")

            }
            .accessibilityElement(children: .combine)
            .foregroundColor(scrumColor.accessibleFontColor)
            ForEach(speakers) { speaker in
                if speaker.isCompleted,
                let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                    SpeakerArc(speakerIndex: index, totalSpekers: speakers.count)
                        .rotation(Angle(degrees: -90))
                        .stroke(scrumColor, lineWidth: 12)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers = [ScrumTimer.Speaker(name: "Kim", isCompleted: false), ScrumTimer.Speaker(name: "Bill", isCompleted: false)]
    static var previews: some View {
        MeetingTimerView(speakers: speakers, scrumColor: Color("Design"))
    }
}
