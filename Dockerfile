# Use the latest Arch Linux base image
FROM archlinux:latest

# Label the image
LABEL maintainer=".Ky_"
LABEL description="Clean Arch Linux Docker Image"

# Update the system
RUN pacman -Syu --noconfirm

# Install base-devel group (commonly needed tools)
RUN pacman -S --noconfirm base-devel ansible git

# Clean up cache
RUN pacman -Scc --noconfirm

# Create a new user 'ky' without a password and create a home directory
RUN useradd -m -s /bin/bash ky \
    && passwd -d ky

# Set the working directory to the home directory of the new user
WORKDIR /home/ky

COPY . .dotfiles
# Set the default command or entrypoint (optional)
CMD ["/bin/bash"]
