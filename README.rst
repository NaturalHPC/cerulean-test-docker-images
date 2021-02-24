###########################
Cerulean test Docker images
###########################

A set of Docker images containing various cluster schedulers for testing
purposes. These images are used for testing Cerulean, but may be useful to
others.

The implementation borrows heavily from the Xenon testing Docker images.

This repository currently offers 9 images:

``cerulean-test-base``
  A base image containing SSH and a ``cerulean`` user. You can log in using
  either the password ``kingfisher``, or the private key named ``id1_rsa`` in
  ``cerulean_test_docker_images/container_base/.ssh/``, or the private key named
  ``id2_rsa`` with passphrase ``kingfisher``.

``cerulean-test-webdav``
  An image based on cerulean-test-base, which has nginx installed and running,
  with WebDAV configured on ``/files``. You can connect on port 80 using HTTP
  or on port 443 using HTTPS. The server certificate is in
  ``cerulean_test_docker_images/container_base/.ssh/``.

``cerulean-test-torque-6``
  An image based on cerulean-test-base, which also has Torque 6 installed and
  running. The virtual cluster has 4 nodes, in two queues named ``batch`` and
  ``debug``. This container must be run with the ``--cap-add SYS_RESOURCE``
  option.

``cerulean-test-slurm-16-05``
  An image based on cerulean-test-base, which also has Slurm 16.05 installed and
  running. The virtual cluster has 4 nodes, in two queues named ``batch`` and
  ``debug``.

``cerulean-test-slurm-17-02``
  Like cerulean-test-slurm-16-05, but with Slurm 17.02.

``cerulean-test-slurm-17-11``
  Like cerulean-test-slurm-16-05, but with Slurm 17.11.

``cerulean-test-slurm-18-08``
  Like cerulean-test-slurm-16-05, but with Slurm 18.08.

``cerulean-test-slurm-19-05``
  Like cerulean-test-slurm-16-05, but with Slurm 19.05.

``cerulean-test-slurm-20-02``
  Like cerulean-test-slurm-16-05, but with Slurm 20.02.

``cerulean-test-slurm-20-11``
  Like cerulean-test-slurm-16-05, but with Slurm 20.11.

Note that these images are not entirely stable on purpose, they will be rebuilt
from time to time with the latest libraries. It's all within a single version of
the OS, so it's not that likely to break, but be aware that these are intended
for testing purposes, not production.

Installing
----------

These images are built automatically on Docker Hub, so you can just pull them:

.. code-block:: console

  docker pull cerulean-test-base

Then to run them, use

.. code-block:: console

  docker run --name cerulean-test-container -p 22:10022 cerulean-test-base

And then you can connect to them using

.. code-block:: console

  ssh -p 10022 cerulean@localhost

For the WebDAV container, you'll want to map its internal ports 80 and/or 443 to
some port on the host, instead of 22.


Contributing
************

If you want to contribute to the development of Cerulean test Docker images,
have a look at the `contribution guidelines <CONTRIBUTING.rst>`_.

License
*******

The contents of this repository are Copyright (c) 2018-2021 Netherlands eScience
Center, VU University Amsterdam and University of Amsterdam

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

The images contain an operating system environment based on Ubuntu 18.04, with
each component licensed under its own license. In particular, we use
``phusion/baseimage:18.04-1.0.0`` as a base image, which contains modifications
licensed under the MIT license as follows:

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

The ``cerulean-test-torque-6`` image contains Torque 6:

TORQUE is a modification of OpenPBS which was developed by NASA Ames
Research Center, Lawrence Livermore National Laboratory, and Veridian
Information Solutions, Inc. Visit www.clusterresources.com/products/ for more
information about TORQUE and to download TORQUE.

For information about Moab branded products and so receive support from Adaptive
Computing for TORQUE, see www.adaptivecomputing.com.
