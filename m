From: CKI Project <cki-project@redhat.com>
Date: Sat, 07 Mar 2020 00:02:38 -0000
Subject: [LTP] =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E6?=
 =?utf-8?b?LjAtMC5yYzQuMi5lbHJkeS5ja2kgKGFyayk=?=
Message-ID: <cki.2EFDE2FCE3.JLIPSG6DVZ@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: https://gitlab.com/cki-project/kernel-ark.git
            Commit: 76ff5208ed98 - [redhat] kernel-5.6.0-0.rc4.2.elrdy

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

    Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/pipelines/475149

One or more kernel tests failed:
  To view existing or log new failures in CKI:
    http://internal-documentation-ark.cloud.paas.psi.redhat.com/datawarehouse/failure_analysis/#view-known-failures
  To view testing trends per kernel, e.g. determine if a test failed on previous kernels:
    http://internal-documentation-ark.cloud.paas.psi.redhat.com/datawarehouse/failure_analysis/#test-results

    x86_64:
     ? LTP
     ? Libhugetlbfs - version 2.2.1
     ? Tracepoints: operational test
     ? selinux-policy: serge-testsuite

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

We compiled the kernel for 4 architectures:

    aarch64:
      rpmbuild arguments: rpmbuild --target aarch64  --with=cross --with=kabidw_base  --without=bpftool --without=debug --without=doc --without=ipaclones --without=perf --without=selftests --without=tools
      kernel repo: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/-/jobs/686964/artifacts/raw/repo/5.6.0-0.rc4.2.elrdy.cki.aarch64/

    ppc64le:
      rpmbuild arguments: rpmbuild --target ppc64le  --with=cross --with=kabidw_base  --without=bpftool --without=debug --without=doc --without=ipaclones --without=perf --without=selftests --without=tools
      kernel repo: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/-/jobs/686965/artifacts/raw/repo/5.6.0-0.rc4.2.elrdy.cki.ppc64le/

    s390x:
      rpmbuild arguments: rpmbuild --target s390x  --with=cross --with=kabidw_base  --without=bpftool --without=debug --without=doc --without=ipaclones --without=perf --without=selftests --without=tools
      kernel repo: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/-/jobs/686966/artifacts/raw/repo/5.6.0-0.rc4.2.elrdy.cki.s390x/

    x86_64:
      rpmbuild arguments: rpmbuild --target x86_64  --with=bpftool --with=kabidw_base --with=selftests  --without=debug --without=ipaclones --without=perf --without=tools
      kernel repo: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/-/jobs/686963/artifacts/raw/repo/5.6.0-0.rc4.2.elrdy.cki.x86_64/


Hardware testing
----------------
All the testing jobs are listed here:

  https://beaker.engineering.redhat.com/jobs/?jobsearch-0.table=Whiteboard&jobsearch-0.operation=contains&jobsearch-0.value=cki%40gitlab%3A475149

