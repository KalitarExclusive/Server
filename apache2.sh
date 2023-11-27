     bash
     #!/bin/bash

     # Update package lists
     sudo apt update

     # Install Apache2
     sudo apt install -y apache2

     # Start and enable Apache2 service
     sudo systemctl start apache2
     sudo systemctl enable apache2

     echo "Apache2 installation completed."
   