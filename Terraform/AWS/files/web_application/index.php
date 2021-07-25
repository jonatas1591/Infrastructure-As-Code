<?php
header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
header("Expires: Sat, 26 Jul 1997 05:00:00 GMT"); // Date in the past
?><!DOCTYPE html>
<html>
  <head>
    <title>StartUpp</title>
    <link rel='icon' href='https://logodownload.org/wp-content/uploads/2017/11/amazon-web-services-logo.png' type='image/x-icon'/ >
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
  </head>

  <body>
    <div class="container">

  	<div class="row">
  		<div class="col-md-12">

      <?php include('menu.php'); ?>
      <div class="jumbotron" style="background-color:#fff; color:#000">
      <p>
      <?php include("get-index-meta-data.php"); ?>

      <?php include('get-cpu-load.php'); ?>
      <?php echo exec('service codedeploy-agent restart > /dev/null &'); ?> 
      </p>
      <p>
      </p>
    </div>
    </div>
    </div>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>

  </body>
</html>
