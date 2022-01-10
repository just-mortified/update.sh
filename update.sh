#!/bin/bash

# name of user on dev computer 
computer="exampledesktop"

# name of admin user on server
server="exampleserver"

# site/repo name 
site="example"

# git account name
gitusr="github-user"



if [ "$USER" = "$computer" ];
then
  echo "Ip address of site?"
  read web

  echo ""
  echo -e "\033[0;36mMoving into directory\033[0m"
  cd /home/${computer}/GitHub/${site}/

  echo ""
  echo -e "\033[0;36mStarting Build\033[0m"
  gatsby build

  echo ""
  echo -e "\033[0;36mCommit and push Build\033[0m"
  git remote set-url origin ssh://git@github.com/${gitusr}/${site}.git
  git add *
  git commit -m "updated site: ${site}"
  git push --all

  echo ""
  echo -e "\033[0;36mSsh into vps\033[0m"

  ssh -t -p '794' "${server}@${web}" "sudo bash ${site}/update.sh"
  
else

  testusr=$(pwd)
  testusr=${testusr#*/home/} 
  
  if [ "$testusr" = "$server" ];
  then
 
    echo ""
    echo -e "\033[0;36mremoving old site\033[0m"
    rm -rf "${site}.old/*"

    echo ""
    echo -e "\033[0;36mbacking up current site\033[0m"
    cp -r ${site}/* ${site}.old/

    echo ""
    echo -e "\033[0;36mdeleting current site\033[0m"
    rm -rf ${site}

    echo ""
    echo -e "\033[0;36mgetting new site from github\033[0m"
    sudo -u ${server} git clone ssh://git@github.com/${gitusr}/${site}.git

    echo ""
    echo -e "\033[0;36mremoving current (live) site\033[0m"
    rm -rf /var/www/html/*

    echo ""
    echo -e "\033[0;36mmoving new (live) site\033[0m"
    cp -r /home/${server}/${site}/public/* /var/www/html/

    echo ""
    echo -e "\033[0;32 Done :)\033[0m"
  fi
fi
