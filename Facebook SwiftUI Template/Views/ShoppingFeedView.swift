import SwiftUI

// MARK: - Shopping Product Model

struct ShoppingProduct: Hashable, Identifiable {
    var id = UUID()
    var imageName: String
    var price: String
    var title: String
    var rating: String
    var reviewCount: String
}

// Sample product data extracted from the BPN shopping unit
let shoppingProducts = [
    ShoppingProduct(imageName: "product1", price: "$45", title: "Flight Pre-Workout - Fruit Punch", rating: "4.8", reviewCount: "2.3K"),
    ShoppingProduct(imageName: "product2", price: "$52", title: "Whey Protein Isolate - Vanilla", rating: "4.9", reviewCount: "5.1K"),
    ShoppingProduct(imageName: "product3", price: "$38", title: "Endopump - Blue Raspberry", rating: "4.7", reviewCount: "1.8K"),
    ShoppingProduct(imageName: "product4", price: "$49", title: "Strong Greens Superfood", rating: "4.6", reviewCount: "980"),
    ShoppingProduct(imageName: "product5", price: "$55", title: "Whey Protein Isolate - Chocolate", rating: "4.9", reviewCount: "4.2K"),
    ShoppingProduct(imageName: "product6", price: "$42", title: "Flight Pre-Workout - Green Apple", rating: "4.8", reviewCount: "1.9K"),
    ShoppingProduct(imageName: "product7", price: "$48", title: "Strong Amino - Watermelon", rating: "4.7", reviewCount: "1.4K"),
    ShoppingProduct(imageName: "product8", price: "$39", title: "Endopump - Tropical Thunder", rating: "4.6", reviewCount: "1.1K"),
    ShoppingProduct(imageName: "product9", price: "$44", title: "Intra-Flight - Citrus", rating: "4.8", reviewCount: "890")
]

// MARK: - Shopping Feed View

struct ShoppingFeedView: View {
    @Environment(\.dismiss) private var dismiss
    let brandName: String
    let products: [ShoppingProduct]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Navigation Bar
                HStack(alignment: .center, spacing: 12) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("chevron-left-filled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("primaryIcon"))
                    }
                    .buttonStyle(FDSPressedState(cornerRadius: 8, padding: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)))
                    
                    Text("Similar products")
                        .headline3Typography()
                        .foregroundColor(Color("primaryText"))
                    
                    Spacer()
                    
                    FDSIconButton(icon: "magnifying-glass-outline", action: {})
                    FDSIconButton(icon: "dots-3-horizontal", size: .size20, color: .secondary, action: {})
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color("surfaceBackground"))
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color("wash"))
                
                // Brand Header
                HStack(alignment: .center, spacing: 12) {
                    Image("bpn-logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(brandName)
                            .headline3Typography()
                            .foregroundColor(Color("primaryText"))
                        
                        Text("Health & wellness • Sponsored")
                            .body4Typography()
                            .foregroundColor(Color("secondaryText"))
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color("surfaceBackground"))
                
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(Color("wash"))
                
                // Products Grid
                LazyVStack(spacing: 2) {
                    ForEach(Array(products.enumerated()), id: \.element.id) { index, product in
                        ProductCard(product: product)
                        
                        if index < products.count - 1 {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("wash"))
                        }
                    }
                }
            }
        }
        .background(Color("surfaceBackground"))
        .navigationBarHidden(true)
    }
}

// MARK: - Product Card

struct ProductCard: View {
    let product: ShoppingProduct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Product Image
            Button(action: {}) {
                if UIImage(named: product.imageName) != nil {
                    Image(product.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 360)
                        .clipped()
                } else {
                    // Fallback placeholder
                    Rectangle()
                        .fill(Color("cardBackgroundFlat"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 360)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 60))
                                .foregroundColor(Color("secondaryIcon"))
                        )
                }
            }
            .buttonStyle(FDSPressedState(cornerRadius: 0))
            
            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                // Price
                Text(product.price)
                    .headline2EmphasizedTypography()
                    .foregroundColor(Color("primaryText"))
                
                // Title
                Text(product.title)
                    .body3Typography()
                    .foregroundColor(Color("primaryText"))
                    .lineLimit(2)
                
                // Rating & Reviews
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("accentColor"))
                    
                    Text(product.rating)
                        .body4Typography()
                        .foregroundColor(Color("secondaryText"))
                    
                    Text("•")
                        .body4Typography()
                        .foregroundColor(Color("secondaryText"))
                    
                    Text("\(product.reviewCount) reviews")
                        .body4Typography()
                        .foregroundColor(Color("secondaryText"))
                }
                
                // Action Buttons
                HStack(spacing: 8) {
                    FDSButton(
                        type: .primary,
                        label: "Shop now",
                        size: .medium,
                        widthMode: .flexible,
                        action: {}
                    )
                    
                    FDSButton(
                        type: .secondary,
                        label: "Save",
                        icon: "bookmark-outline",
                        size: .medium,
                        widthMode: .constrained,
                        action: {}
                    )
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(Color("surfaceBackground"))
        }
    }
}

#Preview {
    NavigationStack {
        ShoppingFeedView(brandName: "Bare Performance Nutrition", products: shoppingProducts)
    }
}

