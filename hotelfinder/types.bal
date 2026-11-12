
type Hotel record {|
    string hotelId;
    string name;
    string city;
    decimal pricePerNight;
    float rating;
    string[] amenities;
|};

type Availability record {|
    string hotelId;
    string hotelName;
    boolean available;
    decimal totalPrice;
    int nights;
|};