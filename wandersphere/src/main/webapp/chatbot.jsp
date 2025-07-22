<%@ page import="java.io.File" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chatbot</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

body {
    background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.chat-box {
    background: #ffffff;
    color: #333333;
    padding: 40px 30px;
    border-radius: 24px;
    width: 480px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    z-index: 999;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.chat-box:hover {
    transform: translateY(-3px);
    box-shadow: 0 20px 45px rgba(0, 0, 0, 0.25);
}

h2 {
    font-size: 28px;
    margin-bottom: 25px;
    color: #0f2027;
    text-align: center;
}

form {
    display: flex;
    gap: 12px;
    margin-bottom: 20px;
}

input[type="text"] {
    flex: 1;
    padding: 14px 16px;
    border-radius: 50px;
    border: 1px solid #ddd;
    font-size: 16px;
    outline: none;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

input[type="text"]:focus {
    border-color: #1e90ff;
    box-shadow: 0 0 0 3px rgba(30, 144, 255, 0.2);
}

input[type="submit"] {
    padding: 14px 22px;
    border-radius: 50px;
    background: #1e90ff;
    color: #ffffff;
    font-size: 16px;
    font-weight: 600;
    border: none;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.2s ease;
}

input[type="submit"]:hover {
    background: #005ecb;
    transform: translateY(-2px);
}

.answer {
    margin-top: 20px;
    font-weight: 600;
    color: #008000;
    font-size: 17px;
}

.error {
    color: #ff3333;
    font-size: 15px;
    margin-top: 20px;
}

    </style>
</head>
<body>

<div class="chat-box">
    <h2>Ask PawfectPets</h2>
    <form method="post">
        <input type="text" name="question" placeholder="Type your question here..." required>
        <input type="submit" value="Ask">
    </form>

<%
    String userQuestion = request.getParameter("question");
    if (userQuestion != null) {
        userQuestion = userQuestion.trim().toLowerCase();

        String path = application.getRealPath("/WEB-INF/chatbot.xml");
        File xmlFile = new File(path);

        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlFile);
            doc.getDocumentElement().normalize();

            NodeList qaList = doc.getElementsByTagName("qa");
            String answer = "Sorry, I don’t understand your question.";

            for (int i = 0; i < qaList.getLength(); i++) {
                Node qaNode = qaList.item(i);
                if (qaNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element qaElement = (Element) qaNode;
                    String q = qaElement.getElementsByTagName("question").item(0).getTextContent().toLowerCase();
                    String a = qaElement.getElementsByTagName("answer").item(0).getTextContent();
                    if (userQuestion.equals(q)) {
                        answer = a;
                        break;
                    }
                }
            }
%>
    <div class="answer">Bot: <%= answer %></div>
<%
        } catch (Exception e) {
%>
    <div class="error">Error: <%= e.getMessage() %></div>
<%
        }
    }
%>
</div>

</body>
</html>
