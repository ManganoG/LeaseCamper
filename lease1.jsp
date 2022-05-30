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
/*--------*/
#container1 {
   width: 400px;
   height: 200px;
   position: absolute;
   top: 60%;
   left: 45%;
   margin: -250px 0 0 -175px;
   border: 5px solid black;
   padding: 12px ;
    background: rgb(250,164,26);
    background: linear-gradient(90deg, rgba(250,164,26,1) 0%, rgba(37,255,69,1) 51%, rgba(30,195,228,1) 100%);  
     }

#container2 {
width: 400px;
height: 200px;
position: absolute;
top: 100%;
left: 45%;
margin: -250px 0 0 -175px;
border: 5px solid black;
padding: 12px ;
background: white;
}
/*-------------------*/


/*common button css  */

input.hover-center {
    border: 1px solid black;
    background-color: transparent;
    color: black;
    padding: 10px 40px;
    font-size: 20px;
    font-weight: 500;
    border-radius: 3px;
}
/* hover-center 1 css */

input.hover-center {
    background-image: linear-gradient(90deg, rgba(45,193,121,1) 0%, rgba(11,1,75,1) 100%);
    background-size: 0;
    transition: .8s;
    background-repeat: no-repeat;
    background-position: bottom;
    transition-timing-function: cubic-bezier(0.52, 1.64, 0.37, 0.66);
}

input.hover-center:hover {
    background-size: 100%;
    color: #fff;
}



    </style>
    </head>
    <body>
        <h1 style="color: white;">Ciao: questo &egrave un easter egg</h1>
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
        %>
        <div class="dropdown" style="float:right;">
                <button class="dropbtn">Men&#250;</button>
                <div class="dropdown-content">
                    <a href="viewCamper.jsp"><input type="submit" value="Mostra tutti i camper" name="B"></a>
                    <a href="viewLease.jsp"><input type="submit" value="Mostra i tuoi noleggi" name="B"></a>
                    <a href="viewNolegg.jsp"><input type="submit" value="Mostra i noleggiattori" name="B"></a>
                    <a href="rent.html"><input type="submit" value="Aggiungi un camper" name="B"></a>
                    <a class="Log" href="logout.jsp"><input type="submit" value="Logout" name="B"></a>
                </div>
            </div>
            <div id="container1">
                <div id="container2">
                    <h1>Noleggia</h1>
                    <form action = "lease2.jsp" method = " post" >
                    Data inizio: <input type = "date" name = "DataInizio" required><br>
                    Data fine: <input type = "date" name = "DataFine" required><br><br>
                    <input type="submit" value="Prenota" class="hover-center">
                    </form>
                </div>
            </div>
                </body>
        <%
                }
                else{
                    response.sendRedirect("index.html");

                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
</html>