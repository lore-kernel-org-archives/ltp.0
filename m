From: CKI Project <cki-project@redhat.com>
Date: Mon, 11 Nov 2019 08:05:36 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc6-dd89262=2Ecki_=28mainline=2Ekernel=2Eorg=29?=
Message-ID: <cki.ECB352932E.9FL0Q68EC2@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
            Commit: dd892625d0e2 - Merge tag 'staging-5.4-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://artifacts.cki-project.org/pipelines/277487

One or more kernel tests failed:

    x86_64:
     ? selinux-policy: serge-testsuite
     ? LTP lite

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
We booted each kernel and ran the following tests:

  x86_64:
    Host 1:

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? IOMMU boot test
       ? ??? Storage blktests

    Host 2:
       ? Boot test
       ? ? IPMI driver test
       ? ? IPMItool loop stress test

    Host 3:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP lite
       ? Loopdev Sanity
       ? jvm test suite
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
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
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

