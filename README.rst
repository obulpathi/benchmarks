=========================
Cloud Queues Benchmarking
=========================

Cloud Queues uses `Tsung`_ (Tsung 1.5 or higher) to run load tests.

**Table of Contents**

.. contents::
    :local:
    :depth: 2
    :backlinks: none


-----------------------------------
Setting up the benchmarking cluster
-----------------------------------

#. Create a webserver server to archive the benchmarks and host them using nginix.
#. Create Tsung controller machines using Ubuntu 13.10.
#. Setup passwordless SSH between benchmarks hosting server and each of the Tsung controllers.
#. Update the /etc/hosts in all the benchmarks server. The server:/etc/hosts should have entries pointing to all theTsung controllers.
#. apt-get update && apt-get -y upgrade
#. apt-get install -y fabric nginx
#. Clone this repository from GitHub and navigate to Benchmarks folder.
#. Use of the fabric commands:
    * fab setup: to set up the Tsung controllers.
    * fab benchmark: to perform a benchmark and copy the logs to server.
    * fab publish: to publish the latest logs to the benchmarks.cldqs.com
    * fab update: to date the installed software and scripts on Tsung controlelrs.
#. Convention for hostnames is as follows:
    * Webserver is named as benchmarks-server
    * Tsung controllers are named as benchmarks-{hkg, lon, syd, iad, ord, dfw}

.. _`Tsung` : http://tsung.erlang-projects.org/
