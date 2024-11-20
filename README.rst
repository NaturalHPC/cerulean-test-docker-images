###########################
Cerulean test Docker images
###########################

.. image:: https://github.com/naturalhpc/cerulean-test-docker-images/actions/workflows/build_push.yaml/badge.svg
   :target: https://github.com/naturalhpc/cerulean-test-docker-images/actions
   :alt: Build status badge

A set of Docker images containing various cluster schedulers for testing
purposes. These images are used for testing Cerulean, but may be useful to
others. No attempt has been made at creating a secure configuration, just
a working one.

The implementation was developed from the Xenon testing Docker images.

This repository currently offers 16 images:

``cerulean-fake-base``
  A base image containing SSH and a ``cerulean`` user. You can log in using
  either the password ``kingfisher``, or the private key named ``id1_rsa`` in
  ``cerulean_test_docker_images/container_base/.ssh/``, or the private key named
  ``id2_rsa`` with passphrase ``kingfisher``.

``cerulean-fake-base-old``
  Like ``cerulean-fake-base`` but with Ubuntu 18.04 rather than 22.04.

``cerulean-fake-webdav``
  An image based on cerulean-fake-base, which has nginx installed and running,
  with WebDAV configured on ``/files``. You can connect on port 80 using HTTP
  or on port 443 using HTTPS. The server certificate is in
  ``cerulean_test_docker_images/container_base/.ssh/``.

``cerulean-fake-torque-6``
  An image based on cerulean-fake-base, which also has Torque 6 installed and
  running. The virtual cluster has 4 nodes, in two queues named ``batch`` and
  ``debug``. This container must be run with the ``--cap-add SYS_RESOURCE``
  option.

``cerulean-fake-slurm-17-02``
  An image based on cerulean-fake-base-old, which also has all the listed versions of
  Slurm installed, and 17.02 loaded by default and running.

  The container expects to be started with hostname `headnode`.

  If the environment variable SELF_CONTAINED is set to 1 when starting the container,
  it will run both the headnode and five nodes, which are in two queues named ``batch``
  and ``debug``. If SELF_CONTAINED is not set, then you'll need to start five additional
  containers with hostnames `node-0` through `node-4`, in the same network so that they
  can connect to each other. See below.

``cerulean-fake-slurm-17-11``
  Like cerulean-fake-slurm-17-02, but with Slurm 17.11.

``cerulean-fake-slurm-18-08``
  Like cerulean-fake-slurm-17-02, but with Slurm 18.08.

``cerulean-fake-slurm-19-05``
  Like cerulean-fake-slurm-17-02, but with Slurm 19.05.

``cerulean-fake-slurm-20-02``
  Like cerulean-fake-slurm-17-02, but with Slurm 20.02.

``cerulean-fake-slurm-20-11``
  Like cerulean-fake-slurm-17-02, but based on cerulean-fake-base and with Slurm 20.11.

``cerulean-fake-slurm-21-08``
  Like cerulean-fake-slurm-20-11, but with Slurm 21.08.

``cerulean-fake-slurm-22-05``
  Like cerulean-fake-slurm-20-11, but with Slurm 22.05.

``cerulean-fake-slurm-23-02``
  Like cerulean-fake-slurm-20-11, but with Slurm 23.02.

``cerulean-fake-slurm-23-11``
  Like cerulean-fake-slurm-20-11, but with Slurm 23.11.

``cerulean-fake-slurm-flaky``
  Like cerulean-fake-slurm-17-11, but kills ssh connections regularly.

Note that these images are not entirely stable on purpose, they will be rebuilt
from time to time with the latest libraries. It's all within a single version of
the OS, so it's not that likely to break, but be aware that these are intended
for testing purposes, not production.

Installing
----------

These images are built automatically on Github, so you can pull them to your local
machine using:

.. code-block:: console

  docker pull ghcr.io/naturalhpc/cerulean-test-docker-images/cerulean-fake-base


(With apologies for the long URL, GitHub's container publishing system is a bit of
a hack.)

Running
-------

Then to run them, use

.. code-block:: console

  docker run --name cerulean-fake-container -p 10022:22 ghcr.io/naturalhpc/cerulean-test-docker-images/cerulean-fake-base


And then you can connect to them using

.. code-block:: console

  ssh -p 10022 cerulean@localhost

For the WebDAV container, you'll want to map its internal ports 80 and/or 443 to
some port on the host, instead of 22.

The SSH password is `kingfisher`, or you can log in using
`images/fake-base/.ssh/id1_rsa` with no passphrase, or using
`images/fake-base/.ssh/id2_rsa` with passphrase `kingfisher`.

For Slurm containers, you can run a self-contained cluster using:

.. code-block:: console

  docker run -d -p 10022:22 --hostname headnode --env SELF_CONTAINED=1 --cap-add CAP_SYS_NICE ghcr.io/naturalhpc/cerulean-fake-slurm-22-05


The CAP_SYS_NICE capability is needed because the Slurm configuration has core binding
enabled, so it will try to do that and fail if it doesn't have CAP_SYS_NICE.

Alternatively, you can run a multi-container fake cluster using

.. code-block:: console

  docker network create mynet
  docker run -d --hostname headnode --network mynet -p 10022:22 ghcr.io/naturalhpc/cerulean-fake-slurm-22-05
  docker run -d --hostname node-0 --network mynet ghcr.io/naturalhpc/cerulean-fake-slurm-22-05
  docker run -d --hostname node-1 --network mynet ghcr.io/naturalhpc/cerulean-fake-slurm-22-05
  docker run -d --hostname node-2 --network mynet ghcr.io/naturalhpc/cerulean-fake-slurm-22-05
  docker run -d --hostname node-3 --network mynet ghcr.io/naturalhpc/cerulean-fake-slurm-22-05
  docker run -d --hostname node-4 --network mynet ghcr.io/naturalhpc/cerulean-fake-slurm-22-05


You can then ssh to localhost on port 10022 to connect to the fake cluster headnode and
submit jobs.


Contributing
************

If you want to contribute to the development of Cerulean test Docker images,
have a look at the `contribution guidelines <CONTRIBUTING.rst>`_.

License
*******

The contents of this repository are Copyright 2018-2021 Netherlands eScience
Center, VU University Amsterdam and University of Amsterdam, and Copyright 2024
Netherlands eScience Center.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Image contents
--------------

The images contain an operating system environment based on Ubuntu 18.04 or
Ubuntu 22.04, with each component licensed under its own license. In particular,
we use ``phusion/baseimage::18.04-10.0.`` and ``phusion/baseimage:jammy-1.0.2``
as base images, which are based on Ubuntu and contain modifications licensed under
the MIT license as follows:

Copyright (c) 2013-2015 Phusion Holding B.V.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

The ``cerulean-fake-torque-6`` image contains Torque 6:

TORQUE is a modification of OpenPBS which was developed by NASA Ames
Research Center, Lawrence Livermore National Laboratory, and Veridian
Information Solutions, Inc. Visit www.clusterresources.com/products/ for more
information about TORQUE and to download TORQUE.

For information about Moab branded products and so receive support from Adaptive
Computing for TORQUE, see www.adaptivecomputing.com.
