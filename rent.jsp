<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
    </head>

        <body>
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
                    response.getOutputStream().println("<p>Un camper con questa targa e' gia' stato inserito </p>");
                }else{
                    query = "INSERT INTO Camper (Targa,Descrizione,DataInserimento,Disponibilita,Proprietario) values ('"+targa+"', '"+desc+"', #"+data+"#, '"+disp+"', '"+prop+"');";
                    st.executeUpdate(query);
                    response.getOutputStream().println("Camper inserito correttamente");
                   
                }
                response.getOutputStream().println("<a href=\"logout.jsp\"><input type=\"submit\" value=\"Logout\" /> <br></a>");
                response.getOutputStream().println("<a href=\"viewCamper.jsp\"><input type=\"submit\" value=\"Mostra tutti i camper\" /> <br></a>");
                response.getOutputStream().println("<a href=\"viewRent.jsp\"><input type=\"submit\" value=\"Mostra i tuoi camper\"> <br></a>");

            }
            else{
                    response.getOutputStream().println("<a href=\"index.html\"><input type=\"submit\" value=\"Non ti sei ancora loggato\" /> <br></a>");

                }
            
        }
        catch(Exception e){
            out.println(e);
        }
        %>
        </body>
    </html>