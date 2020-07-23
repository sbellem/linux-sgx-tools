***************
Linux SGX Tools
***************
**WORK IN PROGRESS** | **USE AT YOUR OWN RISK** | **NOT FOR PRODUCTION**

This repository aims to contain the necessary files to build the SGX tools
developed by `oscarlab/graphene`_ found under
`graphene/Pal/src/host/Linux-SGX/tools/`_.

This is work in progress and is subject to breaking changes without notice.
And again: **this is not for production use**.


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
