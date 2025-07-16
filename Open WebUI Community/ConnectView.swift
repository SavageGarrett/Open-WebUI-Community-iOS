import SwiftUI

struct ConnectView: View {
    @State private var serverAddress: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text("Enter Server Address")
                        .font(.title)
                    
                    TextField("e.g. https://192.168.0.1", text: $serverAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button("Connect") {
                        if isValidURL(serverAddress) {
                            // Attempt connection logic here
                            print("Connecting to: \(serverAddress)")
                            Task {
                                do {
                                    let response = try await ConfigRequest.shared.send(serverUrl: "http://garrett-w11:8080")
                                    print("✅ Connected to \(response.name), version \(response.version)")
                                } catch {
                                    print("❌ Failed to fetch config:", error)
                                }
                            }
                        } else {
                            showAlert = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding()
                .alert("Invalid URL", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Please enter a valid URL or IP address.")
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    func isValidURL(_ string: String) -> Bool {
        guard let url = URL(string: string) else { return false }
        return url.scheme != nil && url.host != nil
    }
}

#Preview {
    ConnectView()
}
