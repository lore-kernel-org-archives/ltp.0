From: Rachel Sibley <rasibley@redhat.com>
Date: Tue, 17 Mar 2020 13:10:27 -0400
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E10-rc1-97969bd=2Ecki_=28stable=29?=
In-Reply-To: <cki.45BE8D2AEE.EDVG8CXFLJ@redhat.com>
References: <cki.45BE8D2AEE.EDVG8CXFLJ@redhat.com>
Message-ID: <4f7fbcf7-6168-8b07-9f2f-e1a17a502000@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 3/17/20 12:38 PM, CKI Project wrote:
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>              Commit: 97969bd17009 - Linux 5.5.10-rc1
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
>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/17/492657
> 
> One or more kernel tests failed:
> 
>      ppc64le:
>       ? LTP
> 

The dmesg check failed during LTP, most likely due to running on a slow kvm guest:

[ 7006.259467] watchdog: BUG: soft lockup - CPU#2 stuck for 21s! [diotest6:818841]
[ 7138.007023] watchdog: BUG: soft lockup - CPU#8 stuck for 38s! [systemd-journal:561]


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
> We compiled the kernel for 4 architectures:
> 
>      aarch64:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      ppc64le:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      s390x:
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
>         ? xfstests - ext4
>         ? xfstests - xfs
>         ? lvm thinp sanity
>         ? storage: software RAID testing
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>      Host 2:
>         ? Boot test
>         ? Podman system integration test - as root
>         ? Podman system integration test - as user
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? AMTU (Abstract Machine Test Utility)
>         ? Networking bridge: sanity
>         ? Ethernet drivers sanity
>         ? Networking MACsec: sanity
>         ? Networking socket: fuzz
>         ? Networking sctp-auth: sockopts test
>         ? Networking: igmp conformance test
>         ? Networking route: pmtu
>         ? Networking route_func - local
>         ? Networking route_func - forward
>         ? Networking TCP: keepalive test
>         ? Networking UDP: socket
>         ? Networking tunnel: geneve basic test
>         ? Networking tunnel: gre basic
>         ? L2TP basic test
>         ? Networking tunnel: vxlan basic
>         ? Networking ipsec: basic netns - transport
>         ? Networking ipsec: basic netns - tunnel
>         ? httpd: mod_ssl smoke sanity
>         ? tuned: tune-processes-through-perf
>         ? ALSA PCM loopback test
>         ? ALSA Control (mixer) Userspace Element test
>         ? storage: SCSI VPD
>         ? trace: ftrace/tracer
>         ? ? CIFS Connectathon
>         ? ? POSIX pjd-fstest suites
>         ? ? jvm - DaCapo Benchmark Suite
>         ? ? jvm - jcstress tests
>         ? ? Memory function: kaslr
>         ? ? LTP: openposix test suite
>         ? ? Networking vnic: ipvlan/basic
>         ? ? audit: audit testsuite test
>         ? ? iotop: sanity
>         ? ? Usex - version 1.9-29
>         ? ? storage: dm/common
> 
>    ppc64le:
>      Host 1:
>         ? Boot test
>         ? Podman system integration test - as root
>         ? Podman system integration test - as user
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? AMTU (Abstract Machine Test Utility)
>         ? Networking bridge: sanity
>         ? Ethernet drivers sanity
>         ? Networking MACsec: sanity
>         ? Networking socket: fuzz
>         ? Networking sctp-auth: sockopts test
>         ? Networking route: pmtu
>         ? Networking route_func - local
>         ? Networking route_func - forward
>         ? Networking TCP: keepalive test
>         ? Networking UDP: socket
>         ? Networking tunnel: geneve basic test
>         ? Networking tunnel: gre basic
>         ? L2TP basic test
>         ? Networking tunnel: vxlan basic
>         ? Networking ipsec: basic netns - tunnel
>         ? httpd: mod_ssl smoke sanity
>         ? tuned: tune-processes-through-perf
>         ? ALSA PCM loopback test
>         ? ALSA Control (mixer) Userspace Element test
>         ? trace: ftrace/tracer
>         ? ? CIFS Connectathon
>         ? ? POSIX pjd-fstest suites
>         ? ? jvm - DaCapo Benchmark Suite
>         ? ? jvm - jcstress tests
>         ? ? Memory function: kaslr
>         ? ? LTP: openposix test suite
>         ? ? Networking vnic: ipvlan/basic
>         ? ? audit: audit testsuite test
>         ? ? iotop: sanity
>         ? ? Usex - version 1.9-29
>         ? ? storage: dm/common
> 
>      Host 2:
>         ? Boot test
>         ? xfstests - ext4
>         ? xfstests - xfs
>         ? lvm thinp sanity
>         ? storage: software RAID testing
>         ? ? IPMI driver test
>         ? ? IPMItool loop stress test
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>    s390x:
>      Host 1:
>         ? Boot test
>         ? Podman system integration test - as root
>         ? Podman system integration test - as user
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? Networking bridge: sanity
>         ? Ethernet drivers sanity
>         ? Networking MACsec: sanity
>         ? Networking sctp-auth: sockopts test
>         ? Networking route: pmtu
>         ? Networking route_func - local
>         ? Networking route_func - forward
>         ? Networking TCP: keepalive test
>         ? Networking UDP: socket
>         ? Networking tunnel: geneve basic test
>         ? Networking tunnel: gre basic
>         ? L2TP basic test
>         ? Networking tunnel: vxlan basic
>         ? Networking ipsec: basic netns - transport
>         ? Networking ipsec: basic netns - tunnel
>         ? httpd: mod_ssl smoke sanity
>         ? tuned: tune-processes-through-perf
>         ? trace: ftrace/tracer
>         ? ? CIFS Connectathon
>         ? ? POSIX pjd-fstest suites
>         ? ? jvm - DaCapo Benchmark Suite
>         ? ? jvm - jcstress tests
>         ? ? Memory function: kaslr
>         ? ? LTP: openposix test suite
>         ? ? Networking vnic: ipvlan/basic
>         ? ? audit: audit testsuite test
>         ? ? iotop: sanity
>         ? ? storage: dm/common
> 
>      Host 2:
>         ? Boot test
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>    x86_64:
>      Host 1:
>         ? Boot test
>         ? Storage SAN device stress - mpt3sas driver
> 
>      Host 2:
>         ? Boot test
>         ? xfstests - ext4
>         ? xfstests - xfs
>         ? lvm thinp sanity
>         ? storage: software RAID testing
>         ? stress: stress-ng
>         ? ? IOMMU boot test
>         ? ? IPMI driver test
>         ? ? IPMItool loop stress test
>         ? ? selinux-policy: serge-testsuite
>         ? ? Storage blktests
> 
>      Host 3:
>         ? Boot test
>         ? Storage SAN device stress - megaraid_sas
> 
>      Host 4:
>         ? Boot test
>         ? Podman system integration test - as root
>         ? Podman system integration test - as user
>         ? LTP
>         ? Loopdev Sanity
>         ? Memory function: memfd_create
>         ? AMTU (Abstract Machine Test Utility)
>         ? Networking bridge: sanity
>         ? Ethernet drivers sanity
>         ? Networking MACsec: sanity
>         ? Networking socket: fuzz
>         ? Networking sctp-auth: sockopts test
>         ? Networking: igmp conformance test
>         ? Networking route: pmtu
>         ? Networking route_func - local
>         ? Networking route_func - forward
>         ? Networking TCP: keepalive test
>         ? Networking UDP: socket
>         ? Networking tunnel: geneve basic test
>         ? Networking tunnel: gre basic
>         ? L2TP basic test
>         ? Networking tunnel: vxlan basic
>         ? Networking ipsec: basic netns - transport
>         ? Networking ipsec: basic netns - tunnel
>         ? httpd: mod_ssl smoke sanity
>         ? tuned: tune-processes-through-perf
>         ? pciutils: sanity smoke test
>         ? ALSA PCM loopback test
>         ? ALSA Control (mixer) Userspace Element test
>         ? storage: SCSI VPD
>         ? trace: ftrace/tracer
>         ? ? CIFS Connectathon
>         ? ? POSIX pjd-fstest suites
>         ? ? jvm - DaCapo Benchmark Suite
>         ? ? jvm - jcstress tests
>         ? ? Memory function: kaslr
>         ? ? LTP: openposix test suite
>         ? ? Networking vnic: ipvlan/basic
>         ? ? audit: audit testsuite test
>         ? ? iotop: sanity
>         ? ? Usex - version 1.9-29
>         ? ? storage: dm/common
> 
>    Test sources: https://github.com/CKI-project/tests-beaker
>      ? Pull requests are welcome for new tests or improvements to existing tests!
> 
> Aborted tests
> -------------
> Tests that didn't complete running successfully are marked with ???.
> If this was caused by an infrastructure issue, we try to mark that
> explicitly in the report.
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
> finished running yet are marked with ?.
> 
> 

