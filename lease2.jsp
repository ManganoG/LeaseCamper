
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
                String t = (String) s.getAttribute("targa");

                String query=null;
                String query1=null;
                String query2=null;
                Statement st;
                ResultSet rs;
                String DtIn=null;
                String DtFn=null;
                String p=null;
                
                if(nome!=null){
                    query= "SELECT Proprietario FROM Camper WHERE Targa='"+t+"';";
                    st=connection.createStatement();
                    rs=st.executeQuery(query);
                    while(rs.next()){
                        p=rs.getString(1);
                    }
                    response.getOutputStream().println("<a href=\"logout.jsp\"><input type=\"submit\" value=\"Logout\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewRent.jsp\"><input type=\"submit\" value=\"Mostra i tuoi camper\"> <br></a>");
                    response.getOutputStream().println("<a href=\"viewCamper.jsp\"><input type=\"submit\" value=\"Mostra tutti i camper\" /> <br></a>");
                    response.getOutputStream().println("<a href=\"viewLease.jsp\"><input type=\"submit\" value=\"Mostra i tuoi noleggi\"><br></a>");
                    response.getOutputStream().println("<a href=\"viewNolegg.jsp\"><input type=\"submit\" value=\"Mostra i noleggiattori\"><br></a>");
                    response.getOutputStream().println("<a href=\"rent.html\"><input type=\"submit\" value=\"Aggiungi un camper\"> <br><br></a>");
                   
                    
                    DtIn=request.getParameter("DataInizio");
                    DtFn=request.getParameter("DataFine");
                    
                    String verifica = "SELECT Targa,Proprietario,Affittuario from Noleggi WHERE Targa = '"+t+"' AND Proprietario='"+p+"' AND Affittuario='"+nome+"';";
                    st = connection.createStatement();          
                    rs = st.executeQuery(verifica);
                    if(rs.next()){
                        response.getOutputStream().println("<p> Errore nel database,contattare amministratore </p>");
                    }else{
                        query1 = "INSERT INTO Noleggi (Targa,Proprietario,Affittuario,DataInizio,DataFine) values ('"+t+"', '"+p+"','"+nome+"' ,#"+DtIn+"#, #"+DtFn+"#);";
                        st.executeUpdate(query1);
                        response.getOutputStream().println("Prenotazione eseguita correttamente");
                        query2 = "UPDATE Camper SET Disponibilita='false' WHERE Targa = '"+t+"'";
                        st.executeUpdate(query2);
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