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
                Statement st;
                ResultSet rs;
                String nome = (String) s.getAttribute("username");
                String t = request.getParameter("targa");
                String p=request.getParameter("p");
                String DtIn=request.getParameter("di");
                String DtFn=request.getParameter("df");
                String query1=null;
                String query2=null;

                if(nome!=null){
                    response.getOutputStream().println("<a href=\"logout.jsp\"><input type=\"submit\" value=\"Logout\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewRent.jsp\"><input type=\"submit\" value=\"Mostra i tuoi camper\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewCamper.jsp\"><input type=\"submit\" value=\"Mostra tutti i camper\" /> <br></a>");
                    response.getOutputStream().println("<a href=\"viewLease.jsp\"><input type=\"submit\" value=\"Mostra i tuoi noleggi\"><br></a>");
                    response.getOutputStream().println("<a href=\"rent.html\"><input type=\"submit\" value=\"Aggiungi un camper\"> <br><br></a>");
                    String verifica = "SELECT * from Noleggi WHERE Targa = '"+t+"' AND Proprietario='"+p+"' AND Affittuario='"+nome+"' AND DataInizio=#"+DtIn+"# AND DataFine=#"+DtFn+"#;";
                    st = connection.createStatement();          
                    rs = st.executeQuery(verifica);
                    if(rs.next()){
                        query1 = "DELETE FROM Noleggi WHERE Targa = '"+t+"' AND Proprietario='"+p+"' AND Affittuario='"+nome+"' AND DataInizio=#"+DtIn+"# AND DataFine=#"+DtFn+"#;";
                        st.executeUpdate(query1);
                        response.getOutputStream().println("Cancellazione eseguita correttamente");
                        query2 = "UPDATE Camper SET Disponibilita='true' WHERE Targa = '"+t+"'";
                        st.executeUpdate(query2);
                    }else{
                        response.getOutputStream().println("<p> Questa prenotazione non esiste </p>");
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