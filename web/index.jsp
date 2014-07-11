<%-- 
    Document   : index
    Created on : 2014-7-7, 14:27:54
    Author     : xy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Astronomy Website Template</title>
    <link rel="stylesheet" href="resources/css/style.css" type="text/css">
    <script type="text/javascript" src="resources/js/jquery-1.8.3.js"></script>
  </head>
  <body>
    <jsp:include page="jsp/layout/header.jsp"/>
    <div id="contents">
      <div id="adbox">
        <div class="wrapper clearfix">
          <div class="info">
            <h1></h1>
            <p></p>
          </div>
        </div>
        <div class="highlight">
          <h2>Lorem ipsum dolor sit amet - <i>consectetur adipiscing elit.</i></h2>
        </div>
      </div>
      <div class="body clearfix">
        <div class="click-here">
          <h1>Lorem Ipsum Dolor!</h1>
          <a href="index.html" class="btn2">Click Here!</a>
        </div>
        <p style="font-size:12px;">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nec mi tortor. Phasellus commodo semper vehicula. Praesent aliquam semper massa et scelerisque. Suspendisse dapibus interdum diam, non varius nisl laoreet at. Pellentesque imperdiet molestie sollicitudin. Sed nec magna nibh, sed interdum nisi. Mauris vel pretium nibh. Morbi congue velit quis eros imperdiet ac el eifend elit condimentum. Nulla vestibulum dictum tellus quis iaculis. Duis a diam vitae sem tristique vestibulum. Praesent dapibus, tortor nec hendrerit pulvinar, lectus tortor viverra ante,
        </p>
      </div>
    </div>
    <jsp:include page="jsp/layout/footer.jsp"/>   
  </body>
</html>
