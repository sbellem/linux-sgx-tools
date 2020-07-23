***************
Linux SGX Tools
***************
**Work in Progress**

This repository aims to contain the necessary files to build the tools from
`oscarlab/graphene`_ found under `graphene/Pal/src/host/Linux-SGX/tools/`_.

This is work in progress and is subject to breaking changes without notice.

The original README content of the oscarlab/graphene repository is below
for the time-being, for convenience, as a reference.

Building the tools
==================

Clone the repo first:

.. code-block:: shell

    $ git clone git@github.com:sbellem/linux-sgx-tools.git
    $ cd linux-sgx-tools


Using docker
------------

.. code-block:: shell
    
    $ docker build -t linux-sgx-tools .

quick check:

.. code-block:: shell

    $ docker run --rm linux-sgx-tools ./verify-ias-report/verify_ias_report
    Usage: ./verify-ias-report/verify_ias_report [options]
    Available options:
      --help, -h                Display this help
      --verbose, -v             Enable verbose output
      --msb, -m                 Print/parse hex strings in big-endian order
      --report-path, -r PATH    Path to the IAS report
      --sig-path, -s PATH       Path to the IAS report's signature
      --allow-outdated-tcb, -o  Treat IAS status GROUP_OUT_OF_DATE as OK
      --nonce, -n STRING        Nonce that's expected in the report (optional)
      --mr-signer, -S STRING    Expected mr_signer field (hex string, optional)
      --mr-enclave, -E STRING   Expected mr_enclave field (hex string, optional)
      --report-data, -R STRING  Expected report_data field (hex string, optional)
      --isv-prod-id, -P NUMBER  Expected isv_prod_id field (uint16_t, optional)
      --isv-svn, -V NUMBER      Expected isv_svn field (uint16_t, optional)
      --ias-pubkey, -i PATH     Path to IAS public RSA key (PEM format, optional)

Using the image hosted on DockerHub
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Please note that there is no guarantee that it may be up-to-date with latest
code.

.. code-block:: shell

    $ docker pull sbellem/linux-sgx-tools

.. code-block:: shell
    
    $ docker run --rm sbellem/linux-sgx-tools ./verify-ias-report/verify_ias_report
    Usage: ./verify-ias-report/verify_ias_report [options]
    Available options:
      --help, -h                Display this help
      --verbose, -v             Enable verbose output
      --msb, -m                 Print/parse hex strings in big-endian order
      --report-path, -r PATH    Path to the IAS report
      --sig-path, -s PATH       Path to the IAS report's signature
      --allow-outdated-tcb, -o  Treat IAS status GROUP_OUT_OF_DATE as OK
      --nonce, -n STRING        Nonce that's expected in the report (optional)
      --mr-signer, -S STRING    Expected mr_signer field (hex string, optional)
      --mr-enclave, -E STRING   Expected mr_enclave field (hex string, optional)
      --report-data, -R STRING  Expected report_data field (hex string, optional)
      --isv-prod-id, -P NUMBER  Expected isv_prod_id field (uint16_t, optional)
      --isv-svn, -V NUMBER      Expected isv_svn field (uint16_t, optional)
      --ias-pubkey, -i PATH     Path to IAS public RSA key (PEM format, optional)


Without docker
--------------

.. code-block:: shell

    $ make SGX=1 -C Pal/lib/ target=$PWD/Pal/src/host/Linux-SGX/.lib/
    $ make -C Pal/src/host/Linux-SGX/tools/

check that the executable tool has been generated:

.. code-block:: shell

    $ ls Pal/src/host/Linux-SGX/tools/verify-ias-report/verify_ias_report
    Pal/src/host/Linux-SGX/tools/verify-ias-report/verify_ias_report

check that it works:

.. code-block:: shell

    $ LD_LIBRARY_PATH=$PWD/Pal/src/host/Linux-SGX/tools/common:$PWD/Pal/lib/crypto/mbedtls/install/lib \
        ./Pal/src/host/Linux-SGX/tools/verify-ias-report/verify_ias_report --help
    Usage: ./Pal/src/host/Linux-SGX/tools/verify-ias-report/verify_ias_report [options]
    Available options:
      --help, -h                Display this help
      --verbose, -v             Enable verbose output
      --msb, -m                 Print/parse hex strings in big-endian order
      --report-path, -r PATH    Path to the IAS report
      --sig-path, -s PATH       Path to the IAS report's signature
      --allow-outdated-tcb, -o  Treat IAS status GROUP_OUT_OF_DATE as OK
      --nonce, -n STRING        Nonce that's expected in the report (optional)
      --mr-signer, -S STRING    Expected mr_signer field (hex string, optional)
      --mr-enclave, -E STRING   Expected mr_enclave field (hex string, optional)
      --report-data, -R STRING  Expected report_data field (hex string, optional)
      --isv-prod-id, -P NUMBER  Expected isv_prod_id field (uint16_t, optional)
      --isv-svn, -V NUMBER      Expected isv_svn field (uint16_t, optional)
      --ias-pubkey, -i PATH     Path to IAS public RSA key (PEM format, optional)


Next steps
==========
* Simplify: remove unecessary files. There's most certainly more files that could be
  removed.
