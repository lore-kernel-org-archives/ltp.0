From: Rachel Sibley <rasibley@redhat.com>
Date: Wed, 27 Nov 2019 10:06:13 -0500
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E13-cc9917b=2Ecki_=28stable-queue=29?=
In-Reply-To: <cki.B4696121A3.SRVKVUGWT3@redhat.com>
References: <cki.B4696121A3.SRVKVUGWT3@redhat.com>
Message-ID: <546bd6ac-8ab1-9a9b-5856-e6410fb8ee89@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 11/27/19 9:30 AM, CKI Project wrote:
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>         Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
>              Commit: cc9917b40848 - mdio_bus: Fix init if CONFIG_RESET_CONTROLLER=n
> 
> The results of these automated tests are provided below.
> 
>      Overall result: FAILED (see details below)
>               Merge: OK
>             Compile: OK
>               Tests: FAILED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>    https://artifacts.cki-project.org/pipelines/309848
> 
> One or more kernel tests failed:
> 
>      ppc64le:
>       ? LTP

I see a slew of syscalls failures here for LTP:
https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_1_LTP_resultoutputfile.log
https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_1_LTP_syscalls.run.log


>       ? xfstests: xfs

Also generic/212 test failed for xfstests:
https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_2_xfstests__xfs_taskout.log

Running test generic/212
#! /bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (c) 2009 Eric Sandeen.  All Rights Reserved.
#
# FS QA Test No. 212
#
# Run aio-io-setup-with-nonwritable-context-pointer -
# Test what happens when a non-writable context pointer is passed to 
io_setup
#
seq=`basename $0`
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/ppc64le ibm-p9b-03 5.3.13-cc9917b.cki #1 SMP Tue 
Nov 26 18:18:25 UTC 2019
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,rmapbt=1,reflink=1 -i sparse=1 
/dev/sda3
MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda3 
/mnt/xfstests/mnt2

