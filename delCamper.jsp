<%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
<html>
    <head>
    <style>
    input[name="B"]{
    background-color: Transparent;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
}

/*-----------------------*/

.dropbtn {
  background-color: #4CAF50;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropdown {
    bottom:50px;
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  right: 0;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #2decd6;}

.dropdown:hover .dropdown-content {
  display: block;
}

.dropdown:hover .dropbtn {
  background-color: #8a1e1e;
}

.dropdown-content a.Log:hover {
    background-color: #ff0000;
}

/*----------------------------*/
h1{
    text-align:center;
}
    </style>
    </head>
    <body>
     <h1>I tuoi camper</h1>
        
        <%
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
                String query1=null;
                String query2=null;

                if(nome!=null){
                    %>
        <div class="dropdown" style="float:right;">
            <button class="dropbtn">Men&#250;</button>
            <div class="dropdown-content">
                <a href="viewRent.jsp"><input type="submit" value="Mostra i tuoi camper" name="B"></a>
                <a href="viewLease.jsp"><input type="submit" value="Mostra i tuoi noleggi" name="B"></a>
                <a href="viewNolegg.jsp"><input type="submit" value="Mostra i noleggiattori" name="B"></a>
                <a href="viewCamper.jsp"><input type="submit" value="Mostra tutti i camper" name="B"></a>
                <a href="rent.html"><input type="submit" value="Aggiungi un camper" name="B"></a>
                <a class="Log" href="logout.jsp"><input type="submit" value="Logout" name="B"></a>
            </div>
        </div>
                    <%
                    
                    String verifica = "SELECT * from Camper WHERE Targa = '"+t+"' AND Proprietario='"+nome+"';";
                    st = connection.createStatement();          
                    rs = st.executeQuery(verifica);
                    if(rs.next()){
                        query1 = "DELETE FROM Camper WHERE Targa = '"+t+"' AND Proprietario='"+nome+"';";
                        st.executeUpdate(query1);
                        out.println("<h1 style='color:red;'><b>Camper cancellato correttamente</b> </h1>");
                    }else{
                        out.println("<h1 style='color:red;'><b> Questo camper non esiste</b> </h1>");
                    }

                }
                else{
                    response.sendRedirect("index.html");

                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
    </body>
</html>