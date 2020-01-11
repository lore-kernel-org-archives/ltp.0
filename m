From: CKI Project <cki-project@redhat.com>
Date: Sat, 11 Jan 2020 04:47:01 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E11-rc1-ba0685a=2Ecki_=28stable=29?=
Message-ID: <cki.4D5FABAF36.OR1DC5U2IE@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
            Commit: ba0685a72f10 - Linux 5.4.11-rc1

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://artifacts.cki-project.org/pipelines/375737

One or more kernel tests failed:

    aarch64:
     ? Networking tunnel: geneve basic test
     ? Networking tunnel: gre basic
     ? Networking tunnel: vxlan basic

    x86_64:
     ? Networking route_func: local
     ? Networking tunnel: geneve basic test
     ? Networking tunnel: gre basic
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

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Networking bridge: sanity
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ??? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ??? L2TP basic test
       ? Networking tunnel: vxlan basic
       ? Networking ipsec: basic netns transport
       ? Networking ipsec: basic netns tunnel
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? tuned: tune-processes-through-perf
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? storage: SCSI VPD
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ??? jvm test suite
       ? ? Memory function: kaslr
       ? ? LTP: openposix test suite
       ? ? Networking vnic: ipvlan/basic
       ? ? iotop: sanity
       ? ? Usex - version 1.9-29
       ? ? storage: dm/common

    Host 2:
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? stress: stress-ng
       ? ? IPMI driver test
       ? ? IPMItool loop stress test
       ? ? Storage blktests

    Host 3:
       ? Boot test
       ? Podman system integration test (as root)
       ?  Podman system integration test (as user)
       ?  LTP
       ?  Loopdev Sanity
       ?  Memory function: memfd_create
       ?  AMTU (Abstract Machine Test Utility)
       ?  Networking bridge: sanity
       ?  Ethernet drivers sanity
       ?  Networking MACsec: sanity
       ?  Networking socket: fuzz
       ?  Networking sctp-auth: sockopts test
       ?  Networking: igmp conformance test
       ?  Networking route: pmtu
       ?  Networking route_func: local
       ?  Networking route_func: forward
       ?  Networking TCP: keepalive test
       ?  Networking UDP: socket
       ?  Networking tunnel: geneve basic test
       ?  Networking tunnel: gre basic
       ?  L2TP basic test
       ?  Networking tunnel: vxlan basic
       ?  Networking ipsec: basic netns transport
       ?  Networking ipsec: basic netns tunnel
       ?  audit: audit testsuite test
       ?  httpd: mod_ssl smoke sanity
       ?  tuned: tune-processes-through-perf
       ?  ALSA PCM loopback test
       ?  ALSA Control (mixer) Userspace Element test
       ?  storage: SCSI VPD
       ?  trace: ftrace/tracer
       ?  CIFS Connectathon
       ?  POSIX pjd-fstest suites
       ?  jvm test suite
       ?  Memory function: kaslr
       ?  LTP: openposix test suite
       ?  Networking vnic: ipvlan/basic
       ?  iotop: sanity
       ?  Usex - version 1.9-29
       ?  storage: dm/common

  ppc64le:
    Host 1:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
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
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? tuned: tune-processes-through-perf
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? trace: ftrace/tracer
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? jvm test suite
       ? ? Memory function: kaslr
       ? ? LTP: openposix test suite
       ? ? Networking vnic: ipvlan/basic
       ? ? iotop: sanity
       ? ? Usex - version 1.9-29
       ? ? storage: dm/common

    Host 2:
       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? IPMI driver test
       ? ? IPMItool loop stress test
       ? ? Storage blktests

  x86_64:
    Host 1:
       ? Boot test
       ? Storage SAN device stress - megaraid_sas

    Host 2:

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
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
       ??? Networking tunnel: vxlan basic
       ??? Networking ipsec: basic netns transport
       ??? Networking ipsec: basic netns tunnel
       ??? audit: audit testsuite test
       ??? httpd: mod_ssl smoke sanity
       ??? tuned: tune-processes-through-perf
       ??? pciutils: sanity smoke test
       ??? ALSA PCM loopback test
       ??? ALSA Control (mixer) Userspace Element test
       ??? storage: SCSI VPD
       ??? trace: ftrace/tracer
       ? ??? CIFS Connectathon
       ? ??? POSIX pjd-fstest suites
       ? ??? jvm test suite
       ? ??? Memory function: kaslr
       ? ??? LTP: openposix test suite
       ? ??? Networking vnic: ipvlan/basic
       ? ??? iotop: sanity
       ? ??? Usex - version 1.9-29
       ? ??? storage: dm/common

    Host 3:

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? xfstests: ext4
       ? xfstests: xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? stress: stress-ng
       ? ? IOMMU boot test
       ? ? IPMI driver test
       ? ? IPMItool loop stress test
       ? ??? power-management: cpupower/sanity test
       ? ? Storage blktests

    Host 4:
       ? Boot test
       ? Storage SAN device stress - mpt3sas driver

    Host 5:

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Networking bridge: sanity
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking sctp-auth: sockopts test
       ??? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ?  Networking TCP: keepalive test
       ?  Networking UDP: socket
       ?  Networking tunnel: geneve basic test
       ?  Networking tunnel: gre basic
       ?  L2TP basic test
       ?  Networking tunnel: vxlan basic
       ?  Networking ipsec: basic netns transport
       ?  Networking ipsec: basic netns tunnel
       ?  audit: audit testsuite test
       ?  httpd: mod_ssl smoke sanity
       ?  tuned: tune-processes-through-perf
       ?  pciutils: sanity smoke test
       ?  ALSA PCM loopback test
       ?  ALSA Control (mixer) Userspace Element test
       ?  storage: SCSI VPD
       ?  trace: ftrace/tracer
       ?  CIFS Connectathon
       ?  POSIX pjd-fstest suites
       ?  jvm test suite
       ?  Memory function: kaslr
       ?  LTP: openposix test suite
       ?  Networking vnic: ipvlan/basic
       ?  iotop: sanity
       ?  Usex - version 1.9-29
       ?  storage: dm/common

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

