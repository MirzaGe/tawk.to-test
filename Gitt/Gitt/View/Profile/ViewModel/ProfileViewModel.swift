//
//  ProfileViewModel.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Combine
import CoreData
import Foundation
import RxCocoa
import RxSwift

/**
 Protocol of `ProfileViewModel`.
 */
protocol ProfileDelegate: BaseViewModelDelegate {
    /// Dismiss or pop the controller
    func closeProfile()
}

/**
 The viewmodel that the `ProfileViewController` owns.
 */
class ProfileViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: ProfileDelegate?
    private var user: User!

    // MARK: Outputs
    
    /// Determines the state of shimmer
    var startShimmer = BehaviorRelay<Bool>(value: true)
    var imageBanner = BehaviorRelay<UIImage?>(value: nil)

    var followersPresentable = BehaviorRelay<String>(value: "Followers")
    var followingPresentable = BehaviorRelay<String>(value: "Following")
    var namePresentable = BehaviorRelay<String>(value: "Name: ")
    var companyPresentable = BehaviorRelay<String>(value: "Company: ")
    var blogPresentable = BehaviorRelay<String>(value: "Blog: ")
    var notesPresentable = BehaviorRelay<String>(value: "Notes...")
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Functions
    
    /// Put the data to the behavior relays.
    private func getPresentables() {
        if self.user == nil { return }
        
        self.followersPresentable.accept("Followers: \(self.user.followers)")
        self.followingPresentable.accept("Following: \(self.user.following)")
        self.namePresentable.accept("Name: \(self.user.name ?? "")")
        self.companyPresentable.accept("Company: \(self.user.company ?? "")")
        self.blogPresentable.accept("Blog: \(self.user.blog ?? "")")
        
        // Image Loader...
        let imageLoader = ImageLoader.shared.loadImage(from: URL(string: self.user.avatarUrl ?? "")!)
        self.cancellable = imageLoader.sink { [weak self] image in
            self?.imageBanner.accept(image)
        }
        
        // Note from different entity.
        let note = self.user.note?.userNote ?? ""
        self.notesPresentable.accept(note)
    }
    
    /// Fetch objects from Core Data for offline mode.
    override func loadOfflineData() {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let userid = "\(Int(self.user.id))"
        let predicate = NSPredicate(format: "id == \(userid)")
        fetchRequest.predicate = predicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            self.user = users.first
            self.getPresentables()
        } catch let error {
            print(error)
        }
    }
    
    /// Call API to get more user data
    private func loadData() {
        self.startShimmer.accept(true)

        let username = self.user.login ?? ""
        
        self.startShimmer.accept(false)

        // We can always load the offline data.
        // Since we're handling a new user data below...
        self.loadOfflineData()
        
            
        // No need to put this in operation queue I suppose.
        // Since this only gets called once, and we don't have a pull-to-refresh
        // in this screen.
//        APIManager.GetUser(username: username).execute { (result) in
//            self.startShimmer.accept(false)
//
//            switch result {
//            case let .success(user):
//                // Before we apply a fresh user,
//                // Take note of the note object...
//                let note = self.user.note
//
//                self.user = user as User
//
//                self.user.note = note
//
//                // Save to local db.
//                CoreDataStack.shared.saveContext()
//
//                self.getPresentables()
//
//            case let .failure(error):
//                self.showError(error)
//            }
//        }
    }
    
    // MARK: Events
    
    func save() {
        if self.user.note == nil {
            let newNote = Note(context: CoreDataStack.shared.persistentContainer.viewContext)
            newNote.user = self.user
            newNote.userNote = self.notesPresentable.value
            self.user.note = newNote
        } else {
            self.user.note?.userNote = self.notesPresentable.value
        }
        
        CoreDataStack.shared.saveContext()
        
        
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let newLoginId = "\(Int(self.user.id))"
        let predicate = NSPredicate(format: "id == \(newLoginId)")
        fetchRequest.predicate = predicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            self.user = users.first
            self.getPresentables()
        } catch let error {
            print(error)
        }
        
        self.showAlert("Saved!")
    }
    
    // MARK: Overrides
    
    override func refresh() {
        self.loadData()
    }
    
    init(profileController: ProfileDelegate?, user: User) {
        super.init()
        
        self.delegate = profileController
        self.user = user
        self.loadData()
    }
    
    func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self)
        self.cancellable?.cancel()
    }
}