generic/212 0s ... [failed, exit status 135]- output mismatch (see 
/var/lib/xfstests/results//generic/212.out.bad)
     --- tests/generic/212.out	2019-11-26 18:36:35.624357754 -0500
     +++ /var/lib/xfstests/results//generic/212.out.bad	2019-11-26 
18:44:30.926323027 -0500
     @@ -1,2 +1,2 @@
      QA output created by 212
     -aio-io-setup-with-nonwritable-context-pointer: Success!
     +./common/rc: line 1949: 521294 Bus error               (core 
dumped) $AIO_TEST $testtemp 2>&1
     ...
     (Run 'diff -u /var/lib/xfstests/tests/generic/212.out 
/var/lib/xfstests/results//generic/212.out.bad'  to see the entire diff)
Ran: generic/212
Failures: generic/212
Failed 1 of 1 tests

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
> Compile testing
> ---------------
> 
> We compiled the kernel for 3 architectures:
> 
>      aarch64:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      ppc64le:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      x86_64:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
> 
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
> 
>    aarch64:
>      Host 1:
>         ? Boot test
>         ? Podman system integration test (as root)
>         ? Podman system integration test (as user)
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? Memory function: kaslr
>         ? AMTU (Abstract Machine Test Utility)
>         ? LTP: openposix test suite
>         ? Networking bridge: sanity
>         ? Ethernet drivers sanity
>         ? Networking MACsec: sanity
>         ? Networking socket: fuzz
>         ? Networking sctp-auth: sockopts test
>         ? Networking: igmp conformance test
>         ? Networking route: pmtu
>         ? Networking route_func: local
>         ? Networking route_func: forward
>         ? Networking TCP: keepalive test
>         ? Networking UDP: socket
>         ? Networking tunnel: geneve basic test
>         ? Networking tunnel: gre basic
>         ? L2TP basic test
>         ? Networking tunnel: vxlan basic
>         ? Networking ipsec: basic netns transport
>         ? Networking ipsec: basic netns tunnel
>         ? audit: audit testsuite test
>         ? httpd: mod_ssl smoke sanity
>         ? tuned: tune-processes-through-perf
>         ? ALSA PCM loopback test
>         ? ALSA Control (mixer) Userspace Element test
>         ? storage: SCSI VPD
>         ? trace: ftrace/tracer
>         ? ? CIFS Connectathon
>         ? ? POSIX pjd-fstest suites
>         ? ? jvm test suite
>         ? ? Networking vnic: ipvlan/basic
>         ? ? iotop: sanity
>         ? ? Usex - version 1.9-29
>         ? ? storage: dm/common
> 
>      Host 2:
>         ? Boot test
>         ? xfstests: ext4
>         ? xfstests: xfs
>         ? lvm thinp sanity
>         ? storage: software RAID testing
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>    ppc64le:
>      Host 1:
>         ? Boot test
>         ? Podman system integration test (as root)
>         ? Podman system integration test (as user)
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? Memory function: kaslr
>         ? AMTU (Abstract Machine Test Utility)
>         ? LTP: openposix test suite
>         ? Networking bridge: sanity
>         ? Ethernet drivers sanity
>         ? Networking MACsec: sanity
>         ? Networking socket: fuzz
>         ? Networking sctp-auth: sockopts test
>         ? Networking route: pmtu
>         ? Networking route_func: local
>         ? Networking route_func: forward
>         ? Networking TCP: keepalive test
>         ? Networking UDP: socket
>         ? Networking tunnel: geneve basic test
>         ? Networking tunnel: gre basic
>         ? L2TP basic test
>         ? Networking tunnel: vxlan basic
>         ? Networking ipsec: basic netns tunnel
>         ? audit: audit testsuite test
>         ? httpd: mod_ssl smoke sanity
>         ? tuned: tune-processes-through-perf
>         ? ALSA PCM loopback test
>         ? ALSA Control (mixer) Userspace Element test
>         ? trace: ftrace/tracer
>         ? ? CIFS Connectathon
>         ? ? POSIX pjd-fstest suites
>         ? ? jvm test suite
>         ? ? Networking vnic: ipvlan/basic
>         ? ? iotop: sanity
>         ? ? Usex - version 1.9-29
>         ? ? storage: dm/common
> 
>      Host 2:
>         ? Boot test
>         ? xfstests: ext4
>         ? xfstests: xfs
>         ? lvm thinp sanity
>         ? storage: software RAID testing
>         ? ? IPMI driver test
>         ? ? IPMItool loop stress test
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>    x86_64:
>      Host 1:
>         ? Boot test
>         ? xfstests: ext4
>         ? xfstests: xfs
>         ? lvm thinp sanity
>         ? storage: software RAID testing
>         ? ? IOMMU boot test
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>      Host 2:
>         ?  Boot test
>         ?  Storage SAN device stress - mpt3sas driver
> 
>      Host 3:
>         ?  Boot test
>         ?  Storage SAN device stress - megaraid_sas
> 
>      Host 4:
> 
>         ? Internal infrastructure issues prevented one or more tests (marked
>         with ???) from running on this architecture.
>         This is not the fault of the kernel that was tested.
> 
>         ??? Boot test
>         ??? Podman system integration test (as root)
>         ??? Podman system integration test (as user)
>         ??? LTP
>         ??? Loopdev Sanity
>         ??? Memory function: memfd_create
>         ??? Memory function: kaslr
>         ??? AMTU (Abstract Machine Test Utility)
>         ??? LTP: openposix test suite
>         ??? Networking bridge: sanity
>         ??? Ethernet drivers sanity
>         ??? Networking MACsec: sanity
>         ??? Networking socket: fuzz
>         ??? Networking sctp-auth: sockopts test
>         ??? Networking: igmp conformance test
>         ??? Networking route: pmtu
>         ??? Networking route_func: local
>         ??? Networking route_func: forward
>         ??? Networking TCP: keepalive test
>         ??? Networking UDP: socket
>         ??? Networking tunnel: geneve basic test
>         ??? Networking tunnel: gre basic
>         ??? L2TP basic test
>         ??? Networking tunnel: vxlan basic
>         ??? Networking ipsec: basic netns transport
>         ??? Networking ipsec: basic netns tunnel
>         ??? audit: audit testsuite test
>         ??? httpd: mod_ssl smoke sanity
>         ??? tuned: tune-processes-through-perf
>         ??? pciutils: sanity smoke test
>         ??? ALSA PCM loopback test
>         ??? ALSA Control (mixer) Userspace Element test
>         ??? storage: SCSI VPD
>         ??? stress: stress-ng
>         ??? trace: ftrace/tracer
>         ? ??? CIFS Connectathon
>         ? ??? POSIX pjd-fstest suites
>         ? ??? jvm test suite
>         ? ??? Networking vnic: ipvlan/basic
>         ? ??? iotop: sanity
>         ? ??? Usex - version 1.9-29
>         ? ??? storage: dm/common
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

