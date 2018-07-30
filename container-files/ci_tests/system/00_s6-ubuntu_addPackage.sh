#!/usr/bin/with-contenv bash

# Shell Colors
set_shell_error() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[5m" # Style: blink
  echo -e "\e[31m" # Text Color: Red
}

set_shell_info() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[33m" # Text Color: Yellow
}

set_shell_pass() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[32m" # Text Color: Green
}

set_shell_warning() {
  echo -e "\e[1m" # Style: bold
  echo -e "\e[35m" # Text Color: Magenta
}

reset_shell() {
  echo -e "\e[0m" # Reset all shell attributes
}

# Check to see if packages are preinstalled
FORTUNE_INSTALLED=false
dpkg --list | awk '{ print $2 }' | grep ^fortune-mod$
if [ $? -eq 0 ]; then

  set_shell_info
  echo "fortune-mod already installed skipping step"
  reset_shell

  FORTUNE_INSTALLED=true
fi

COWSAY_INSTALLED=false
dpkg --list | awk '{ print $2 }' | grep ^cowsay$
if [ $? -eq 0 ]; then

  set_shell_info
  echo "cowsay already installed skipping step"
  reset_shell

  COWSAY_INSTALLED=true
fi

#Make sure packages can be installed
DEBIAN_FRONTEND=noninteractive apt-get update

if ! $FORTUNE_INSTALLED; then
  DEBIAN_FRONTEND=noninteractive apt-get install -y fortune-mod
  dpkg --list | awk '{ print $2 }' | grep ^fortune-mod$
  if [ $? -ne 0 ]; then

    set_shell_error
    echo -e "TEST: installation of fortune-mod FAILED"
    reset_shell

    exit 1
  fi
fi

if ! $COWSAY_INSTALLED; then
  DEBIAN_FRONTEND=noninteractive apt-get install -y cowsay
  dpkg --list | awk '{ print $2 }' | grep ^cowsay$
  if [ $? -ne 0 ]; then

    set_shell_error
    echo "TEST: installation of cowsay FAILED"
    reset_shell

    exit 1
  fi
fi

/usr/games/fortune | /usr/games/cowsay -n
if [ $? -ne 0 ]; then

  set_shell_error
  echo "TEST: really.. you got this far and cowsay FAILED"
  reset_shell

  exit 1
fi


# Clean up time
if ! $COWSAY_INSTALLED; then

  set_shell_info
  echo "uninstalling cowsay"
  reset_shell

  DEBIAN_FRONTEND=noninteractive apt-get purge -y cowsay
fi

if ! $FORTUNE_INSTALLED; then

  set_shell_info
  echo "uninstalling fortune-mod"
  reset_shell

  DEBIAN_FRONTEND=noninteractive apt-get purge -y fortune-mod
fi

apt-get clean
rm -rf /var/lib/apt/lists/*

exit 0
