################################################################################
Cerulean test Docker images
################################################################################

A set of Docker images containing various cluster schedulers for testing
purposes. These images are used for testing Cerulean, but may be useful to
others.

The implementation borrows heavily from the Xenon testing Docker images.

This repository currently offers 7 images:

``cerulean-test-base``
  A base image containing SSH and a ``cerulean`` user. You can log in using
  either the password ``kingfisher``, or the private key named ``id1_rsa`` in
  ``cerulean_test_docker_images/container_base/.ssh/``, or the private key named
  ``id2_rsa`` with passphrase ``kingfisher``.

``cerulean-test-torque-6``
  An image based on cerulean-test-base, which also has Torque 6 installed and
  running. The virtual cluster has 4 nodes, in two queues named ``batch`` and
  ``debug``. This container must be run with the ``--cap-add SYS_RESOURCE``
  option.

``cerulean-test-slurm-14-11``
  An image based on cerulean-test-base, which also has Slurm 14.11 installed and
  running. The virtual cluster has 4 nodes, in two queues named ``batch`` and
  ``debug``.

``cerulean-test-slurm-15-08``
  Like cerulean-test-slurm-14-11, but with Slurm 15.08.

``cerulean-test-slurm-16-05``
  Like cerulean-test-slurm-14-11, but with Slurm 16.05.

``cerulean-test-slurm-17-02``
  Like cerulean-test-slurm-14-11, but with Slurm 17.02.

``cerulean-test-slurm-17-11``
  Like cerulean-test-slurm-14-11, but with Slurm 17.11.

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


Contributing
************

If you want to contribute to the development of Cerulean test Docker images,
have a look at the `contribution guidelines <CONTRIBUTING.rst>`_.

License
*******

Copyright (c) 2018, Netherlands eScience Center and VU University Amsterdam

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
