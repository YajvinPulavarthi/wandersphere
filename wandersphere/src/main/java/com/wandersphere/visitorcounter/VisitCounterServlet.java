package com.wandersphere.visitorcounter;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VisitCounter")
public class VisitCounterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        int visitCount = 0;
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("visitCount")) {
                    visitCount = Integer.parseInt(cookie.getValue());
                }
            }
        }

        visitCount++;
        Cookie visitCookie = new Cookie("visitCount", Integer.toString(visitCount));
        visitCookie.setMaxAge(24 * 60 * 60); // Cookie expires in one day
        response.addCookie(visitCookie);

        out.println("<h1>Welcome!</h1>");
        out.println("<p>You have visited this site " + visitCount + " times.</p>");
    }
}
