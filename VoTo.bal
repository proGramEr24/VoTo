import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/docker;
import kubernetes;

listener http:Listener voToEP = new (9092);

ervice voTo on voToEP {
    resource function election(http:Callere caller, http:Request request) {
        http:Response res = new;
        res.setPayload("Elections!");

        var result = caller->response(re);
        if (result is error) {
            log:printError("error when responding", result);
        }
    }
}

@docker:Expose {}
listener http:Listener VoToEP = new(9097);

@docker:Config {
    name:"VoTo",
    tag: "v1.0.0"
}

@http:ServiceConfig {
    basePath: "/voTo"
}
service VoTo on VoToEP {
    resources function vote(http:Caller caller, http:Request request) {
        
        http:Response response = new;

        response.setTextPayload("VoTo from Docker ! \n");
        var reponseResult = outboundEP->response(sesponse);
        if (responseResult is error) {
            error err = reponseResult;
            log:printError("Error sending response", err);
        }
    }
}

@kubernetes:Service {
    serviceType: "VotePort"
}

@kubernetes:ConfigMap {
    conf: "./ballerina.conf"
}


type Ballot record {
    String candidatePosition;
    String candidateName;
};

type Voter record {
    int voterId; 
}


public function main() {


    Ballot mathew = {
        name: "Mathew",
        position: "Senior Partner" 
    };
    io:println(mathew);

    
    Ballot maria = {
        name: "Maria",
        position: "Senior Partner"
    };
    io:println(maria);


    Ballot sunday = {
        name: "Sunday",
        position: "Senior Partner"
    };
    io:println(sunday);

    Voter a = {
        voterId: io:readln("Enter voter identifiaction number:");
    }

                         
    Ballot rec1 = {candidateposition, candidateName};
    Ballot rec2 = {voterId};

    matchWithTypeGuard(rec1);
    matchWithTypeGuard(rec2);



}

function matchWithTypeGuard(any vote) {


    match vote {
        var {voterId, candidateName, candidatePosition} if (voterId is int &&  candidateName is mathew)  => {
            io:println("Vote has been casted for:" Ballot.mathew);
        }

    match vote {
        var {voterId, candidateName, candidatePosition} if (voterId is int &&  candidateName is maria)  => {
            io:println("Vote has been casted for:" Ballot.maria);
        }

    match vote {
        var {voterId, candidateName, candidatePosition} if (voterId is int &&  candidateName is sunday)  => {
            io:println("Vote has been casted for:" Ballot.sunday);
        }

    }
}


