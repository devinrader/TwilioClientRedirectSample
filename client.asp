<%
Option Explicit

Dim client_name, token
client_name = Request.QueryString("client_name")

' For this sample, I've hard coded two Client Tokens since there is no way
' to create them in pure ASP.  You need to make sure you specify the client name you 
' want to use in the querystring so that Twilio Client can be initialized

if (client_name = "red") then
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBQzMxMzdkNzY0NTc4MTRhNWVhYmY3ZGU2MmYzNDZkMzlhIiwiZXhwIjoxMzQwMzk1NzE5LCJzY29wZSI6InNjb3BlOmNsaWVudDppbmNvbWluZz9jbGllbnROYW1lPXJlZCJ9.isjukqxKMQbZaddfq3ZHiHtnU_4bcSFB-c59F_1SY5Q"
else
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBQzMxMzdkNzY0NTc4MTRhNWVhYmY3ZGU2MmYzNDZkMzlhIiwiZXhwIjoxMzQwMzk1NzE5LCJzY29wZSI6InNjb3BlOmNsaWVudDppbmNvbWluZz9jbGllbnROYW1lPWJsdWUifQ.8tKKdnaPm99oi_ux8u-RFFYjTRQK_4dxzisv9nXccAo"
end if

%>

<!DOCTYPE html>
<html>
  <head>
    <title>Hello Client Monkey 3</title>
    <script type="text/javascript" src="http://static.twilio.com/libs/twiliojs/1.0/twilio.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
    <link href="http://static0.twilio.com/packages/quickstart/client.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">

        Twilio.Device.setup('<%Response.Write(token)%>');

        Twilio.Device.ready(function (device) {
            $("#log").text("Ready");
        });

        Twilio.Device.error(function (error) {
            $("#log").text("Error: " + error.message);
        });

        Twilio.Device.connect(function (conn) {
            $("#log").text("Successfully established call");
        });

        Twilio.Device.disconnect(function (conn) {
            $("#log").text("Call ended");
        });

        Twilio.Device.incoming(function (conn) {
            $("#log").text("Incoming connection from " + conn.parameters.From);
            // accept the incoming connection and start two-way audio
            conn.accept();
        });

        function call() {
            Twilio.Device.connect();
        }

        function hangup() {
            Twilio.Device.disconnectAll();
        }

        function redirect() {

            // jQuery ajax request to redirect.asp which will redirect the original call leg
            // For this sample I am hard coding the specific client to redirect to, but 
            // you could use Presence to determine who is currently online and use an 
            // algorythm to dynamically select the client name

            var transferUrl = '/redirect.asp?from_client=<%Response.Write(client_name)%>&to_client=blue';
            $.get(transferUrl).success(function(){
                $("#log").text('Call transferred to ' + toClient);
            });                
        }
    </script>
  </head>
  <body>
    <button class="call" onclick="call();">
      Call
    </button>
  
    <button class="hangup" onclick="hangup();">
      Hangup
    </button>
  
    <button class="redirect" onclick="redirect();">
      Redirect
    </button>

    <div id="log">Loading pigeons...</div>
  </body>
</html>
