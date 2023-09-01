//
//  UserDetailView.swift
//  DemoApp
//
//  Created by Nagendra on 31/08/23.
//

import SwiftUI
struct UserDetailView: View {
    let selectedUser: User
    var body: some View {
        Form {
            UserView(user: selectedUser)
            VStack (alignment: .leading ,spacing: 10){
                Text("ID : \(selectedUser.id)")
                Text("Job : " +  selectedUser.job)
                Text("Email : " +  selectedUser.email)
                Text("Gender : " +  selectedUser.gender.rawValue)
                Text("Street : " +  selectedUser.street)
                Text("City : " +  selectedUser.city)
                Text("Zipcode : " +  selectedUser.zipcode)
                Text("Country : " +  selectedUser.country)
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(selectedUser: User.preview)
    }
}
