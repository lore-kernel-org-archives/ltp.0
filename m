From: Murphy Zhou <xzhou@redhat.com>
Date: Mon, 9 Mar 2020 10:16:24 +0800
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E6?=
 =?utf-8?q?=2E0-rc4-61a0925=2Ecki_=28mainline=2Ekernel=2Eorg=29?=
In-Reply-To: <6faee713-d1de-c53b-282b-285f96338ecc@redhat.com>
References: <cki.FEFA879F6B.TFTZ93YIF0@redhat.com>
 <6faee713-d1de-c53b-282b-285f96338ecc@redhat.com>
Message-ID: <20200309021624.2gbra2eqnira5hlg@xzhoux.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Mar 08, 2020 at 10:30:51AM -0400, Rachel Sibley wrote:
> 
> 
> On 3/7/20 9:59 PM, CKI Project wrote:
> > 
> > Hello,
> > 
> > We ran automated tests on a recent commit from this kernel tree:
> > 
> >         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >              Commit: 61a09258f2e5 - Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> > 
> > The results of these automated tests are provided below.
> > 
> >      Overall result: FAILED (see details below)
> >               Merge: OK
> >             Compile: OK
> >               Tests: FAILED
> > 
> > All kernel binaries, config files, and logs are available for download here:
> > 
> >    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/08/477469
> > 
> > One or more kernel tests failed:
> > 
> >      x86_64:
> >       ? LTP
> >       ? xfstests - ext4
> 
> Looks like both tests triggered a panic early on for x86_64:

Looks like something with the scheduler.

