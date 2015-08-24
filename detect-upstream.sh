#!/bin/sh

base_url="https://raw.githubusercontent.com/fmoliveira/lsb-release-upstream/master/upstream"

# Check for the existence of a system command
command_exists() {
	command -v "$@" > /dev/null 2>&1
}

# Standard not found error message
not_found() {
	cat <<-EOF
	ERROR: Upstream distribution not found in repository!
	SOLUTION: Please submit a pull request to https://github.com/fmoliveira/lsb-release-upstream.
	EOF
}

# Get information about currenty Linux distribution
if command_exists lsb_release; then
	lsb_dist=$(lsb_release -i | cut -d ':' -f 2 | tr '[:upper:]' '[:lower:]' | tr -d '\t' | tr -d ' ')
	dist_version=$(lsb_release -c | cut -d ':' -f 2 | tr '[:upper:]' '[:lower:]' | tr -d '\t' | tr -d ' ')
	url="$base_url/$lsb_dist/$dist_version"
# The command lsb_release doesn't exist, thus we cannot detect current distro
else
	cat <<-EOF
	ERROR: Unable to detect current distribution!
	SOLUTION: Please install lsb_release to proceed!
	EOF
	exit 1
fi

# Try downloading upstream distro name using wget first
if command_exists wget; then
	upstream=$(wget -qO- $url)

	if [ "$?" != "0" ]; then
		not_found
	fi
else
	# Fallback to curl if wget isn't installed
	if command_exists curl; then
		upstream=$(curl -sSL $url)

		if [ "$upstream" = "Not Found" ]; then
			not_found
			upstream=""
		fi
	fi
fi

# Check if upstream distro has been detected
if [ "$upstream" != "" ]; then
	lsb_dist=$(echo $upstream | cut -d ':' -f 1)
	dist_version=$(echo $upstream | cut -d ':' -f 2)
fi
