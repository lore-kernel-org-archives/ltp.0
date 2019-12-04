From: CKI Project <cki-project@redhat.com>
Date: Wed, 04 Dec 2019 17:52:08 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E2?=
 =?utf-8?q?=2E21-rt14-eccdce6=2Ecki_=28rt-devel=29?=
Message-ID: <cki.A05205186F.8840CLEZ0B@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
            Commit: eccdce6cb526 - v5.2.21-rt14

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

    Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/pipelines/323141

One or more kernel tests failed:

    x86_64:
     ? LTP

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

Compile testing
---------------

We compiled the kernel for 1 architecture:

    x86_64:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg


Hardware testing
----------------
All the testing jobs are listed here:

  https://beaker.engineering.redhat.com/jobs/?jobsearch-0.table=Whiteboard&jobsearch-0.operation=contains&jobsearch-0.value=cki%40gitlab%3A323141

We booted each kernel and ran the following tests:

  x86_64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7651035
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? Memory function: kaslr
       ? AMTU (Abstract Machine Test Utility)
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
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? tuned: tune-processes-through-perf
       ? pciutils: sanity smoke test
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? storage: SCSI VPD
       ? stress: stress-ng
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? jvm test suite
       ? ? LTP: openposix test suite
       ? ? Networking vnic: ipvlan/basic
       ? ? iotop: sanity
       ? ? Usex - version 1.9-29
       ? ? storage: dm/common

    Host 2: https://beaker.engineering.redhat.com/recipes/7651037
       ? Boot test
       ? Storage SAN device stress - megaraid_sas

    Host 3: https://beaker.engineering.redhat.com/recipes/7651036
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? IOMMU boot test
       ? ? IPMI driver test
       ? ? IPMItool loop stress test
       ? ? selinux-policy: serge-testsuite
       ? ? Storage blktests

    Host 4: https://beaker.engineering.redhat.com/recipes/7651038
       ? Boot test
       ? Storage SAN device stress - mpt3sas driver

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

