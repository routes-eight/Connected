import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseCore

struct ProfileView: View {
    @StateObject private var firestoreManager = FirestoreManager()
//    @State private var showProfileDetail = false
    @Binding var showProfileDetail: Bool
    @Binding var userId: String?

    var body: some View {
        ZStack {
            if let userProfile = firestoreManager.userProfile {
                HStack(spacing: -40) {
                    Button(action: {
                        showProfileDetail = true
                    }) {
                        if let profileImage = userProfile.profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 2)
                                }
                                .shadow(radius: 2)
                                .frame(width: 60, height: 60)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 2)
                                }
                                .shadow(radius: 1)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                        }
                    }
                    .zIndex(1.0)
                    .sheet(isPresented: $showProfileDetail) {
                        if let userId = userId {
                            ProfileDetail(userId: userId)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 1) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 110, height: 30)
                                .foregroundStyle(Color.black)
                            Text(userProfile.name)
                                .font(.headline)
                                .padding(.leading, 20.0)
                                .foregroundStyle(.white)
                                .truncationMode(.tail)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 100, height: 20)
                                .foregroundStyle(Color.white)
                            HStack(spacing: 2) {
                                Image(systemName: "bitcoinsign.circle")
                                    .resizable()
                                    .frame(width: 13, height: 13)
                                Text(userProfile.creditAmount)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 20.0)
                        }
                    }
                    .padding(.leading, 16)
                    Spacer()
                }
                .padding(.leading)
            }
//            else {
//                Text("Loading...")
//            }
        }
        .onAppear {
            if let userId = userId {
                firestoreManager.fetchUserProfile(userId: userId)
            }
        }
        //        .onAppear {
        //            if let user = Auth.auth().currentUser {
        //                userId = user.uid
        //                firestoreManager.fetchUserProfile(userId: userId!)
        //            } else {
        //                print("User is not logged in.")
        //            }
        //        }
    }
}

#Preview {
    @State var showProfileDetail = false
    @State var userId: String? = "sampleUserId"
    
    return ProfileView(showProfileDetail: $showProfileDetail, userId: $userId)
        .environmentObject(FirestoreManager()) // FirestoreManager가 @EnvironmentObject로 사용되는 경우
}
