FROM osrf/ros:jazzy-desktop-full 
# FROM ros:jazzy # headless ROS (no GUI programs, much smaller)

# example install programs
# having everything for one atomic operation in one RUN command is good because Docker caches at the command level
# apt-get is better for scripts than apt
# must run apt-get update right before each install command because Docker caches results of some commands
# must clear apt lists generated by running apt-get update. they waste space on final img
RUN apt-get update \
    && apt-get install -y \
    sudo \
    locales \
    tzdata \
    vim \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# create ~/.config
ARG USERNAME=ubuntu
ARG UID=1000
# USER ${USERNAME}
# RUN mkdir /home/${USERNAME}/.config
# USER root

# configure sudo
RUN echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# configure locale to en_US.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# configure timezone to EST
ENV TZ="America/New_York"

# copy over a bashrc file
COPY bashrc /home/${USERNAME}/.bashrc

# execute this entrypoint script (built into the container) in bash with arguments set below
ENTRYPOINT ["/bin/bash", "/ros_entrypoint.sh"]
# the default argument to the entrypoint.sh script if no others are passed
CMD ["tmux"]