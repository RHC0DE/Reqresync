//
//  Reqresync
//

import SwiftUI

struct PersonDetailView: View {
    
    @State private var userDetailInfo: UserDetailResponse?
    
    var body: some View {
        
            ZStack {
                BackgroundcolorView()
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        avatarBackgroundImage
                        
                        Group {
                            generalUserInfo
                            supportSection
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Colors.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                    }
                    .padding()
                    
                }
                
            }
            .navigationTitle(Strings.navigationTitleDetails)
            .onAppear {
                
                do {
                    self.userDetailInfo = try StaticJSONMapper.decode(file: "UserStaticData", type: UserDetailResponse.self)
                } catch {
                    // TODO: Handle any erros
                    print(error)
                }
                
            }
            
        
    }
}

#Preview {
    
    NavigationView {
        PersonDetailView()
    }
    
}

private extension PersonDetailView {
    
    @ViewBuilder
    var avatarBackgroundImage: some View {
        if let avatarAbsoluteString = userDetailInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16,
                                        style: .continuous))
            
        }
    }
    
    var generalUserInfo: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            PillView(id: userDetailInfo?.data.id ?? 0)
            
            Group {
                
                firstNameSection
                
                lasttNameSection
                
                emailSection
            }
            .foregroundStyle(Colors.textColor)
            
        }

    }

    @ViewBuilder
    var firstNameSection: some View {
        
        Text(Strings.firstNameLabel)
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userDetailInfo?.data.firstName ?? "Failed to load Fist Name!")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
        
    }
    
    @ViewBuilder
    var lasttNameSection: some View {
        
        Text(Strings.lastNameLabel)
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userDetailInfo?.data.lastName ?? "Failed to load Last Name!")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
        
    }
    
    @ViewBuilder
    var emailSection: some View {
        
        Text(Strings.emailLabel)
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userDetailInfo?.data.email ?? "Failed to load email!")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
    }
    
    
    @ViewBuilder
    var supportSection: some View {
        
        // If the user is retrieving the url en text Support data then the View get's shown in the UI
        
        if let supportAbsoluteString = userDetailInfo?.support.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportTxt = userDetailInfo?.support.text {
            
            Link(destination: supportUrl) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(supportTxt)
                        .foregroundStyle(Colors.textColor)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                        .multilineTextAlignment(.leading)
                
                    Text(supportAbsoluteString)
                    
                }
                
                Spacer()
                
                Symbols
                    .link
                    .font(.system(.title3, design: .rounded))

            }
            
        }
        
    }
}
