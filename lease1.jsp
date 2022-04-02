
<html>
    <head>
    </head>
    <body>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%
            response.getOutputStream().println("<h1>Prenotazione</h1>");
            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
            }
            try {
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "LeaseCamper.accdb");
                HttpSession s = request.getSession();
                String nome = (String) s.getAttribute("username");
                String t = request.getParameter("targa");
                s.setAttribute("targa", t);    

                String query=null;
                String query1=null;
                String query3=null;
                Statement st;
                ResultSet rs;
                String DtIn=null;
                String DtFn=null;
                String p=null;
                
                if(nome!=null){
                    response.getOutputStream().println("<a href=\"logout.jsp\"><input type=\"submit\" value=\"Logout\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewRent.jsp\"><input type=\"submit\" value=\"Mostra i tuoi camper\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewCamper.jsp\"><input type=\"submit\" value=\"Mostra tutti i camper\" /> <br></a>");
                    response.getOutputStream().println("<a href=\"viewLease.jsp\"><input type=\"submit\" value=\"Mostra i tuoi noleggi\"><br></a>");
                    
                    response.getOutputStream().println("<a href=\"viewNolegg.jsp\"><input type=\"submit\" value=\"Mostra i noleggiattori\"><br></a>");
                    response.getOutputStream().println("<a href=\"rent.html\"><input type=\"submit\" value=\"Aggiungi un camper\"> <br><br></a>");
                    response.getOutputStream().println("<br><form action = 'lease2.jsp' method = ' post' >");
                    response.getOutputStream().println("Data inizio: <input type = 'date' name = 'DataInizio' >");
                    response.getOutputStream().println("Data fine: <input type = 'date' name = 'DataFine' >");
                    response.getOutputStream().println("<input type=\"submit\" value=\"Prenota\">");
                    response.getOutputStream().println("</form>");
                }
                else{
                    response.getOutputStream().println("<a href=\"index.html\"><input type=\"submit\" value=\"Non ti sei ancora loggato\" /> <br></a>");

                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
    </body>
</html>