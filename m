From: CKI Project <cki-project@redhat.com>
Date: Wed, 15 Jan 2020 09:34:15 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E12-100=2Efc30_=28fedora-30=29?=
Message-ID: <cki.0.BMO32N203K@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello jcline,

We ran automated tests on a kernel build that you sent to Koji:

    Kernel package: kernel-5.4.12-100.fc30
         Koji task: https://koji.fedoraproject.org/koji/taskinfo?taskID=40542166

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Tests: FAILED

One or more kernel tests failed:

    ppc64le:
     ? LTP


    Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/brew-pipeline/pipelines/384229

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
All the testing jobs are listed here:

  https://beaker.engineering.redhat.com/jobs/?jobsearch-0.table=Whiteboard&jobsearch-0.operation=contains&jobsearch-0.value=cki%40gitlab%3A384229

We booted each kernel and ran the following tests:

  aarch64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7797420

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? xfstests: ext4
       ??? xfstests: xfs
       ??? lvm thinp sanity
       ??? stress: stress-ng
       ? ??? Storage blktests

    Host 2: https://beaker.engineering.redhat.com/recipes/7797419
       ? Boot test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Ethernet drivers sanity
       ? ? CIFS Connectathon
       ? ? LTP: openposix test suite

    Host 3: https://beaker.engineering.redhat.com/recipes/7797482
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? stress: stress-ng
       ? ? Storage blktests

  ppc64le:
    Host 1: https://beaker.engineering.redhat.com/recipes/7797422
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? ? Storage blktests

    Host 2: https://beaker.engineering.redhat.com/recipes/7797421
       ? Boot test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Ethernet drivers sanity
       ? ? CIFS Connectathon
       ? ? LTP: openposix test suite

  x86_64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7797418
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? stress: stress-ng
       ? ? Storage blktests

    Host 2: https://beaker.engineering.redhat.com/recipes/7797417
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

Waived tests
------------
If the test run included waived tests, they are marked with ?. Such tests are
executed but their results are not taken into account. Tests are waived when
their results are not reliable enough, e.g. when they're just introduced or are
being fixed.

Testing timeout
---------------
We aim to provide a report within reasonable timeframe. Tests that haven't
finished running are marked with ?. Reports for non-upstream kernels have
a Beaker recipe linked to next to each host.

Reproducing results
-------------------
Click on a link below to access a web page that allows you to adjust the
Beaker job and re-run any failed tests. These links are generated for
failed or aborted tests that are not waived. Please adjust the Beaker
job whiteboard string in the web page so that it is easy for you to find
and so that it is not confused with regular CKI job.

After clicking the "Submit the job!" button, a dialog with an url will open.
Opening that url will show you the progress of submitting your job.
At the end it should say "Submitted job J:XXXXX", meaning the job was really
sent to Beaker.

  http://respin-service-ark.cloud.paas.psi.redhat.com/respin.html?whiteboard=respin_job_4015280&recipe_id=7797421&job_id=4015280

