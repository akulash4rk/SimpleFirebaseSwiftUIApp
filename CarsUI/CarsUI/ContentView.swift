import SwiftUI


struct ContentView: View {
    
    @State private var cars: [Company] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cars) { car in
                    NavigationLink(
                        destination: ModelsView(car: car),
                        label: {
                            Text(car.car!)
                        }
                    )
                }
                .onDelete(perform: deleteItems)
            }
            .onAppear{
                Task {
                    do {
                        APIManager.shared.getMarks(){ result in
                            cars = result
                        }
                    }
                }
            }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Car", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("Cars")
            }
            
        }
    
    private func deleteItems(offsets: IndexSet) {
        cars.remove(atOffsets: offsets)
    }
    
    private func addItem() {
        
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


