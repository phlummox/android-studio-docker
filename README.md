## android-studio-docker

[![Docker hub version](https://img.shields.io/docker/v/phlummox/android-studio?label=Docker%20Hub)](https://hub.docker.com/r/phlummox/android-studio)

A Docker image designed to work with [Gitpod][gitpod], letting you run
Android Studio as a cloud-based IDE.

![Android studio running in the cloud](https://raw.githubusercontent.com/wiki/phlummox/android-studio-docker/using_images/studio-running.png) \
&nbsp;

[gitpod]: https://www.gitpod.io/

### Simple demo

See the [wiki][wiki-using] for brief instructions on how to use this instance
in Gitpod on the web.

[wiki-using]: wiki/using

### Running locally

Running the container locally on your machine is also possible, though not especially
pleasant: I find the X server tends to die periodically for unknown reasons.
You're probably better off [sharing your `/tmp/.X11-unix` unix socket][x-socket]
with the guest container. (For other ways of running GUI applications
in a Docker container, see the excellent [page][docker-gui] on this topic
on the [ROS wiki][ros].)

[x-socket]: https://medium.com/@l10nn/running-x11-applications-with-docker-75133178d090
[docker-gui]: http://wiki.ros.org/docker/Tutorials/GUI
[ros]: http://wiki.ros.org/