> 
> [-- MARK -- Sun Mar  8 02:45:00 2020]
> [  576.251618] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  576.286126] #PF: supervisor write access in kernel mode
> [  576.311678] #PF: error_code(0x0002) - not-present page
> [  576.336963] PGD 0 P4D 0
> [  576.349291] Oops: 0002 [#1] SMP PTI
> [  576.366342] CPU: 6 PID: 302 Comm: kworker/6:1 Tainted: G          I       5.6.0-rc4-61a0925.cki #1
> [  576.410311] Hardware name: HP ProLiant ML350p Gen8, BIOS P72 07/01/2015
> [  576.442876] Workqueue: cgroup_destroy css_killed_work_fn
> [  576.468867] RIP: 0010:bfq_bfqq_move+0x21/0x160
> [  576.490681] Code: c0 c3 0f 1f 80 00 00 00 00 66 66 66 66 90 41 55 41 54
> 49 89 fc 55 48 89 f5 53 48 89 d3 48 39 b7 a0 00 00 00 0f 84 22 01 00 00 <83>
> 45 00 01 48 89 ef e8 b3 87 ff ff 85 c0 0f 85 d7 00 00 00 80 bd
> [  576.585594] RSP: 0018:ffff9c9146a6bdb0 EFLAGS: 00010086
> [  576.612076] RAX: 0000000000000000 RBX: ffff8b1474989800 RCX: 0000000000000000
> [  576.648068] RDX: ffff8b1474989800 RSI: 0000000000000000 RDI: ffff8b1475b6b800
> [  576.683265] RBP: 0000000000000000 R08: 000000003b9aca00 R09: ffff8b144e4f0710
> [  576.716866] R10: 0000000000000000 R11: ffff8b144021f100 R12: ffff8b1475b6b800
> [  576.750425] R13: ffff8b14755119b0 R14: ffff8b1475b6bbf0 R15: ffff8b1475511898
> [  576.783896] FS:  0000000000000000(0000) GS:ffff8b1477780000(0000) knlGS:0000000000000000
> [  576.821888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  576.848850] CR2: 0000000000000000 CR3: 000000026c60a003 CR4: 00000000000606e0
> [  576.882351] Call Trace:
> [  576.893842]  bfq_pd_offline+0x87/0xf0
> [  576.911015]  blkg_destroy+0x52/0xf0
> [  576.927372]  blkcg_destroy_blkgs+0x4f/0xa0
> [  576.946588]  css_killed_work_fn+0x4d/0xd0
> [  576.965370]  process_one_work+0x1b5/0x360
> [  576.984201]  worker_thread+0x50/0x3c0
> [  577.001345]  kthread+0xf9/0x130
> [  577.015992]  ? process_one_work+0x360/0x360
> [  577.035726]  ? kthread_park+0x90/0x90
> [  577.052963]  ret_from_fork+0x35/0x40
> [  577.069688] Modules linked in: intel_rapl_msr intel_rapl_common iTCO_wdt
> iTCO_vendor_support sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp
> rfkill kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel intel_cstate ipmi_ssif intel_uncore intel_rapl_perf
> pcspkr joydev lpc_ich hpilo tg3 ipmi_si hpwdt ipmi_devintf sunrpc
> ipmi_msghandler ioatdma acpi_power_meter dca ip_tables xfs libcrc32c mgag200
> drm_kms_helper cec drm_vram_helper drm_ttm_helper ttm drm ata_generic
> i2c_algo_bit crc32c_intel serio_raw pata_acpi hpsa scsi_transport_sas
> [  577.306863] CR2: 0000000000000000
> [  577.322350] ---[ end trace 5ab01cf29ea1e2c7 ]---
> [  577.344864] RIP: 0010:bfq_bfqq_move+0x21/0x160
> 
> 
> > 
> > We hope that these logs can help you find the problem quickly. For the full
> > detail on our testing procedures, please scroll to the bottom of this message.
> > 
> > Please reply to this email if you have any questions about the tests that we
> > ran or if you have any suggestions on how to make future tests more effective.
> > 
> >          ,-.   ,-.
> >         ( C ) ( K )  Continuous
> >          `-',-.`-'   Kernel
> >            ( I )     Integration
> >             `-'
> > ______________________________________________________________________________
> > 
> > Compile testing
> > ---------------
> > 
> > We compiled the kernel for 1 architecture:
> > 
> >      x86_64:
> >        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > 
> > 
> > Hardware testing
> > ----------------
> > We booted each kernel and ran the following tests:
> > 
> >    x86_64:
> >      Host 1:
> >         ? Boot test
> >         ? Podman system integration test - as root
> >         ? Podman system integration test - as user
> >         ? LTP
> >         ??? Loopdev Sanity
> >         ??? Memory function: memfd_create
> >         ??? AMTU (Abstract Machine Test Utility)
> >         ??? Networking bridge: sanity
> >         ??? Ethernet drivers sanity
> >         ??? Networking MACsec: sanity
> >         ??? Networking socket: fuzz
> >         ??? Networking sctp-auth: sockopts test
> >         ??? Networking: igmp conformance test
> >         ??? Networking route: pmtu
> >         ??? Networking route_func - local
> >         ??? Networking route_func - forward
> >         ??? Networking TCP: keepalive test
> >         ??? Networking UDP: socket
> >         ??? Networking tunnel: geneve basic test
> >         ??? Networking tunnel: gre basic
> >         ??? L2TP basic test
> >         ??? Networking tunnel: vxlan basic
> >         ??? Networking ipsec: basic netns - transport
> >         ??? Networking ipsec: basic netns - tunnel
> >         ??? audit: audit testsuite test
> >         ??? httpd: mod_ssl smoke sanity
> >         ??? tuned: tune-processes-through-perf
> >         ??? pciutils: sanity smoke test
> >         ??? ALSA PCM loopback test
> >         ??? ALSA Control (mixer) Userspace Element test
> >         ??? storage: SCSI VPD
> >         ??? trace: ftrace/tracer
> >         ? ??? CIFS Connectathon
> >         ? ??? POSIX pjd-fstest suites
> >         ? ??? jvm - DaCapo Benchmark Suite
> >         ? ??? jvm - jcstress tests
> >         ? ??? Memory function: kaslr
> >         ? ??? LTP: openposix test suite
> >         ? ??? Networking vnic: ipvlan/basic
> >         ? ??? iotop: sanity
> >         ? ??? Usex - version 1.9-29
> >         ? ??? storage: dm/common
> > 
> >      Host 2:
> >         ? Boot test
> >         ? Storage SAN device stress - mpt3sas driver
> > 
> >      Host 3:
> >         ? Boot test
> >         ? Storage SAN device stress - megaraid_sas
> > 
> >      Host 4:
> >         ? Boot test
> >         ? xfstests - ext4
> >         ??? xfstests - xfs
> >         ??? selinux-policy: serge-testsuite
> >         ??? lvm thinp sanity
> >         ??? storage: software RAID testing
> >         ??? stress: stress-ng
> >         ? ??? IOMMU boot test
> >         ? ??? IPMI driver test
> >         ? ??? IPMItool loop stress test
> >         ? ??? power-management: cpupower/sanity test
> >         ? ??? Storage blktests
> > 
> >    Test sources: https://github.com/CKI-project/tests-beaker
> >      ? Pull requests are welcome for new tests or improvements to existing tests!
> > 
> > Waived tests
> > ------------
> > If the test run included waived tests, they are marked with ?. Such tests are
> > executed but their results are not taken into account. Tests are waived when
> > their results are not reliable enough, e.g. when they're just introduced or are
> > being fixed.
> > 
> > Testing timeout
> > ---------------
> > We aim to provide a report within reasonable timeframe. Tests that haven't
> > finished running yet are marked with ?.
> > 
> > 

-- 
Murphy

