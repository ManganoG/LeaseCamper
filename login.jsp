<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
<head>
    <link rel="stylesheet" href="css/index.css">
</head>

        <body>
        <%
            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                } catch (ClassNotFoundException e) {
                    System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
                }
                try {
                    Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Accedi.accdb");
                    String us=request.getParameter("username");
                    String pas=request.getParameter("password");
                    String query= "SELECT nome FROM Utenti WHERE Username= '" + us + "' AND Password= '"+ pas +"';";
                    Statement statement=connection.createStatement();
                    ResultSet resultset=statement.executeQuery(query);
                    String n=null;

                    HttpSession s = request.getSession();
                    String dataValue = us;

                    while(resultset.next()){
                        n=resultset.getString(1);
                    }
                    if(n==null){
                        s.setAttribute("username", dataValue);
                        out.println("");
                        response.getOutputStream().println("Utente o Password sbagliati <br><br> <a href='signIn.html'> <input type='submit' id='btn2' value='Non hai un account: registrati' /> <br></a>");
                    }
                    else{
                        s.setAttribute("username", dataValue);
                        response.getOutputStream().println("Benvenuto "+n);
                    }
                }
                catch (Exception er) {
                    System.out.println(er);
                }                                    
        %>
        </body>
    </html>