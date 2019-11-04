From: CKI Project <cki-project@redhat.com>
Date: Mon, 04 Nov 2019 03:36:24 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E9-rc1-dfe283e=2Ecki_=28stable=29?=
Message-ID: <cki.1210A7ECB0.BD9Q3APV4K@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
            Commit: dfe283e9fdac - Linux 5.3.9-rc1

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://artifacts.cki-project.org/pipelines/262380

One or more kernel tests failed:

    x86_64:
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

We compiled the kernel for 3 architectures:

    aarch64:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg

    ppc64le:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg

    x86_64:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg


Hardware testing
----------------
We booted each kernel and ran the following tests:

  aarch64:
    Host 1:
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
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? Networking tunnel: vxlan basic
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? storage: SCSI VPD
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? Networking bridge: sanity
       ? ? Networking route_func: local
       ? Networking route_func: forward
       ? ? L2TP basic test
       ? ? Networking vnic: ipvlan/basic
       ? ? storage: dm/common
       ? ? Networking ipsec: basic netns transport
       ? ? Networking ipsec: basic netns tunnel

    Host 2:
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

  ppc64le:
    Host 1:
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
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ? Networking route: pmtu
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? Networking tunnel: vxlan basic
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? Networking bridge: sanity
       ? ? Networking route_func: local
       ? Networking route_func: forward
       ? ? L2TP basic test
       ? ? Networking ipsec: basic netns tunnel
       ? ? Networking vnic: ipvlan/basic
       ? ? storage: dm/common

    Host 2:
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

  x86_64:
    Host 1:
       ? Boot test
       ? ? IPMI driver test
       ? ? IPMItool loop stress test

    Host 2:
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
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? Networking tunnel: vxlan basic
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
       ? ? Networking bridge: sanity
       ? ? Networking route_func: local
       ? Networking route_func: forward
       ? ? L2TP basic test
       ? ? Networking vnic: ipvlan/basic
       ? ? storage: dm/common
       ? ? Networking ipsec: basic netns transport
       ? ? Networking ipsec: basic netns tunnel

    Host 3:
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? IOMMU boot test
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
finished running are marked with ?. Reports for non-upstream kernels have
a Beaker recipe linked to next to each host.

