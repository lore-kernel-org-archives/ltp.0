From: Chao Yu <yuchao0@huawei.com>
Date: Tue, 16 Mar 2021 16:34:02 +0800
Subject: [LTP] [f2fs] ab2dbddfd0: BUG:kernel_NULL_pointer_dereference,
 address
In-Reply-To: <20210316045800.GB11637@xsang-OptiPlex-9020>
References: <20210316045800.GB11637@xsang-OptiPlex-9020>
Message-ID: <834d5270-ab2e-bd6a-addc-28ae357f67ee@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sahitya,

Node manager was initialized after segment manager's initialization,
so f2fs_available_free_memory() called from issue_discard_thread()
may access invalid nm_i pointer, could you please check and fix
this case?

On 2021/3/16 12:58, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: ab2dbddfd064f2078a7099e4d65cce54f5ef5e71 ("[PATCH v2] f2fs: allow to change discard policy based on cached discard cmds")
> url: https://github.com/0day-ci/linux/commits/Sahitya-Tummala/f2fs-allow-to-change-discard-policy-based-on-cached-discard-cmds/20210311-170257
> 
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20210315
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: f2fs
> 	test: io
> 	ucode: 0x21
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   38.378402] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [   38.378526] #PF: supervisor read access in kernel mode
> [   38.378610] #PF: error_code(0x0000) - not-present page
> [   38.378694] PGD 0 P4D 0
> [   38.378739] Oops: 0000 [#1] SMP PTI
> [   38.378799] CPU: 2 PID: 2436 Comm: f2fs_discard-8: Not tainted 5.12.0-rc2-00001-gab2dbddfd064 #1
> [   38.378940] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
> [   38.379057] RIP: 0010:f2fs_available_free_memory (kbuild/src/consumer/fs/f2fs/node.c:96) f2fs
> [ 38.379237] Code: 04 00 00 48 0f af d6 48 be c3 f5 28 5c 8f c2 f5 28 48 c1 ea 02 48 89 d0 48 f7 e6 48 c1 ea 03 48 39 ca 0f 97 c0 e9 af fe ff ff <41> 8b 54 24 10 49 63 8d 94 20 00 00 48 0f af d6 48 be c3 f5 28 5c
> All code
> ========
>     0:	04 00                	add    $0x0,%al
>     2:	00 48 0f             	add    %cl,0xf(%rax)
>     5:	af                   	scas   %es:(%rdi),%eax
>     6:	d6                   	(bad)
>     7:	48 be c3 f5 28 5c 8f 	movabs $0x28f5c28f5c28f5c3,%rsi
>     e:	c2 f5 28
>    11:	48 c1 ea 02          	shr    $0x2,%rdx
>    15:	48 89 d0             	mov    %rdx,%rax
>    18:	48 f7 e6             	mul    %rsi
>    1b:	48 c1 ea 03          	shr    $0x3,%rdx
>    1f:	48 39 ca             	cmp    %rcx,%rdx
>    22:	0f 97 c0             	seta   %al
>    25:	e9 af fe ff ff       	jmpq   0xfffffffffffffed9
>    2a:*	41 8b 54 24 10       	mov    0x10(%r12),%edx		<-- trapping instruction
>    2f:	49 63 8d 94 20 00 00 	movslq 0x2094(%r13),%rcx
>    36:	48 0f af d6          	imul   %rsi,%rdx
>    3a:	48                   	rex.W
>    3b:	be c3 f5 28 5c       	mov    $0x5c28f5c3,%esi
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	41 8b 54 24 10       	mov    0x10(%r12),%edx
>     5:	49 63 8d 94 20 00 00 	movslq 0x2094(%r13),%rcx
>     c:	48 0f af d6          	imul   %rsi,%rdx
>    10:	48                   	rex.W
>    11:	be c3 f5 28 5c       	mov    $0x5c28f5c3,%esi
> [   38.379531] RSP: 0018:ffffc900006f3dd8 EFLAGS: 00010246
> [   38.379617] RAX: 0000000000000106 RBX: ffff888213317000 RCX: 00000000001e9c8c
> [   38.379731] RDX: ffff88810c84b430 RSI: 00000000001e9c8c RDI: ffff88810c84b540
> [   38.379844] RBP: 0000000000000006 R08: 0000000000000106 R09: ffff88821fb2bc58
> [   38.379958] R10: 000000000000032e R11: ffff88821fb2a144 R12: 0000000000000000
> [   38.380071] R13: ffff88820b7e4000 R14: 000000000000ea60 R15: 0000000000000000
> [   38.380185] FS:  0000000000000000(0000) GS:ffff88821fb00000(0000) knlGS:0000000000000000
> [   38.380315] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.380408] CR2: 0000000000000010 CR3: 000000021e00a003 CR4: 00000000001706e0
> [   38.380522] Call Trace:
> [   38.380619] ? del_timer_sync (kbuild/src/consumer/kernel/time/timer.c:1394)
> [   38.380686] ? prepare_to_wait_event (kbuild/src/consumer/kernel/sched/wait.c:323 (discriminator 15))
> [   38.380762] ? __next_timer_interrupt (kbuild/src/consumer/kernel/time/timer.c:1816)
> [   38.380841] issue_discard_thread (kbuild/src/consumer/fs/f2fs/segment.c:1759 (discriminator 1)) f2fs
> [   38.380937] ? finish_wait (kbuild/src/consumer/kernel/sched/wait.c:403)
> [   38.380997] ? __issue_discard_cmd (kbuild/src/consumer/fs/f2fs/segment.c:1722) f2fs
> [   38.381094] kthread (kbuild/src/consumer/kernel/kthread.c:292)
> [   38.381151] ? kthread_park (kbuild/src/consumer/kernel/kthread.c:245)
> [   38.381213] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:300)
> [   38.381276] Modules linked in: dm_mod f2fs netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c sd_mod t10_pi sg intel_rapl_msr intel_rapl_common i915 x86_pkg_temp_thermal intel_powerclamp coretemp intel_gtt crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel usb_storage ghash_clmulni_intel syscopyarea rapl ahci libahci sysfillrect sysimgblt fb_sys_fops ipmi_devintf ipmi_msghandler intel_cstate drm libata intel_uncore mei_me mei video ip_tables
> [   38.381939] CR2: 0000000000000010
> [   38.381996] ---[ end trace d47b1e3f3cb425e8 ]---
> [   38.382072] RIP: 0010:f2fs_available_free_memory (kbuild/src/consumer/fs/f2fs/node.c:96) f2fs
> [ 38.382188] Code: 04 00 00 48 0f af d6 48 be c3 f5 28 5c 8f c2 f5 28 48 c1 ea 02 48 89 d0 48 f7 e6 48 c1 ea 03 48 39 ca 0f 97 c0 e9 af fe ff ff <41> 8b 54 24 10 49 63 8d 94 20 00 00 48 0f af d6 48 be c3 f5 28 5c
> All code
> ========
>     0:	04 00                	add    $0x0,%al
>     2:	00 48 0f             	add    %cl,0xf(%rax)
>     5:	af                   	scas   %es:(%rdi),%eax
>     6:	d6                   	(bad)
>     7:	48 be c3 f5 28 5c 8f 	movabs $0x28f5c28f5c28f5c3,%rsi
>     e:	c2 f5 28
>    11:	48 c1 ea 02          	shr    $0x2,%rdx
>    15:	48 89 d0             	mov    %rdx,%rax
>    18:	48 f7 e6             	mul    %rsi
>    1b:	48 c1 ea 03          	shr    $0x3,%rdx
>    1f:	48 39 ca             	cmp    %rcx,%rdx
>    22:	0f 97 c0             	seta   %al
>    25:	e9 af fe ff ff       	jmpq   0xfffffffffffffed9
>    2a:*	41 8b 54 24 10       	mov    0x10(%r12),%edx		<-- trapping instruction
>    2f:	49 63 8d 94 20 00 00 	movslq 0x2094(%r13),%rcx
>    36:	48 0f af d6          	imul   %rsi,%rdx
>    3a:	48                   	rex.W
>    3b:	be c3 f5 28 5c       	mov    $0x5c28f5c3,%esi
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	41 8b 54 24 10       	mov    0x10(%r12),%edx
>     5:	49 63 8d 94 20 00 00 	movslq 0x2094(%r13),%rcx
>     c:	48 0f af d6          	imul   %rsi,%rdx
>    10:	48                   	rex.W
>    11:	be c3 f5 28 5c       	mov    $0x5c28f5c3,%esi
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install                job.yaml  # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml
>          bin/lkp run                    compatible-job.yaml
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
