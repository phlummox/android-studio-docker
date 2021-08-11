## android-studio-docker [WORK IN PROGRESS]

[![Docker hub version](https://img.shields.io/docker/v/phlummox/android-studio?label=Docker%20Hub)](https://hub.docker.com/r/phlummox/android-studio)

A Docker image designed to work with [Gitpod][gitpod], letting you run
Android Studio as a cloud-based IDE.

![Android studio running in the cloud](https://raw.githubusercontent.com/wiki/phlummox/android-studio-docker/using_images/studio-running.png) \
&nbsp;

[gitpod]: https://www.gitpod.io/

### Current status

-   Works, but -
-   doesn't persist settings/downloaded plugins/SDKs etc

## Usage

### Simple demo

See the [wiki][wiki-using] for brief instructions on how to use this instance
in Gitpod on the web.

[wiki-using]: https://github.com/phlummox/android-studio-docker/wiki/using

### Use with your own GitHub project

Create a `.gitpod.yml` file in your repository, with the contents

```
image: phlummox/android-studio:latest
  file: .gitpod.Dockerfile

ports:
  - port: 6080
    protocol: "http"

# List the start up tasks. You can start them in parallel in multiple terminals. See https://www.gitpod.io/docs/config-start-tasks/
tasks:
  - init: echo 'init script' # runs during prebuild
    command: echo 'start script'
```

For more on how to configure Gitpod using this file, see <https://www.gitpod.io/docs/config-gitpod-file/>.

Once the file is pushed to GitHub, you should be able to visit XXX

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

At any rate, if you want to do that, you can run the following:

```bash
$ docker pull phlummox/android-studio:latest
$	docker run --rm -it -p 6080:6080 --hostname my-host phlummox/android-studio:latest bash
```
Replace "my-host" with the hostname of your host machine.
Within the container, look at the contents of the file
`/tmp/display-:0.log`.

Not far from the start, it should say

```
Navigate to this URL:

  http://myhost:6080/vnc.html?host=myhost&port=6080

Press Ctrl-C to exit
```

Open that URL in your browser, and you should have access to the X Window
session.

In the terminal where you have the container running, enter `android_studio`,
and Studio should start in the browser tab.


