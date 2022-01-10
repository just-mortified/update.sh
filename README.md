# update.sh
A simple bash script that I made that updates my gatsby site.

# What it does:
1. Builds the site locally
2. Commits and pushes to github repo over ssh
3. Prompts for ip address of virtual private server
4. Ssh's into vps and runs update.sh
5. Makes backup of live site and clones new site from github over ssh
6. Replaces live site with new site by changing contents of /var/www/html

# Initial setup:
+ edit the following vars in the script
   + computer = your desktop username
   + server = vps user
   + site = name of site/repository
   + gitusr = github username
+ Create and use ssh keys between the following 
   + desktop-> github
   + desktop -> vps
   + vps -> github
+ Ensure that update.sh exists on vps (/home/{user}/{sitename}/update.sh)

# Usage
+ bash update.sh
+ input ip address of vps
+ input password of vps user
