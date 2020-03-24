From: CKI Project <cki-project@redhat.com>
Date: Tue, 24 Mar 2020 00:56:03 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E11-200=2Efc31_=28fedora-31=29?=
Message-ID: <cki.0.9NFIKZ9EH2@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello jforbes,

We ran automated tests on the following kernel build:

    Kernel package: kernel-5.5.11-200.fc31
         Task URL: https://koji.fedoraproject.org/koji/taskinfo?taskID=42723737

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Tests: FAILED

One or more kernel tests failed:

    ppc64le:
     ? LTP



All kernel binaries, config files, and logs are available for download here:

  https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/23/502235

Please reply to this email if you have any questions about the tests that we
ran or if you have any suggestions on how to make future tests more effective.
For the full detail on our testing procedures, please scroll to the bottom of
this message.

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
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? Ethernet drivers sanity
       ? ? CIFS Connectathon
       ? ? LTP: openposix test suite

    Host 2:
       ? Boot test
       ? ? Storage blktests

  x86_64:
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

  Test sources: https://github.com/CKI-project/tests-beaker
    ? Pull requests are welcome for new tests or improvements to existing tests!

Aborted tests
-------------
Tests that didn't complete running successfully are marked with ???.
If this was caused by an infrastructure issue, we try to mark that
explicitly in the report.

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

