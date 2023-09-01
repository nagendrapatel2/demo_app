//
//  UserView.swift
//  DemoApp
//
//  Created by Nagendra on 31/08/23.
//

import SwiftUI
struct UserView: View {
    var user: User
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: user.profilePicture),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 50, maxHeight: 50)
                        .clipShape(Circle())
                },
                placeholder: {
                    ProgressView()
                        .frame(maxWidth: 50, maxHeight: 50)
                }
            )
            VStack (alignment: .leading){
                Text(user.firstName + " " +  user.lastName)
                    .font(Font.headline)
                Text(user.phone )
                    .font(Font.subheadline)
            }
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User.preview)
    }
}
