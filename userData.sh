#!/bin/bash
sudo su
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

# Creating the HTML file with the desired styling
echo '<html>
<head>
    <title>Welcome Page</title>
    <style>
        body { background-color: skyblue; color: yellow; text-align: center; font-size: 24px; }
    </style>
</head>
<body>
    <h1>Welcome MASSA Jaico.</h1>
    <p>You are redirected to '"${HOSTNAME}"' to see how the load balancer is sharing the traffic.</p>
</body>
</html>' > /var/www/html/index.html