* The paths could be simplified, i.e. less nesting.
* Remove the need to pass the ``SGX=1`` option.
* One top-level Makefile should be suffficient.
* Simplify the ``Dockerfile``. Perhaps some dependencies are not needed.
* Check with the graphene team if they thought about providing these tools
  on a standalone basis, decoupled from the rest of the graphene codebase.


.. _oscarlab/graphene: https://github.com/oscarlab/graphene
.. _graphene/Pal/src/host/Linux-SGX/tools/: https://github.com/oscarlab/graphene/tree/master/Pal/src/host/Linux-SGX/tools

******************************************
Graphene Library OS with Intel SGX Support
******************************************

.. image:: https://readthedocs.org/projects/graphene/badge/?version=latest
   :target: http://graphene.readthedocs.io/en/latest/?badge=latest
   :alt: Documentation Status

*A Linux-compatible Library OS for Multi-Process Applications*

.. This is not |~|, because that is in rst_prolog in conf.py, which GitHub cannot parse.
   GitHub doesn't appear to use it correctly anyway...
.. |nbsp| unicode:: 0xa0
   :trim:

.. highlight:: sh


What is Graphene?
=================

Graphene is a |nbsp| lightweight guest OS, designed to run a |nbsp| single
application with minimal host requirements. Graphene can run applications in an
isolated environment with benefits comparable to running a |nbsp| complete OS in
a |nbsp| virtual machine -- including guest customization, ease of porting to
different OSes, and process migration.

Graphene supports native, unmodified Linux applications on any platform.
Currently, Graphene runs on Linux and Intel SGX enclaves on Linux platforms.

With Intel SGX support, Graphene can secure a |nbsp| critical application in
a |nbsp| hardware-encrypted memory region. Graphene can protect applications
from a |nbsp| malicious system stack with minimal porting effort.

Our papers describe the motivation, design choices, and measured performance of
Graphene:

- `EuroSys 2014 <http://www.cs.unc.edu/~porter/pubs/tsai14graphene.pdf>`__
- `ATC 2017 <http://www.cs.unc.edu/~porter/pubs/graphene-sgx.pdf>`__

Graphene is *not a production-ready software* (yet)
===================================================

We are still in a process of transition from a research proof-of-concept into a
more reliable piece of software. The most important problems (which include
major security issues) are tracked in
`#1544 (Production blockers) <https://github.com/oscarlab/graphene/issues/1544>`__.
You should read it before installing and using Graphene.

How to get Graphene?
====================

The latest version of Graphene can be cloned from GitHub::

   git clone https://github.com/oscarlab/graphene.git

At this time Graphene is available only as source code. `Building instructions
are available <https://graphene.readthedocs.io/en/latest/building.html>`__.

How to run an application in Graphene?
======================================

Graphene library OS uses the PAL (``libpal.so``) as a loader to bootstrap
applications in the library OS. To start Graphene, PAL (``libpal.so``) will have
to be run as an executable, with the name of the program, and a |nbsp| "manifest
file" (per-app configuration) given from the command line. Graphene provides
three options for specifying the programs and manifest files:

- option 1 (automatic manifest)::

   [PATH TO Runtime]/pal_loader [PROGRAM] [ARGUMENTS]...
   (Manifest file: "[PROGRAM].manifest" or "manifest")

- option 2 (given manifest)::

   [PATH TO Runtime]/pal_loader [MANIFEST] [ARGUMENTS]...

Running an application requires some minimal configuration in the application's
manifest file. A |nbsp| sensible manifest file will include paths to the library
OS and other libraries the application requires; environment variables, such as
``LD_LIBRARY_PATH``; and file systems to be mounted.

Here is an example manifest file::

    loader.preload = file:LibOS/shim/src/libsysdb.so
    loader.env.LD_LIBRAY_PATH = /lib
    fs.mount.libc.type = chroot
    fs.mount.libc.path = /lib
    fs.mount.libc.uri = file:[relative path to Graphene root]/Runtime

More examples can be found in the test directories (``LibOS/shim/test``). We
have also tested several applications, such as GCC, Bash, and Apache.
The manifest files for these applications are provided in the
individual directories under ``Examples``.

For the full documentation of the Graphene manifest syntax, see the `Graphene
documentation
<https://graphene.readthedocs.io/en/latest/manifest-syntax.html>`__.

Automatically running applications via Graphene Shielded Containers (GSC)
-------------------------------------------------------------------------

Applications deployed as Docker images may be graphenized via the `gsc tool
<https://graphene.readthedocs.io/en/latest/manpages/gsc.html>`__.

Getting help
============

For the full documentation of the Graphene, see the `Graphene documentation
<https://graphene.readthedocs.io/en/latest/>`__.

For any questions, please send an email to support@graphene-project.io
(`public archive <https://groups.google.com/forum/#!forum/graphene-support>`__).

For bug reports, post an issue on our GitHub repository:
https://github.com/oscarlab/graphene/issues.


Deprecated Code
===============

We have some branches with legacy code (use at your own risk).

Build with Kernel-Level Sandboxing
----------------------------------

This feature is marked as EXPERIMENTAL and no longer exists in the master branch.
See `EXPERIMENTAL/linux-reference-monitor
<https://github.com/oscarlab/graphene/tree/EXPERIMENTAL/linux-reference-monitor>`__.
