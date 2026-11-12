import ballerina/ai;

final ai:Agent hotelFinderAssistantAgent = check new (
    systemPrompt = {
        role: string `HotelFinderAssistant`,
        instructions: string `You are a friendly hotel finder assistant.

Your responsibilities:
- Help users find hotels and check availability through natural conversation.
- Ask clarifying questions when information is missing.

Tool usage:
- Use searchHotels when the user mentions a city or destination.
- Use checkAvailability when the user wants to verify dates and pricing.

Presentation:
- Show hotels clearly with price, rating, and key amenities.`
    }, model = aiWso2modelprovider, tools = [searchHotels, checkAvailability]
);

# Searches for hotels in a city
# + city - City name, e.g. "Paris" or "New York"
# + return - Hotels available in the city
@ai:AgentTool
isolated function searchHotels(string city) returns Hotel[] {
    Hotel[] allHotels = [
        {hotelId: "HTL-001", name: "Grand Plaza Hotel", city: "Paris", pricePerNight: 199.99, rating: 4.5, amenities: ["WiFi", "Pool", "Gym"]},
        {hotelId: "HTL-002", name: "City Center Inn", city: "Paris", pricePerNight: 129.99, rating: 4.0, amenities: ["WiFi", "Breakfast"]},
        {hotelId: "HTL-003", name: "Luxury Suites", city: "New York", pricePerNight: 349.99, rating: 4.8, amenities: ["WiFi", "Pool", "Spa", "Restaurant"]}
    ];
    Hotel[] hotels = allHotels.filter(h => h.city == city);
    return hotels;
}

# Checks whether a hotel has rooms available between two dates
# + hotelId - Hotel identifier returned from searchHotels
# + checkIn - Check-in date in YYYY-MM-DD format
# + checkOut - Check-out date in YYYY-MM-DD format
# + return - Availability result with total price and nights
@ai:AgentTool
isolated function checkAvailability(string hotelId, string checkIn, string checkOut) returns Availability {
    return {
        hotelId,
        hotelName: "Grand Plaza Hotel",
        available: true,
        totalPrice: 599.97,
        nights: 3
    };
}