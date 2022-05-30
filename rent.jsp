<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <h1>Aggiungi un Camper</h1>
        <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        
        String targa=null;
        String desc=null;
        String data = null;
        String disp = "true";
        String prop = null;
        
        String query = null;
        Statement st;
        ResultSet resultset;

        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try{
            HttpSession s = request.getSession();
            prop = (String) s.getAttribute("username");
            if(prop!=null){
%>
            <div class="dropdown" style="float:right;">
                <button class="dropbtn">Men&#250;</button>
                <div class="dropdown-content">
                    <a href="viewCamper.jsp"><input type="submit" value="Mostra tutti i camper" name="B"></a>
                    <a href="viewLease.jsp"><input type="submit" value="Mostra i tuoi noleggi" name="B"></a>
                    <a href="viewNolegg.jsp"><input type="submit" value="Mostra i noleggiattori" name="B"></a>
                    <a href="viewRent.jsp"><input type="submit" value="Mostra i tuoi camper" name="B"></a>
                    <a class="Log" href="logout.jsp"><input type="submit" value="Logout" name="B"></a>
                </div>
            </div>
<%
                targa = request.getParameter("targa");

                desc = request.getParameter("desc");

                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                long miliseconds = System.currentTimeMillis();
		        Date d = new Date(miliseconds);        
		        data = dateFormat.format(d);
            
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "LeaseCamper.accdb");
                String verifica = "SELECT Targa from Camper WHERE Targa = '"+targa+"';";
                st = connection.createStatement();          
                resultset = st.executeQuery(verifica);
                if(resultset.next()){
                    out.println("<h1 style='color:red;'><b>Un camper con questa targa &egrave gi&agrave stato inserito </b></h1>");
                }else{
                    query = "INSERT INTO Camper (Targa,Descrizione,DataInserimento,Disponibilita,Proprietario) values ('"+targa+"', '"+desc+"', #"+data+"#, '"+disp+"', '"+prop+"');";
                    st.executeUpdate(query);
                    out.println("<h1 style='color:red;'><b>Camper inserito correttamente</b></h1>");
                   
                }

            }
            else{
                    response.sendRedirect("index.html");

                }
            
        }
        catch(Exception e){
            out.println(e);
        }
        %>
        </body>
    </html>