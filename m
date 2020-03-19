From: CKI Project <cki-project@redhat.com>
Date: Thu, 19 Mar 2020 23:29:48 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E6?=
 =?utf-8?b?LjAtMC5yYzYuMS5lbHJkeSAoYXJrKQ==?=
Message-ID: <cki.0.3BUOOMLQYT@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello jcline,

We ran automated tests on the following kernel build:

    Kernel package: kernel-5.6.0-0.rc6.1.elrdy
         Task URL: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=27363489

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Tests: FAILED

One or more kernel tests failed:

    aarch64:
     ? LTP



    Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/brew-pipeline/pipelines/496090

    Check out our dashboard including known failures tagged by our bot ? at
      https://datawarehouse-webservice-ark.cloud.paas.psi.redhat.com/pipeline/496090

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
All the testing jobs are listed here:

  https://beaker.engineering.redhat.com/jobs/?jobsearch-0.table=Whiteboard&jobsearch-0.operation=contains&jobsearch-0.value=cki%40gitlab%3A496090

We booted each kernel and ran the following tests:

  aarch64:
    Host 1: https://beaker.engineering.redhat.com/recipes/8041714

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? ACPI table test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Ethernet drivers sanity
       ? Libhugetlbfs - version 2.2.1
       ? ? CIFS Connectathon
       ? ??? LTP: openposix test suite
       ? ??? perf: internal-testsuite

  ppc64le:
    Host 1: https://beaker.engineering.redhat.com/recipes/8041963

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? xfstests - ext4
       ??? xfstests - xfs
       ??? lvm thinp sanity
       ? ??? Storage blktests

  s390x:
    Host 1: https://beaker.engineering.redhat.com/recipes/8041274

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? ??? kdump - sysrq-c

    Host 2: https://beaker.engineering.redhat.com/recipes/8041649

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? Loopdev Sanity
       ??? Memory function: memfd_create
       ??? Ethernet drivers sanity
       ? ??? CIFS Connectathon
       ? ??? LTP: openposix test suite
       ? ??? perf: internal-testsuite

    Host 3: https://beaker.engineering.redhat.com/recipes/8041651

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ? ??? Storage blktests

  x86_64:
    Host 1: https://beaker.engineering.redhat.com/recipes/8041438

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ??? xfstests - ext4
       ??? xfstests - xfs
       ??? lvm thinp sanity
       ??? stress: stress-ng
       ? ??? Storage blktests

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

  http://respin-service-ark.cloud.paas.psi.redhat.com/respin.html?whiteboard=respin_job_4146696&recipe_id=8041714&job_id=4146696

