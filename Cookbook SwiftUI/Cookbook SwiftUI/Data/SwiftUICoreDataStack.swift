//
//  SwiftUICoreDataStack.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct SwiftUICoreDataStack: View {
    
    private let coreDataStack = CoreDataStack(modelName: "CoreDataStack")
    @AppStorage("appHasData") var appHasData = false
    
    var body: some View {
        CoreDataStackView()
            .environmentObject(coreDataStack)
            .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
            .onAppear {
                if !appHasData {
                    coreDataStack.addContacts()
                    appHasData = true
                }
            }
    }
}

#Preview {
    SwiftUICoreDataStack()
}

struct CoreDataStackView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var coreDataStack: CoreDataStack
    
    @FetchRequest(sortDescriptors: [
                NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
                NSSortDescriptor(keyPath: \Contact.firstName, ascending:true),
    ]
    )
    var contacts: FetchedResults<Contact>
    
    @State private var isAddContactPresented = false
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationStack {
            FilteredContacts(filter: searchText)            .listStyle(.plain)
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .toolbar {
                Button {
                    isAddContactPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
            .sheet(isPresented: $isAddContactPresented) {
                AddNewContact()
                    .environmentObject(coreDataStack)
            }
        }
    }
}

struct ContactView: View {
    
    let contact: Contact
    
    var body: some View {
        HStack {
            Text(contact.firstName ?? "-")
            Text(contact.lastName ?? "-")
            Spacer()
            Text(contact.phoneNumber ?? "-")
        }
    }
}

struct AddNewContact: View {
    
    @EnvironmentObject var coreDataStack: CoreDataStack
    @Environment(\.dismiss) private var dismiss
    @State var firstName = ""
    @State var lastName = ""
    @State var phoneNumber = ""
    
    private var isDisabled: Bool {
        firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                Spacer()
            }
            .padding(16)
            .navigationTitle("Add A New Contact")
            .toolbar {
                Button(action: saveContact) {
                    Image(systemName: "checkmark")
                        .font(.headline)
                }
                .disabled(isDisabled)
            }
        }
    }
    
    private func saveContact() {
        coreDataStack.insertContact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        coreDataStack.save()
        dismiss()
    }
}

struct FilteredContacts: View {
    
    let fetchRequest: FetchRequest<Contact>
    @EnvironmentObject var coreDataStack: CoreDataStack
    
    @SectionedFetchRequest<String, Contact>(
        sectionIdentifier: \.lastNameInitial,
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Contact.lastName, ascending: true),
            NSSortDescriptor(keyPath: \Contact.firstName, ascending: true),
        ],
        animation: .default
    )
    var sectionedContacts
    
    init(filter: String) {
        let predicate: NSPredicate? = filter.isEmpty ? nil :
        NSPredicate(format: "lastName BEGINSWITH[c] %@", filter)
        fetchRequest = FetchRequest<Contact>(
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Contact.lastName,
                                 ascending: true),
                NSSortDescriptor(keyPath: \Contact.firstName,
                                 ascending: true)
            ],
            predicate: predicate)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(sectionedContacts) { section in
                    Section(header: Text("Section for'\(section.id)'")) {
                        ForEach(section) {
                            ContactView(contact: $0)
                        }
                        .onDelete(perform: deleteContact)
                    }
                }
            }
            //        List {
            //            ForEach(fetchRequest.wrappedValue, id: \.self) {
            //                ContactView(contact: $0)
            //            }
            //            .onDelete(perform: deleteContact)
            //        }
            .listStyle(.plain)
        }

    }
    
    private func deleteContact(at offsets: IndexSet) {
        guard let index = offsets.first else {
    return }
        let contact = fetchRequest.wrappedValue[index]
        coreDataStack.deleteContact(contact)
        coreDataStack.save()
    }
    
}

extension Contact {
    @objc var lastNameInitial: String {
        get {
            String(lastName?.prefix(1) ?? "")
        }
    }
}
