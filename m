From: CKI Project <cki-project@redhat.com>
Date: Fri, 06 Mar 2020 07:21:21 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E8-200=2Efc31_=28fedora-31=29?=
Message-ID: <cki.0.RUSFX6M3H7@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello jforbes,

We ran automated tests on the following kernel build:

    Kernel package: kernel-5.5.8-200.fc31
         Task URL: https://koji.fedoraproject.org/koji/taskinfo?taskID=42225433

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Tests: FAILED

One or more kernel tests failed:

    s390x:
     ? LTP



All kernel binaries, config files, and logs are available for download here:

  https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/06/473884


We hope that these logs can help you find the problem quickly. For the full
detail on our testing procedures, please scroll to the bottom of this message.

Please reply to this email if you have any questions about the tests that we
ran or if you have any suggestions on how to make future tests more effective.

        ,-.   ,-.
       ( C ) ( K )  Continuous
        `-',-.`-'   Kernel
          ( I )     Integration
           `-'
______________________________________________________________________________

Hardware testing
----------------
We booted each kernel and ran the following tests:

  aarch64:
    Host 1:
       ? Boot test
       ? xfstests - ext4
       ? xfstests - xfs
       ? lvm thinp sanity
       ? stress: stress-ng
       ? ? Storage blktests

    Host 2:
       ? Boot test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Ethernet drivers sanity
       ? ? CIFS Connectathon
       ? ? LTP: openposix test suite

  ppc64le:
    Host 1:
       ? Boot test
       ? xfstests - ext4
       ? xfstests - xfs
       ? lvm thinp sanity
       ? ? Storage blktests

    Host 2:
       ? Boot test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Ethernet drivers sanity
       ? ? CIFS Connectathon
       ? ? LTP: openposix test suite

  s390x:
    Host 1:
       ? Boot test
       ? LTP
       ??? Loopdev Sanity
       ??? Memory function: memfd_create
       ??? Ethernet drivers sanity
       ? ??? CIFS Connectathon
       ? ??? LTP: openposix test suite

    Host 2:
       ? Boot test
       ? stress: stress-ng
       ? ? Storage blktests

  x86_64:
    Host 1:
       ? Boot test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Ethernet drivers sanity
       ? ? CIFS Connectathon
       ? ? LTP: openposix test suite

    Host 2:
       ? Boot test
       ? xfstests - ext4
       ? xfstests - xfs
       ? lvm thinp sanity
       ? stress: stress-ng
       ? ? Storage blktests

  Test sources: https://github.com/CKI-project/tests-beaker
    ? Pull requests are welcome for new tests or improvements to existing tests!

Waived tests
------------
If the test run included waived tests, they are marked with ?. Such tests are
executed but their results are not taken into account. Tests are waived when
their results are not reliable enough, e.g. when they're just introduced or are
being fixed.

Testing timeout
---------------
We aim to provide a report within reasonable timeframe. Tests that haven't
finished running yet are marked with ?.

