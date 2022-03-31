
<html>
    <head>
    </head>
    <body>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%
            response.getOutputStream().println("<h1>Camper disponibili</h1>");

            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
            }
            try {
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "LeaseCamper.accdb");
                HttpSession s = request.getSession();
                String nome = (String) s.getAttribute("username");

                String query= "SELECT * FROM Camper WHERE Disponibilita=true AND Proprietario!='"+nome+"';";
                Statement statement=connection.createStatement();
                ResultSet resultset=statement.executeQuery(query);
                String id=null;
                
                if(nome!=null){
                    response.getOutputStream().println("<a href=\"logout.jsp\"><input type=\"submit\" value=\"Logout\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewRent.jsp\"><input type=\"submit\" value=\"Mostra i tuoi camper\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewLease.jsp\"><input type=\"submit\" value=\"Mostra i tuoi noleggi\"><br></a>");
                    response.getOutputStream().println("<a href=\"viewNolegg.jsp\"><input type=\"submit\" value=\"Mostra i noleggiattori\"><br></a>");
                    response.getOutputStream().println("<a href=\"rent.html\"><input type=\"submit\" value=\"Aggiungi un camper\"> <br><br></a>");
                    response.getOutputStream().println("<table style=\"border: 1px solid black;\">");
                    response.getOutputStream().println("<tr>");
                    response.getOutputStream().println("<th style=\"border: 1px solid black;\">Targa</th>");
                    response.getOutputStream().println("<th style=\"border: 1px solid black;\">Descrizione</th>");
                    response.getOutputStream().println("<th style=\"border: 1px solid black;\">Data inserimento</th>");
                    response.getOutputStream().println("<th style=\"border: 1px solid black;\">Proprietario</th>");
                    response.getOutputStream().println("<th style=\"border: 1px solid black;\"></th></tr>");
                    while(resultset.next()){
                        id=resultset.getString(1);
                        response.getOutputStream().println("<tr><td style=\"border: 1px solid black;\">"+resultset.getString(5)+"</td>");
                        response.getOutputStream().println("<td style=\"border: 1px solid black;\">"+resultset.getString(1)+"</td>");
                        response.getOutputStream().println("<td style=\"border: 1px solid black;\">"+resultset.getString(2).substring(0,10)+"</td>");
                        response.getOutputStream().println("<td style=\"border: 1px solid black;\">"+resultset.getString(4)+"</td>");
                        response.getOutputStream().println("<td style=\"border: 1px solid black;\"><a href='lease1.jsp?targa="+resultset.getString(5)+"'><input type=\"submit\" value=\"Prenota\"></a></td></tr>"); 
                                       
                        }
                        response.getOutputStream().println("</table><br>");
                    if(id==null){
                        response.getOutputStream().println("Nessun camper disponibile");
                    }
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