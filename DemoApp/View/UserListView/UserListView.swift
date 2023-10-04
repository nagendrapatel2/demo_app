//
//  UserListView.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import SwiftUI
struct UserListView: View {
    @StateObject  var userListViewModel : UserListViewModel
    var body: some View {
        switch userListViewModel.state {
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(errorMessage: userListViewModel.getErrorMessage(for: error)).accessibilityIdentifier("errorView")
        case .loaded:
            UserListViewContent(userListViewModel: userListViewModel).accessibilityIdentifier("userViewContent")
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

extension UserListView {
    init() {
#if DEBUG
        if UITestingHelper.isUITesting {
            
            let mockData = UITestingHelper.isNetworkSuccess ? MockUserListService() :MockUserListService(resultForResponse: .failure(APIError.invalidURL))
            
            _userListViewModel = StateObject(wrappedValue: UserListViewModel(userListWebService: mockData))
        }
        else if UITestingHelper.isPreview {
            _userListViewModel = StateObject(wrappedValue: UserListViewModel(userListWebService: MockUserListService()))
            
        }else{
            _userListViewModel = StateObject(wrappedValue: UserListViewModel())
        }
#else
        _userListViewModel = StateObject(wrappedValue: UserListViewModel())
#endif
    }
}
