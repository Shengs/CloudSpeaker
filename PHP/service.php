<!--connect DB to App-->

<?php
 
// Create connection
$con=mysqli_connect("localhost","shihengz_CS1","shihengz_CS1","shihengz_CS");
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
// This SQL statement selects ALL from the table 'accounts'
$message = "";

$username = stripslashes(mysql_real_escape_string($_POST['username'])); 
$password = stripslashes(mysql_real_escape_string($_POST['password']));

$submit = $_POST["submit_login"];

$md5_password = md5($password);

    $sql = "SELECT * FROM usr_table WHERE usr_name = '$username' and md5_password = '$md5_password'";
    $result = mysql_query($sql);

    $count = mysql_num_rows($result);

    if($count == 1) {
        $user_fetch = mysql_fetch_array($result);
        $_SESSION['usr_id'] = $user_fetch['usr_id'];
        $_SESSION['usr_name'] = $user_fetch['usr_name'];

        $message = "Login OK";

    } else {
        $message = "Login NOT OK";
    }

echo $message;
// Close connections
mysqli_close($con);
?>