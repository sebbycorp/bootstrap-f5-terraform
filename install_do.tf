variable "admin_password" {
  type = string
}
variable "advanced_shell_user_password" {
  type = string
}
variable "advanced_shell_user" {
  type = string
}
variable "admin_user" {
  type = string
}
variable "bigip_address" {
  type = string
}
variable "f5_do_rpm_filename" {
  type = string
}
variable "do_install_dir" {
  type = string
}
variable "do_install_dir_file" {
  type = string
}
variable "as3_install_dir_file" {
  type = string
}
variable "as3_rpm" {
  default = "f5-appsvcs-3.17.1-1.noarch.rpm"
}
variable "port" {
  type = string
}




resource "null_resource" "f5_do_installer" {
  connection {
    type     = "ssh"
    host     = var.bigip_address
    user     = var.advanced_shell_user
    password = var.advanced_shell_user_password
    port     = "22"
  }
  provisioner "file" {
    #Uses the ssh connection to transfer the file to the BIG-IP system
    source      = "files/f5-declarative-onboarding-1.10.0-2.noarch.rpm"
    destination = var.do_install_dir_file
  }
    provisioner "file" {
    #Uses the ssh connection to transfer the file to the BIG-IP system
    source      = "files/f5-appsvcs-3.17.1-1.noarch.rpm"
    destination = var.as3_install_dir_file
  }  
    provisioner "file" {
    #Uses the ssh connection to transfer the file to the BIG-IP system
    source      = "install_as3.sh"
    destination = var.as3_install_dir_file
  }
}

# install rpm to BIG-IP
resource "null_resource" "install_as3" {
  provisioner "local-exec" {
   command = "curl -kvu admin:W3lcome098! https://${var.bigip_address}/mgmt/shared/iapp/package-management-tasks -H \"Origin: https://${var.bigip_address}\" -H 'Content-Type: application/json;charset=UTF-8' --data '{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/f5-declarative-onboarding-1.10.0-2.noarch.rpm\"}'"
  }
  depends_on = [null_resource.f5_do_installer]
}

 # provisioner "local-exec" {
 #   #curl command to install DO
 #   command = "curl -kvu admin:W3lcome098! https://${var.bigip_address}/mgmt/shared/iapp/package-management-tasks -H \"Origin: https://${var.bigip_address}\" -H 'Content-Type: application/json;charset=UTF-8' --data '{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/f5-declarative-onboarding-1.10.0-2.noarch.rpm\"}'"
 # }
 # provisioner "local-exec" {
 #   #Optional: This command verifies that the installation is successful. You should see: "class": "Result", "code": 200, "status": "OK"
 #   command = "sleep 3; curl -sku admin:var.admin_password https://v${var.bigip_address}/mgmt/shared/declarative-onboarding/info"
 # }
 # provisioner "local-exec" {
 #   #curl command to uninstall DO
 #  # when    = destroy
 #   command = "curl -kvu admin:var.admin_password https://var.bigip_address/mgmt/shared/iapp/package-management-tasks -d '{ \"operation\":\"UNINSTALL\",\"packageName\":\"${var.f5_do_rpm_filename}\"}'"
 # }
 # provisioner "remote-exec" {
 #  # when   = destroy
 #   inline = ["rm -f ${var.do_install_dir}${var.f5_do_rpm_filename}.rpm", ]
 # }
#}
