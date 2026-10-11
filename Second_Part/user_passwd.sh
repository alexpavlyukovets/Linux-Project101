#!/bin/bash

# Check root privileges.
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Get the username.
read -r -p "Enter username: " USERNAME

# Get the full name.
read -r -p "Enter full name: " FULLNAME

# Get the password.
read -r -s -p "Enter password: " PASSWORD
echo

# Create the user.
useradd -m -c "$FULLNAME" "$USERNAME"

if [[ $? -ne 0 ]]; then
    echo "Error: User creation failed."
    exit 1
fi

# Set the password.
echo "$USERNAME:$PASSWORD" | chpasswd

if [[ $? -ne 0 ]]; then
    unset PASSWORD
    echo "Error: Password setup failed."
    exit 1
fi

unset PASSWORD

# Force password change on first login.
if ! passwd -e "$USERNAME"; then
    echo "Error: Failed to require password change."
    exit 1
fi

# Display the result.
echo "User $USERNAME created successfully."
echo "Hostname: $(hostname)"