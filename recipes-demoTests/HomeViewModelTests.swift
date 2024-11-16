import XCTest
@testable import DEV_recipes_demo

final class HomeViewModelTests: XCTestCase {
    private var viewModel = HomeViewModel()
    
    // use @MainActor to ensure main thread updates execute before checking state
    @MainActor
    func test_ValidRecipeLoads() async throws {
        let recipes = viewModel.recipes
        await viewModel.loadRecipes(type: .all)
        XCTAssertGreaterThan(viewModel.recipes.count, recipes.count)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertNil(viewModel.alertError)
        
        addTeardownBlock {
            self.viewModel.recipes = []
        }
    }
    
    @MainActor
    func test_MalformedRecipeLoads() async throws {
        let recipes = viewModel.recipes
        await viewModel.loadRecipes(type: .malformed)
        XCTAssertEqual(viewModel.recipes.count, recipes.count)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertNotNil(viewModel.alertError)
        
        let apiError = viewModel.alertError as? ApiError
        XCTAssertNotNil(apiError)
        
        let isUnexpectedApiError: Bool = {
            if case .Unexpected(description: _) = apiError { return true }
            else { return false }
        }()
        XCTAssert(isUnexpectedApiError)
        
        addTeardownBlock {
            self.viewModel.recipes = []
        }
    }
    
    @MainActor
    func test_EmptyRecipeLoads() async throws {
        await viewModel.loadRecipes(type: .empty)
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertNil(viewModel.alertError)
        
        addTeardownBlock {
            self.viewModel.recipes = []
        }
    }
}
