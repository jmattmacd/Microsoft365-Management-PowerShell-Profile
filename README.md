# Microsoft 365 Management = PowerShell Profile
Profile for ISE to manange 365
I have my environment set up with a profile which checks the module installation and update version on every load.

It does however enforce a new mfa session for every connect- verb

If its run on a machine without the module installed it prompts to install it, auto-escalating a powershell script to do so.

I find it hugely useful, in order to use it you can just open Powershell ISE and run “notepad $profile” to open your current profile in notepad then copy the contents below in and save it. restart PowershellISE and it will run that script at every log in.

It makes start up a little slower but massively speeds up everything else as you know the module and versions installed and can get the others very quickly.

Because I needed some cmdlets in the newer teams modules it also includes instructions to register the PoshTestGallery as a package source
