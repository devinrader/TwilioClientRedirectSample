<?xml version="1.0" encoding="utf-8" ?> 
<% 
' Answer the initial incoming voice call and store the CallSid in 
' the ASP Application object so that we can get it later.  Storing
' the data in the Application object is a *huge* cloodge and I would
' not recommend doing it in a real app.  Use a DB instead.

' This script also assums that a client_name Querystring parameter
' will be present.  This value represents the name of the Twilio
' Client to connect to.  IN a real application you cold test for 
' the existence if this parameter and if it is not present, use
' an algorythm to programatically select an available client
  
' Return the TwiML to connect the incoming call with a Client
' When the call ends, send the person to voicemail?

Application(Request.QueryString("client_name")) = Request("CallSid")

Response.ContentType="application/xml"
%>
<Response> 

    <!-- When I later redirect away from this Dial verb, the Dial will be considered complete and Action will fire -->

    <Dial timeout="5" action="/voicemail.asp?calledname=<%=Request.QueryString("client_name")%>" method="GET" > 
        <Client><%=Request.QueryString("client_name")%></Client> 
    </Dial> 
</Response>