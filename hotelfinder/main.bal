import ballerina/ai;
import ballerina/http;

listener ai:Listener chatAgentListener = new (listenOn = check http:getDefaultListener());

service /hotelFinderAssistant on chatAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check hotelFinderAssistantAgent.run(request.message, sessionId = request.sessionId);
        return {message: stringResult};
    }
}