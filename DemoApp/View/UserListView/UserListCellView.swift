//
//  UserListCellView.swift
//  DemoApp
//
//  Created by Nagendra on 31/08/23.
//

import SwiftUI

struct UserListCellView: View {
    var user: User
    var body: some View {
        NavigationLink(destination: UserDetailView(selectedUser: user)) {
            HStack {
                AsyncImage(
                    url: URL(string: user.profilePicture),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 50, maxHeight: 50)
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
}
