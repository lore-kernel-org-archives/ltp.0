From: Rachel Sibley <rasibley@redhat.com>
Date: Mon, 18 Nov 2019 19:07:29 -0500
Subject: [LTP] =?utf-8?b?4p2MIEZBSUw6IFN0YWJsZSBxdWV1ZTogcXVldWUtNS4z?=
In-Reply-To: <cki.042792963E.5VOWULC1Q9@redhat.com>
References: <cki.042792963E.5VOWULC1Q9@redhat.com>
Message-ID: <8e0fa6de-b6b1-23ac-9e77-d425c8d1ba22@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 11/18/19 10:00 AM, CKI Project wrote:
> Hello,
>
> We ran automated tests on a patchset that was proposed for merging into this
> kernel tree. The patches were applied to:
>
>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>              Commit: 116a395b7061 - Linux 5.3.11
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
>    https://artifacts.cki-project.org/pipelines/293063
>
> One or more kernel tests failed:
>
>      aarch64:
>       ? LTP lite

I see a panic when installing the LTP dependencies

[  690.625060] Call trace:
[  690.627495]  bfq_find_set_group+0x8c/0xf0
[  690.631491]  bfq_bic_update_cgroup+0xbc/0x218
[  690.635834]  bfq_init_rq+0xac/0x808
[  690.639309]  bfq_insert_request.isra.0+0xe0/0x200
[  690.643999]  bfq_insert_requests+0x68/0x88
[  690.648085]  blk_mq_sched_insert_requests+0x84/0x140
[  690.653036]  blk_mq_flush_plug_list+0x170/0x2b0
[  690.657555]  blk_flush_plug_list+0xec/0x100
[  690.661725]  blk_mq_make_request+0x200/0x5e8
[  690.665982]  generic_make_request+0x94/0x270
[  690.670239]  submit_bio+0x34/0x168
[  690.673712]  xfs_submit_ioend.isra.0+0x9c/0x180 [xfs]
[  690.678798]  xfs_do_writepage+0x234/0x458 [xfs]
[  690.683318]  write_cache_pages+0x1a4/0x3f8
[  690.687442]  xfs_vm_writepages+0x84/0xb8 [xfs]
[  690.691874]  do_writepages+0x3c/0xe0
[  690.695438]  __writeback_single_inode+0x48/0x440
[  690.700042]  writeback_sb_inodes+0x1ec/0x4b0
[  690.704298]  __writeback_inodes_wb+0x50/0xe8
[  690.708555]  wb_writeback+0x264/0x388
[  690.712204]  wb_do_writeback+0x300/0x358
[  690.716113]  wb_workfn+0x80/0x1e0
[  690.719418]  process_one_work+0x1bc/0x3e8
[  690.723414]  worker_thread+0x54/0x440
[  690.727064]  kthread+0x104/0x130
[  690.730281]  ret_from_fork+0x10/0x18
[  690.733847] Code: eb00007f 54000220 b4000040 f8568022 (f9401c42)
[  690.739928] ---[ end trace d3fd392f569e86d3 ]---

https://artifacts.cki-project.org/pipelines/293063/logs/aarch64_host_2_console.log

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
> Merge testing
> -------------
>
> We cloned this repository and checked out the following commit:
>
>    Repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>    Commit: 116a395b7061 - Linux 5.3.11
>
>
> We grabbed the c4a7b00e0626 commit of the stable queue repository.
>
> We then merged the patchset with `git am`:
>
>    scsi-core-handle-drivers-which-set-sg_tablesize-to-zero.patch
>    ax88172a-fix-information-leak-on-short-answers.patch
>    devlink-disallow-reload-operation-during-device-cleanup.patch
>    ipmr-fix-skb-headroom-in-ipmr_get_route.patch
>    mlxsw-core-enable-devlink-reload-only-on-probe.patch
>    net-gemini-add-missed-free_netdev.patch
>    net-smc-fix-fastopen-for-non-blocking-connect.patch
>    net-usb-qmi_wwan-add-support-for-foxconn-t77w968-lte-modules.patch
>    slip-fix-memory-leak-in-slip_open-error-path.patch
>    tcp-remove-redundant-new-line-from-tcp_event_sk_skb.patch
>    dpaa2-eth-free-already-allocated-channels-on-probe-defer.patch
>    devlink-add-method-for-time-stamp-on-reporter-s-dump.patch
>    net-smc-fix-refcount-non-blocking-connect-part-2.patch
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
>         ? ? selinux-policy: serge-testsuite
>
>      Host 2:
>         ? Boot test
>         ? Podman system integration test (as root)
>         ? Podman system integration test (as user)
>         ? LTP lite
>         ??? jvm test suite
>         ??? AMTU (Abstract Machine Test Utility)
>         ??? LTP: openposix test suite
>         ??? Ethernet drivers sanity
>         ??? Networking socket: fuzz
>         ??? audit: audit testsuite test
>         ??? httpd: mod_ssl smoke sanity
>         ??? iotop: sanity
>         ??? tuned: tune-processes-through-perf
>         ??? storage: SCSI VPD
>         ??? stress: stress-ng
>
>    ppc64le:
>
>      ? Internal infrastructure issues prevented one or more tests (marked
>      with ???) from running on this architecture.
>      This is not the fault of the kernel that was tested.
>
>    x86_64:
>      Host 1:
>         ? Boot test
>         ? ? selinux-policy: serge-testsuite
>
>      Host 2:
>         ? Boot test
>         ? Podman system integration test (as root)
>         ? Podman system integration test (as user)
>         ? LTP lite
>         ? jvm test suite
>         ? AMTU (Abstract Machine Test Utility)
>         ? LTP: openposix test suite
>         ? Ethernet drivers sanity
>         ? Networking socket: fuzz
>         ? audit: audit testsuite test
>         ? httpd: mod_ssl smoke sanity
>         ? iotop: sanity
>         ? tuned: tune-processes-through-perf
>         ? pciutils: sanity smoke test
>         ? storage: SCSI VPD
>         ? stress: stress-ng
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
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191118/0d06f103/attachment-0001.htm>
