<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
    <style>
    table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 3px solid black;
  text-align: left;
  padding: 8px;
}

tr:hover{
	background: linear-gradient(to right, #00ccff 0%, #66ff33 100%);
}
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

/*---------------*/

@import url('https://fonts.googleapis.com/css?family=Montserrat:600&display=swap');

span{
  position: relative;
  display: inline-flex;
  width: 100px;
  height: 25px;
  margin: 0 15px;
  perspective: 5000px;
}
span a{
  font-size: 15px;
  letter-spacing: 1px;
  transform-style: preserve-3d;
  transform: translateZ(-25px);
  transition: transform .25s;
  font-family: 'Montserrat', sans-serif;
  
}
span a:before,
span a:after{
  position: absolute;
  content: "Camper";
  height: 25px;
  width: 100px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 5px solid black;
  box-sizing: border-box;
  border-radius: 5px;
}
span a:before{
  color: #fff;
  background: #000;
  transform: rotateY(0deg) translateZ(25px);
}
span a:after{
  color: #000;
  transform: rotateX(90deg) translateZ(25px);
}
span a:hover{
  transform: translateZ(-25px) rotateX(-90deg);
}

/*----------------------------*/
h1{
    text-align:center;
}

    </style>
    </head>
    <body>
    <h1>Noleggiatori</h1>
        <%
            

            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
            }
            try {
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "LeaseCamper.accdb");
                HttpSession s = request.getSession();
                String nome = (String) s.getAttribute("username");

                String query= "SELECT DISTINCT Username,Nome,Cognome,Telefono FROM Utenti,Camper WHERE Username=Proprietario AND Proprietario!='"+nome+"';";
                Statement statement=connection.createStatement();
                ResultSet resultset=statement.executeQuery(query);
                String id=null;
                
                if(nome!=null){
        %>

        <div class="dropdown" style="float:right;">
            <button class="dropbtn">Men&#250;</button>
            <div class="dropdown-content">
                <a href="viewRent.jsp"><input type="submit" value="Mostra i tuoi camper" name="B"></a>
                <a href="viewLease.jsp"><input type="submit" value="Mostra i tuoi noleggi" name="B"></a>
                <a href="viewCamper.jsp"><input type="submit" value="Mostra tutti i camper" name="B"></a>
                <a href="rent.html"><input type="submit" value="Aggiungi un camper" name="B"></a>
                <a class="Log" href="logout.jsp"><input type="submit" value="Logout" name="B"></a>
            </div>
        </div>
        <table>
            <tr style="background: linear-gradient(to right, #ff0000 0%, #ffff00 100%);">
            <th>Username</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Telefono</th>
            <th></th></tr>
    </body>
        <%
                    while(resultset.next()){
                        id=resultset.getString(1);
                        out.println("<tr><td>"+resultset.getString(1)+"</td>");
                        out.println("<td>"+resultset.getString(2)+"</td>");
                        out.println("<td>"+resultset.getString(3)+"</td>");
                        out.println("<td>"+resultset.getString(4)+"</td>");
                        out.println("<td><span><a href='viewCamperN.jsp?p="+resultset.getString(1)+"'><input type=\"submit\" value=\"       \" name=\"B\"></a><span></td></tr>");  
                                       
                        }
                        out.println("</table><br>");
                    if(id==null){
                        out.println("<h1 style='color:red;'><b>Nessun camper disponibile</b> </h1>");
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