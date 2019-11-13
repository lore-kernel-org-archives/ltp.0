From: CKI Project <cki-project@redhat.com>
Date: Wed, 13 Nov 2019 19:47:31 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E11-200=2Efc30_=28fedora-30=29?=
Message-ID: <cki.0.8DBA9TRM0T@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello jforbes,

We ran automated tests on a kernel build that you sent to Koji:

    Kernel package: kernel-5.3.11-200.fc30
         Koji task: https://koji.fedoraproject.org/koji/taskinfo?taskID=38948735

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Tests: FAILED

One or more kernel tests failed:

    ppc64le:
     ? xfstests: ext4
     ? LTP lite

    x86_64:
     ? Memory function: kaslr


    Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/brew-pipeline/pipelines/282059

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

  https://beaker.engineering.redhat.com/jobs/?jobsearch-0.table=Whiteboard&jobsearch-0.operation=contains&jobsearch-0.value=cki%40gitlab%3A282059

We booted each kernel and ran the following tests:

  aarch64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7563483
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

    Host 2: https://beaker.engineering.redhat.com/recipes/7566546
       ? Boot test
       ? LTP lite
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? Memory function: kaslr
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Networking bridge: sanity
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? L2TP basic test
       ? Networking tunnel: vxlan basic
       ? Networking ipsec: basic netns transport
       ? Networking ipsec: basic netns tunnel
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? storage: SCSI VPD
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? Networking vnic: ipvlan/basic
       ? ? storage: dm/common

  ppc64le:
    Host 1: https://beaker.engineering.redhat.com/recipes/7563485
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

    Host 2: https://beaker.engineering.redhat.com/recipes/7563484

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? LTP lite
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? Memory function: kaslr
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Networking bridge: sanity
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? L2TP basic test
       ? Networking tunnel: vxlan basic
       ? Networking ipsec: basic netns tunnel
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ??? POSIX pjd-fstest suites
       ? ? Networking vnic: ipvlan/basic
       ? ? storage: dm/common

  x86_64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7563481
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? IOMMU boot test
       ? ? Storage blktests

    Host 2: https://beaker.engineering.redhat.com/recipes/7563480
       ? Boot test
       ? LTP lite
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? Memory function: kaslr
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Networking bridge: sanity
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? L2TP basic test
       ? Networking tunnel: vxlan basic
       ? Networking ipsec: basic netns transport
       ? Networking ipsec: basic netns tunnel
       ? pciutils: sanity smoke test
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? storage: SCSI VPD
       ? stress: stress-ng
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? Networking vnic: ipvlan/basic
       ? ? storage: dm/common

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

