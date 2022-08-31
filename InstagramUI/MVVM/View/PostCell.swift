//
//  PostCell.swift
//  InstagramFeed
//
//  Created by Stephen Dowless on 2/27/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    let post: Feed
    
    @State var liked = false
    @State var saveFeed = false
    
    var header: some View {
        HStack {
            Image("avtar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(post.username).font(.system(size: 14)).bold()
                Text(post.location).font(.system(size: 12)).foregroundColor(.gray.opacity(0.6))
            }
            
            Spacer()
            
            Image(systemName: "ellipsis").padding()
                .rotationEffect(.degrees(90))
        }
    }
    
    var actionButtons: some View {
        HStack {
            Image(systemName: self.liked ? "heart.fill" : "heart")
               
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(self.liked ? .red : Color(.label))
                .onTapGesture {
                    self.liked.toggle()
                }
            .padding(.init(top: 0, leading: 12, bottom: 0, trailing: 8))
            
            Image(systemName: "bubble.left")
            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            Image(systemName: "paperplane")
            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            Spacer()
            
            Image(systemName: self.saveFeed ? "bookmark.fill" : "bookmark")
            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            .onTapGesture {
                self.saveFeed.toggle()
            }
            
        }
        .font(.system(size: 21, weight: .light))
        .padding([.top, .bottom])
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var textContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Group {
                Text("\(post.username) ").font(.system(size: 14)).bold() +
                    Text(post.caption).font(.system(size: 14))
            }
            .padding([.leading, .trailing])
            
            Text("41 minutes ago")
                .foregroundColor(Color(.systemGray2))
                .font(.system(size: 14))
                .padding([.leading, .trailing])
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var body: some View {
        VStack {
            header
            
            AsyncImage(url: URL(string: post.imageurl)!,
                          placeholder: { Text("Loading ...") },
                       image: { Image(uiImage: $0)
                .resizable()
             })
                .frame(width:UIScreen.main.bounds.width, height: 250, alignment: .center) // 2:3 aspect ratio
                .aspectRatio( contentMode: .fill)
                .background(.gray.opacity(0.2))
            
            actionButtons
            
            textContent
            
            Spacer()
        }
    }
}
