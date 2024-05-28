//
//  DoYourThingsViewModelTests.swift
//  DoYourThingsTests
//
//  Created by RGMCode on 28.05.24.
//

import XCTest
@testable import DoYourThings

class DoYourThingsViewModelTests: XCTestCase {
    
    var viewModel: DoYourThingsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = DoYourThingsViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testAddDoYourThings() {
        // Given
        let initialCount = viewModel.doYourThings.count
        let newTopic = "Test Topic"
        let newDetails = "Test Details"
        let newPriority = "Normal"
        
        // When
        viewModel.addDoYourThings(dytTopic: newTopic, dytDetails: newDetails, dytPriority: newPriority)
        
        // Then
        XCTAssertEqual(viewModel.doYourThings.count, initialCount + 1, "Adding a new item should increase the count by 1")
        XCTAssertEqual(viewModel.doYourThings.last?.dytTopic, newTopic, "The last item in the list should have the expected topic")
        XCTAssertEqual(viewModel.doYourThings.last?.dytDetails, newDetails, "The last item in the list should have the expected details")
        XCTAssertEqual(viewModel.doYourThings.last?.dytPriority, newPriority, "The last item in the list should have the expected priority")
    }
    
    func testRemoveDoYourThings() {
        // Given
        let newTopic = "Test Topic"
        let newDetails = "Test Details"
        let newPriority = "Normal"
        viewModel.addDoYourThings(dytTopic: newTopic, dytDetails: newDetails, dytPriority: newPriority)
        let initialCount = viewModel.doYourThings.count
        
        // When
        viewModel.removeDoYourThings(doYourThings: viewModel.doYourThings.last!)
        
        // Then
        XCTAssertEqual(viewModel.doYourThings.count, initialCount - 1, "Removing an item should decrease the count by 1")
    }
    
    func testUpdateDoYourThings() {
        // Given
        let newTopic = "Test Topic"
        let newDetails = "Test Details"
        let newPriority = "Normal"
        viewModel.addDoYourThings(dytTopic: newTopic, dytDetails: newDetails, dytPriority: newPriority)
        let updatedTopic = "Updated Topic"
        let updatedDetails = "Updated Details"
        let updatedPriority = "Hoch"
        
        // When
        viewModel.updateDoYourThings(doYourThings: viewModel.doYourThings.last!, newTopic: updatedTopic, newDetails: updatedDetails, newDytPriority: updatedPriority)
        
        // Then
        XCTAssertEqual(viewModel.doYourThings.last?.dytTopic, updatedTopic, "The topic should be updated")
        XCTAssertEqual(viewModel.doYourThings.last?.dytDetails, updatedDetails, "The details should be updated")
        XCTAssertEqual(viewModel.doYourThings.last?.dytPriority, updatedPriority, "The priority should be updated")
    }
    
    func testColorForPriority() {
        // Given
        let highPriorityColor = viewModel.colorForPriority("Hoch")
        let normalPriorityColor = viewModel.colorForPriority("Normal")
        let lowPriorityColor = viewModel.colorForPriority("Niedrig")
        
        // Then
        XCTAssertEqual(highPriorityColor, .red, "High priority color should be red")
        XCTAssertEqual(normalPriorityColor, .green, "Normal priority color should be green")
        XCTAssertEqual(lowPriorityColor, .blue, "Low priority color should be blue")
    }
    
    
}
