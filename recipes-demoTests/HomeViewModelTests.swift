import XCTest
@testable import DEV_recipes_demo

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ValidRecipeLoads() async throws {
        let recipes = viewModel.recipes
        await viewModel.loadRecipes(type: .all)
        XCTAssertGreaterThan(viewModel.recipes.count, recipes.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