We booted each kernel and ran the following tests:

  aarch64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7988076

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? xfstests - ext4
       ??? xfstests - xfs
       ??? selinux-policy: serge-testsuite
       ??? lvm thinp sanity
       ??? storage: software RAID testing
       ??? stress: stress-ng
       ? ??? IPMI driver test
       ? ??? IPMItool loop stress test
       ? ??? Storage blktests
       ? ??? storage: iSCSI parameters

    Host 2: https://beaker.engineering.redhat.com/recipes/7989290

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ??? xfstests - ext4
       ??? xfstests - xfs
       ??? selinux-policy: serge-testsuite
       ??? lvm thinp sanity
       ??? storage: software RAID testing
       ??? stress: stress-ng
       ? ??? IPMI driver test
       ? ??? IPMItool loop stress test
       ? ??? Storage blktests
       ? ??? storage: iSCSI parameters

  ppc64le:
    Host 1: https://beaker.engineering.redhat.com/recipes/7989660

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? LTP
       ??? Loopdev Sanity
       ??? Memory function: memfd_create
       ??? AMTU (Abstract Machine Test Utility)
       ??? Networking bridge: sanity
       ??? Ethernet drivers sanity
       ??? Networking MACsec: sanity
       ??? Networking socket: fuzz
       ??? Networking: ipv6/Fujitsu-socketapi-test
       ??? Networking sctp-auth: sockopts test
       ??? Networking route: pmtu
       ??? Networking route_func - local
       ??? Networking route_func - forward
       ??? Networking TCP: keepalive test
       ??? Networking UDP: socket
       ??? Networking tunnel: geneve basic test
       ??? Networking tunnel: gre basic
       ??? L2TP basic test
       ??? Networking tunnel: vxlan basic
       ??? Networking ipsec: basic netns - tunnel
       ??? audit: audit testsuite test
       ??? httpd: mod_ssl smoke sanity
       ??? net-snmp: tcp-transport test
       ??? tuned: tune-processes-through-perf
       ??? pciutils: update pci ids test
       ??? ALSA PCM loopback test
       ??? ALSA Control (mixer) Userspace Element test
       ??? trace: ftrace/tracer
       ??? Libhugetlbfs - version 2.2.1
       ? ??? CIFS Connectathon
       ? ??? POSIX pjd-fstest suites
       ? ??? Memory function: kaslr
       ? ??? LTP: openposix test suite
       ? ??? Networking firewall: basic netfilter test
       ? ??? Networking vnic: ipvlan/basic
       ? ??? iotop: sanity
       ? ??? Usex - version 1.9-29
       ? ??? storage: dm/common

  s390x:
    Host 1: https://beaker.engineering.redhat.com/recipes/7988078
       ? Boot test
       ? ? kdump - sysrq-c

    Host 2: https://beaker.engineering.redhat.com/recipes/7988161

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? selinux-policy: serge-testsuite
       ??? stress: stress-ng
       ? ??? Storage blktests

    Host 3: https://beaker.engineering.redhat.com/recipes/7988166

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? LTP
       ??? Loopdev Sanity
       ??? Memory function: memfd_create
       ??? Networking bridge: sanity
       ??? Ethernet drivers sanity
       ??? Networking MACsec: sanity
       ??? Networking: ipv6/Fujitsu-socketapi-test
       ??? Networking sctp-auth: sockopts test
       ??? Networking route: pmtu
       ??? Networking route_func - local
       ??? Networking route_func - forward
       ??? Networking TCP: keepalive test
       ??? Networking UDP: socket
       ??? Networking tunnel: geneve basic test
       ??? Networking tunnel: gre basic
       ??? L2TP basic test
       ??? Networking tunnel: vxlan basic
       ??? Networking ipsec: basic netns - transport
       ??? Networking ipsec: basic netns - tunnel
       ??? audit: audit testsuite test
       ??? httpd: mod_ssl smoke sanity
       ??? net-snmp: tcp-transport test
       ??? tuned: tune-processes-through-perf
       ??? trace: ftrace/tracer
       ? ??? CIFS Connectathon
       ? ??? POSIX pjd-fstest suites
       ? ??? Memory function: kaslr
       ? ??? LTP: openposix test suite
       ? ??? Networking firewall: basic netfilter test
       ? ??? Networking vnic: ipvlan/basic
       ? ??? iotop: sanity
       ? ??? Usex - version 1.9-29
       ? ??? storage: dm/common

  x86_64:
    Host 1: https://beaker.engineering.redhat.com/recipes/7988072

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? Storage SAN device stress - mpt3sas driver

    Host 2: https://beaker.engineering.redhat.com/recipes/7988069

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? ACPI table test
       ? LTP
       ? Loopdev Sanity
       ? Memory function: memfd_create
       ? AMTU (Abstract Machine Test Utility)
       ? Networking bridge: sanity
       ? Ethernet drivers sanity
       ? Networking MACsec: sanity
       ? Networking socket: fuzz
       ? Networking: ipv6/Fujitsu-socketapi-test
       ? Networking sctp-auth: sockopts test
       ? Networking: igmp conformance test
       ? Networking route: pmtu
       ? Networking route_func - local
       ? Networking route_func - forward
       ? Networking TCP: keepalive test
       ? Networking UDP: socket
       ? Networking tunnel: geneve basic test
       ? Networking tunnel: gre basic
       ? L2TP basic test
       ? Networking tunnel: vxlan basic
       ? Networking ipsec: basic netns - transport
       ? Networking ipsec: basic netns - tunnel
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? net-snmp: tcp-transport test
       ? tuned: tune-processes-through-perf
       ? pciutils: sanity smoke test
       ? pciutils: update pci ids test
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? storage: SCSI VPD
       ? trace: ftrace/tracer
       ? Libhugetlbfs - version 2.2.1
       ? Tracepoints: operational test
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites
       ? ? Memory function: kaslr
       ? ? LTP: openposix test suite
       ? ? Networking firewall: basic netfilter test
       ? ? Networking vnic: ipvlan/basic
       ? ? iotop: sanity
       ? ? Usex - version 1.9-29
       ? ??? storage: dm/common

    Host 3: https://beaker.engineering.redhat.com/recipes/7988253

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ??? Boot test
       ??? xfstests - ext4
       ??? xfstests - xfs
       ??? selinux-policy: serge-testsuite
       ??? lvm thinp sanity
       ??? storage: software RAID testing
       ??? stress: stress-ng
       ? ??? CPU: Frequency Driver Test
       ? ??? CPU: Idle Test
       ? ??? IOMMU boot test
       ? ??? IPMI driver test
       ? ??? IPMItool loop stress test
       ? ??? power-management: cpupower/sanity test
       ? ??? Storage blktests
       ? ??? storage: iSCSI parameters

    Host 4: https://beaker.engineering.redhat.com/recipes/7988579

       ? Internal infrastructure issues prevented one or more tests (marked
       with ???) from running on this architecture.
       This is not the fault of the kernel that was tested.

       ? Boot test
       ? xfstests - ext4
       ? xfstests - xfs
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? stress: stress-ng
       ? ? CPU: Frequency Driver Test
       ? ??? IOMMU boot test
       ? ??? IPMI driver test
       ? ??? IPMItool loop stress test
       ? ??? power-management: cpupower/sanity test
       ? ??? Storage blktests
       ? ??? storage: iSCSI parameters

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

  http://respin-service-ark.cloud.paas.psi.redhat.com/respin.html?whiteboard=respin_job_4115796&recipe_id=7988069&job_id=4115796
  http://respin-service-ark.cloud.paas.psi.redhat.com/respin.html?whiteboard=respin_job_4116064&recipe_id=7988579&job_id=4116064

