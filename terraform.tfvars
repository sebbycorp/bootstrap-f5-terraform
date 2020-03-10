bigip_address                = "192.168.1.150"
admin_user                   = "admin"
port                         = "22"
admin_password               = "W3lcome098!"
advanced_shell_user_password = "W3lcome098!"

#advanced_shell_user requires Advanced Shell access on the BIG-IP system
advanced_shell_user = "root"

#Enter the filename. Do not include the .rpm extension
f5_do_rpm_filename = "f5-declarative-onboarding-1.10.0-2.noarch"
f5_as3_rpm_filename = "f5-appsvcs-3.17.1-1.noarch"


do_install_dir_file  = "/var/config/rest/downloads/f5-declarative-onboarding-1.10.0-2.noarch.rpm"
do_install_dir       = "/var/config/rest/downloads/"
as3_install_dir_file = "/var/config/rest/downloads/f5-appsvcs-3.17.1-1.noarch.rpm"


guest_password = "W3lcome098!"
bigip_hostname = "bigip.maniak.io"
dns_address = "8.8.8.8"
ntp_address = "0.north-america.pool.ntp.org"