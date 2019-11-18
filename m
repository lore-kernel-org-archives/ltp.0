From: CKI Project <cki-project@redhat.com>
Date: Mon, 18 Nov 2019 15:00:41 -0000
Subject: [LTP] =?utf-8?b?4p2MIEZBSUw6IFN0YWJsZSBxdWV1ZTogcXVldWUtNS4z?=
Message-ID: <cki.042792963E.5VOWULC1Q9@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a patchset that was proposed for merging into this
kernel tree. The patches were applied to:

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
            Commit: 116a395b7061 - Linux 5.3.11

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://artifacts.cki-project.org/pipelines/293063

One or more kernel tests failed:

    aarch64:
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

Merge testing
-------------

We cloned this repository and checked out the following commit:

  Repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  Commit: 116a395b7061 - Linux 5.3.11


We grabbed the c4a7b00e0626 commit of the stable queue repository.

We then merged the patchset with `git am`:

  scsi-core-handle-drivers-which-set-sg_tablesize-to-zero.patch
  ax88172a-fix-information-leak-on-short-answers.patch
  devlink-disallow-reload-operation-during-device-cleanup.patch
  ipmr-fix-skb-headroom-in-ipmr_get_route.patch
  mlxsw-core-enable-devlink-reload-only-on-probe.patch
  net-gemini-add-missed-free_netdev.patch
  net-smc-fix-fastopen-for-non-blocking-connect.patch
  net-usb-qmi_wwan-add-support-for-foxconn-t77w968-lte-modules.patch
  slip-fix-memory-leak-in-slip_open-error-path.patch
  tcp-remove-redundant-new-line-from-tcp_event_sk_skb.patch
  dpaa2-eth-free-already-allocated-channels-on-probe-defer.patch
  devlink-add-method-for-time-stamp-on-reporter-s-dump.patch
  net-smc-fix-refcount-non-blocking-connect-part-2.patch

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
       ? ? selinux-policy: serge-testsuite

    Host 2:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP lite
       ??? jvm test suite
       ??? AMTU (Abstract Machine Test Utility)
       ??? LTP: openposix test suite
       ??? Ethernet drivers sanity
       ??? Networking socket: fuzz
       ??? audit: audit testsuite test
       ??? httpd: mod_ssl smoke sanity
       ??? iotop: sanity
       ??? tuned: tune-processes-through-perf
       ??? storage: SCSI VPD
       ??? stress: stress-ng

  ppc64le:

    ? Internal infrastructure issues prevented one or more tests (marked
    with ???) from running on this architecture.
    This is not the fault of the kernel that was tested.

  x86_64:
    Host 1:
       ? Boot test
       ? ? selinux-policy: serge-testsuite

    Host 2:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP lite
       ? jvm test suite
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Ethernet drivers sanity
       ? Networking socket: fuzz
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
       ? pciutils: sanity smoke test
       ? storage: SCSI VPD
       ? stress: stress-ng

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

