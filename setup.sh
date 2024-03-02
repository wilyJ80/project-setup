#!/bin/bash

check_installed() {
	local PACKAGE_NAME=$1

	if ! dpkg -l | grep -q "$PACKAGE_NAME"; then
		echo "Package $PACKAGE_NAME is not installed. Exiting the script."
		exit 1
	else
		echo "Package $PACKAGE_NAME found. Continuing setup..."
	fi
}

setup_python_environment() {
	if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
		cat <<- EOF

		***************************
		*    This script is not   *
		*    being sourced. venv  *
		*    will not enter       *
		*    correctly. Please,   *
		*    run it as            *
		*                         *
		*    source ./setup.sh    *
		*                         *
		*    instead of           *
		*                         *
		*    ./setup.sh           *
		*                         *
		***************************

		EOF
		exit 1
	else
		echo "Script is being sourced. Continuing..."
		check_installed "python3"
		check_installed "python3-venv"
		check_installed "python3-pip"

	fi

	echo "Creating virtual environment..."
	python3 -m venv venv
	echo "Activating virtual environment..."
	source venv/bin/activate

	echo -e "\nPython venv configured successfully.\n"
	echo -e "Use the deactivate command to leave it.\n"
}

cat <<- EOF

**************** SETUP ****************
*                                     *
*                                     *
*        Choose your project type.    *
*                                     *
*                                     *
***************************************

1. Python
0. Exit

EOF

read -p "> " project_type

case $project_type in
	1)
		setup_python_environment
		;;
	0)
		echo ""
		;;
	*)
		echo "Invalid choice, exiting 1"
		exit 1
		;;
esac
