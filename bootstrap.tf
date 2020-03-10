terraform {
  required_version = ">= 0.12, < 0.13"
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


# install rpm to BIG-IP
  provisioner "local-exec" {
   command = "curl -kvu admin:${var.admin_password} https://${var.bigip_address}/mgmt/shared/iapp/package-management-tasks -H \"Origin: https://${var.bigip_address}\" -H 'Content-Type: application/json;charset=UTF-8' --data '{\"operation\":\"INSTALL\",\"packageFilePath\":\"${var.do_install_dir}${var.f5_do_rpm_filename}.rpm\"}'"
  }
    provisioner "local-exec" {
      #install as3 
   command = "curl -kvu admin:${var.admin_password} https://${var.bigip_address}/mgmt/shared/iapp/package-management-tasks -H \"Origin: https://${var.bigip_address}\" -H 'Content-Type: application/json;charset=UTF-8' --data '{\"operation\":\"INSTALL\",\"packageFilePath\":\"${var.do_install_dir}${var.f5_as3_rpm_filename}.rpm\"}'"
  }
    provisioner "local-exec" {
   #Optional: This command verifies that the installation is successful. You should see: "class": "Result", "code": 200, "status": "OK"
    command = "sleep 3; curl -sku admin:${var.admin_password} https://${var.bigip_address}/mgmt/shared/declarative-onboarding/info"
  }
   provisioner "local-exec" {
 #   #curl command to uninstall DO
    when    = destroy
    command = "curl -kvu admin:${var.admin_password} https://${var.bigip_address}/mgmt/shared/iapp/package-management-tasks -d '{ \"operation\":\"UNINSTALL\",\"packageName\":\"${var.f5_do_rpm_filename}\"}'"
 }
    provisioner "local-exec" {
 #   #curl command to uninstall DO
    when    = destroy
    command = "curl -kvu admin:${var.admin_password} https://${var.bigip_address}/mgmt/shared/iapp/package-management-tasks -d '{ \"operation\":\"UNINSTALL\",\"packageName\":\"${var.f5_as3_rpm_filename}\"}'"
 }
 
   provisioner "remote-exec" {
    when   = destroy
    inline = ["rm -f ${var.do_install_dir}${var.f5_do_rpm_filename}.rpm", ]
  }
     provisioner "remote-exec" {
    when   = destroy
    inline = ["rm -f ${var.do_install_dir}${var.f5_as3_rpm_filename}.rpm", ]
  }
}


data "template_file" "init" {
  template = file("infra/do.tpl")
  vars = {
    HOSTNAME = var.bigip_hostname
    DNS_ADDRESS = var.dns_address
    NTP_ADDRESS = var.ntp_address
    GUEST_PASSWORD = var.guest_password
  }
}
resource "bigip_do"  "do-deploy" {
     do_json = data.template_file.init.rendered
     config_name = "Deploy"
}

