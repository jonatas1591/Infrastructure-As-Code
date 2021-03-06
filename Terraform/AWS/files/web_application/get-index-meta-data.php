<?php

  echo "<table class='table table-bordered' >";
  echo "<tr><th>Meta-Data</th><th>Value</th></tr>";

  #The URL root is the AWS meta data service URL where metadata
  # requests regarding the running instance can be made
  $urlRoot="http://169.254.169.254/latest/meta-data/";

  # Get the instance ID from meta-data and print to the screen
  echo "<tr><td>InstanceId</td><td><i>" . file_get_contents($urlRoot . 'instance-id') . "</i></td><tr>";

  # Availability Zone
  echo "<tr><td>Availability Zone</td><td><i>" . file_get_contents($urlRoot . 'placement/availability-zone') . "</i></td><tr>";

echo "<tr><td>AMI-ID</td><td><i>" . file_get_contents($urlRoot . 'ami-id') . "</i></td><tr>";

  echo "<tr><td>Profile</td><td><i>" . file_get_contents($urlRoot .'profile') . "</i></td><tr>";

  echo "<tr><td>Public IP</td><td><i>" . file_get_contents($urlRoot . 'public-ipv4') . "</i></td><tr>";

  echo "<tr><td>Security Groups</td><td><i>" . file_get_contents($urlRoot . 'security-groups') . "</i></td><tr>";



  echo "</table>";

?>
