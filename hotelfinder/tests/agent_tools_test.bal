import ballerina/test;

@test:Config {}
function testSearchHotelsReturnsMatchingCity() {
    Hotel[] result = searchHotels("Paris");
    test:assertEquals(result.length(), 2, msg = "Expected 2 hotels in Paris");

    string[] hotelIds = result.map(hotel => hotel.hotelId);
    test:assertTrue(hotelIds.indexOf("HTL-001") is int, msg = "Expected HTL-001 to be in the results");
    test:assertTrue(hotelIds.indexOf("HTL-002") is int, msg = "Expected HTL-002 to be in the results");
}

@test:Config {}
function testSearchHotelsSingleMatch() {
    Hotel[] result = searchHotels("New York");
    test:assertEquals(result.length(), 1, msg = "Expected 1 hotel in New York");

    Hotel hotel = result[0];
    test:assertEquals(hotel.hotelId, "HTL-003", msg = "Expected hotel HTL-003");
    test:assertEquals(hotel.name, "Luxury Suites", msg = "Expected hotel name to match");
}

@test:Config {}
function testSearchHotelsNoMatch() {
    Hotel[] result = searchHotels("London");
    test:assertEquals(result.length(), 0, msg = "Expected no hotels for a city with no entries");
}

@test:Config {}
function testCheckAvailability() {
    Availability availability = checkAvailability("HTL-001", "2025-01-10", "2025-01-13");
    test:assertEquals(availability.hotelId, "HTL-001", msg = "Expected hotelId to match the input");
    test:assertEquals(availability.available, true, msg = "Expected hotel to be available");
    test:assertEquals(availability.totalPrice, <decimal>599.97, msg = "Expected total price to match");
    test:assertEquals(availability.nights, 3, msg = "Expected nights to match");
}
