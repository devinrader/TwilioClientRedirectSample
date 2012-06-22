<%
' This script redirects a call from one Twilio Client to another
' It expects two querystring parameters to be passed to it:
'
' - from_client: the name of the Twilio Client naming the redirect request
' - to_client: the name of the Twilio Client to redirect the call to

' Additionally the script exects to be able to find a CallSid value
' in the Application object by using the from_client as a key

' In a real application you would need to find a way to inidicate that 
' the from_client is no longer connected to the CallSid, once the 
' call redirect is completed

' Please substitute your own Twilio credentials in the variables below
'accountSid = "<<YOUR_ACCOUNT_SID>>"
'authToken = "<<YOUR_AUTH_TOKEN>>"

from_client = Request.QueryString("from_client")
to_client = Request.QueryString("to_client")

incoming_sid = Application(from_client)

 ' setup the URL
baseUrl = "https://api.twilio.com"
callUrl = baseUrl & "/2010-04-01/Accounts/" & accountSid & "/Calls/" & incoming_sid & ""
formData = "Url=http://asp.devinrader.info/answer.asp?client_name=" & to_client & "&Method=POST"
 
' setup the request and authorization
Set http = Server.CreateObject("MSXML2.ServerXMLHTTP")
http.open "POST", callUrl, False, accountSid, authToken
http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
http.send formData

Response.Write(http.ResponseXML.xml)
%>