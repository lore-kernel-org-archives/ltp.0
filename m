From: Rachel Sibley <rasibley@redhat.com>
Date: Wed, 12 Feb 2020 08:42:53 -0500
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E3-200=2Efc31_=28fedora-31=29?=
In-Reply-To: <cki.0.DS0DIXTWC0@redhat.com>
References: <cki.0.DS0DIXTWC0@redhat.com>
Message-ID: <9929886b-3c37-9b9c-08d3-ee17cc6047c7@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 2/12/20 7:47 AM, CKI Project wrote:
> Hello jforbes,
> 
> We ran automated tests on a kernel build that you sent to Koji:
> 
>      Kernel package: kernel-5.5.3-200.fc31
>           Koji task: https://koji.fedoraproject.org/koji/taskinfo?taskID=41461280
> 
> The results of these automated tests are provided below.
> 
>      Overall result: FAILED (see details below)
>               Tests: FAILED
> 
> One or more kernel tests failed:
> 
>      ppc64le:
>       ? LTP

For some reason the logs weren't displayed, sorry about that, we'll work on fixing it. This was
related to a failed dmesg check, most likely caused from running on a slow kvm guest:

[13384.833419] watchdog: BUG: soft lockup - CPU#15 stuck for 23s! [kworker/15:7:818734]
[13803.193308] watchdog: BUG: soft lockup - CPU#4 stuck for 81s! [systemd:1]
[13848.036065] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [systemd:1]
[13876.373600] watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [migration/3:25]
[14031.893164] watchdog: BUG: soft lockup - CPU#7 stuck for 57s! [systemd:1]
[14091.229819] watchdog: BUG: soft lockup - CPU#5 stuck for 29s! [systemd:1]
[14262.013732] watchdog: BUG: soft lockup - CPU#7 stuck for 57s! [systemd-journal:820197]
[14262.013734] watchdog: BUG: soft lockup - CPU#2 stuck for 38s! [systemd:1]
[14382.653959] watchdog: BUG: soft lockup - CPU#10 stuck for 24s! [systemd:1]
> 
> 
>      Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/brew-pipeline/pipelines/432806
> 
> We hope that these logs can help you find the problem quickly. For the full
> detail on our testing procedures, please scroll to the bottom of this message.
> 
> Please reply to this email if you have any questions about the tests that we
> ran or if you have any suggestions on how to make future tests more effective.
> 
>          ,-.   ,-.
>         ( C ) ( K )  Continuous
>          `-',-.`-'   Kernel
>            ( I )     Integration
>             `-'
> ______________________________________________________________________________
> 
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
> 
>    aarch64:
>      Host 1:
>         ? Boot test
>         ? xfstests - ext4
>         ? xfstests - xfs
>         ? lvm thinp sanity
>         ? stress: stress-ng
>         ? ? Storage blktests
> 
>      Host 2:
>         ? Boot test
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? AMTU (Abstract Machine Test Utility)
>         ? Ethernet drivers sanity
>         ? ? CIFS Connectathon
>         ? ? LTP: openposix test suite
> 
>    ppc64le:
>      Host 1:
>         ? Boot test
>         ? xfstests - ext4
>         ? xfstests - xfs
>         ? lvm thinp sanity
>         ? ? Storage blktests
> 
>      Host 2:
>         ? Boot test
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? AMTU (Abstract Machine Test Utility)
>         ? Ethernet drivers sanity
>         ? ? CIFS Connectathon
>         ? ? LTP: openposix test suite
> 
>    x86_64:
>      Host 1:
>         ? Boot test
>         ? xfstests - ext4
>         ? xfstests - xfs
>         ? lvm thinp sanity
>         ? stress: stress-ng
>         ? ? Storage blktests
> 
>      Host 2:
>         ? Boot test
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? AMTU (Abstract Machine Test Utility)
>         ? Ethernet drivers sanity
>         ? ? CIFS Connectathon
>         ? ? LTP: openposix test suite
> 
>    Test sources: https://github.com/CKI-project/tests-beaker
>      ? Pull requests are welcome for new tests or improvements to existing tests!
> 
> Waived tests
> ------------
> If the test run included waived tests, they are marked with ?. Such tests are
> executed but their results are not taken into account. Tests are waived when
> their results are not reliable enough, e.g. when they're just introduced or are
> being fixed.
> 
> Testing timeout
> ---------------
> We aim to provide a report within reasonable timeframe. Tests that haven't
> finished running are marked with ?. Reports for non-upstream kernels have
> a Beaker recipe linked to next to each host.
> 
> 

