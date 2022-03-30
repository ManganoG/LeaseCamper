<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <link rel="stylesheet" href="css/index.css">
    </head>

        <body>
        <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        
        String username=null;
        String password=null;
        String nome = null;
        String cognome = null;
        String telefono = null;
        
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try{
            
            nome = request.getParameter("nome");
            cognome = request.getParameter("cognome");
            telefono = request.getParameter("telefono");
            username = request.getParameter("username");
            password = request.getParameter("password");
            
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "LeaseCamper.accdb");
            String verifica = "SELECT Username from Utenti WHERE Username = '"+username+"';";
            Statement st = connection.createStatement();          
            ResultSet result = st.executeQuery(verifica);
            if(result.next()){
                out.println("<p>Questo account è già esistente</p>");
            }else{
                String query = "INSERT INTO Utenti (Username,Password,nome,cognome,telefono) values ('"+username+"', '"+password+"', '"+nome+"', '"+cognome+"', '"+telefono+"');";
                st.executeUpdate(query);
                response.sendRedirect("index.html");
            }
            
        }
        catch(Exception e){
            out.println(e);
        }
        %>
        <a href="index.html">
            <input type="submit" id="btn2" value="Torna al Login" /> <br>
        </a>
        </body>
    </html>