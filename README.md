Bootstap F5 BIG-IP with Terraform
The goal is to automate as much of my delivery as possible.

That means that i will manage my infrastructure not by clicking around a webpage or manually executing shell commands, but through code.

Lets Start with BootStrapping F5-BIG-IP in our VMware environment

What are we going to do:

Use Terraform to install F5 Declarative Onboarding (DO) on the BIG-IP system.
use Terraform to install F5 AS3 on the BIG-IP system.
To install we need to create the following two files.

Notes

Important: For a new installation running BIG-IP 14.0.0 or later, you must log in to the system at least one time to change your root and administrator passwords. When you change the administrator password for the first time, the system automatically changes the root password. This is a one-time event. For more information, refer to K10612010: Root and admin users must reset default passwords when logging in to the BIG-IP system for the first time.

License Demo IRYZH-FWSJV-PXMPZ-SEDVS-KDVDIEZ
