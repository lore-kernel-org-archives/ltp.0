From: Juri Lelli <juri.lelli@redhat.com>
Date: Thu, 25 Jan 2018 12:20:13 +0100
Subject: [LTP] [lkp-robot] [sched/deadline] e0367b1267:
 WARNING:at_kernel/sched/sched.h:#assert_clock_updated
In-Reply-To: <20180125062839.GM5185@yexl-desktop>
References: <20180125062839.GM5185@yexl-desktop>
Message-ID: <20180125112013.GA6110@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 25/01/18 14:28, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e0367b12674bf4420870cd0237e3ebafb2ec9593 ("sched/deadline: Move CPU frequency selection triggering points")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: ltp
> with following parameters:
> 
> 	test: sched
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------------------------------+------------+------------+
> |                                                                  | d4edd662ac | e0367b1267 |
> +------------------------------------------------------------------+------------+------------+
> | boot_successes                                                   | 0          | 0          |
> | boot_failures                                                    | 9          | 7          |
> | invoked_oom-killer:gfp_mask=0x                                   | 9          | 4          |
> | Mem-Info                                                         | 9          | 4          |
> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 9          | 4          |
> | WARNING:at_kernel/sched/sched.h:#assert_clock_updated            | 0          | 3          |
> | RIP:assert_clock_updated                                         | 0          | 3          |
> | RIP:cpuidle_enter_state                                          | 0          | 1          |
> | RIP:clear_page_erms                                              | 0          | 1          |
> | RIP:page_add_file_rmap                                           | 0          | 1          |
> +------------------------------------------------------------------+------------+------------+
> 
> 
> 
> kern  :warn  : [  123.841479] WARNING: CPU: 67 PID: 3837 at kernel/sched/sched.h:889 assert_clock_updated+0x13/0x20
> kern  :warn  : [  123.841480] Modules linked in: loop intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200 irqbypass crct10dif_pclmul ttm crc32_pclmul snd_pcm drm_kms_helper crc32c_intel syscopyarea sysfillrect sysimgblt ghash_clmulni_intel fb_sys_fops snd_timer mxm_wmi pcbc ipmi_si ahci aesni_intel snd crypto_simd ipmi_devintf glue_helper soundcore drm libahci cryptd ipmi_msghandler pcspkr libata shpchp wmi acpi_pad acpi_power_meter ip_tables
> kern  :warn  : [  123.841500] CPU: 67 PID: 3837 Comm: ltp-pan Not tainted 4.15.0-rc6-00133-ge0367b1 #1
> kern  :warn  : [  123.841501] Hardware name: Intel Corporation S2600KPR/S2600KPR, BIOS SE5C610.86B.01.01.0019.101220160604 10/12/2016
> kern  :warn  : [  123.841503] RIP: 0010:assert_clock_updated+0x13/0x20
> kern  :warn  : [  123.841504] RSP: 0018:ffff88102bdc3ee0 EFLAGS: 00010086
> kern  :warn  : [  123.841505] RAX: 0000000000000026 RBX: ffff88106f23cfe8 RCX: 0000000000000000
> kern  :warn  : [  123.841505] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000092
> kern  :warn  : [  123.841506] RBP: ffff88102bde2800 R08: 0000000000000026 R09: ffffffff82b1d4e0
> user  :notice: [  123.841507] fpu_exception	: yes
> kern  :warn  : [  123.841507] R10: ffff8810280f4498 R11: 0000000000000000 R12: ffff8810279be000
> 
> kern  :warn  : [  123.841508] R13: 0000000000022800 R14: ffffffff81767d50 R15: ffff88102bddd1a8
> kern  :warn  : [  123.841510] FS:  00007fd41d6d9700(0000) GS:ffff88102bdc0000(0000) knlGS:0000000000000000
> kern  :warn  : [  123.841510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kern  :warn  : [  123.841511] CR2: 0000563f9799ee30 CR3: 000000107bb78001 CR4: 00000000003606e0
> kern  :warn  : [  123.841512] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kern  :warn  : [  123.841512] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kern  :warn  : [  123.841513] Call Trace:
> kern  :warn  : [  123.841515]  <IRQ>
> kern  :warn  : [  123.841517]  inactive_task_timer+0x383/0x460
> kern  :warn  : [  123.841520]  ? pull_dl_task+0x600/0x600
> kern  :warn  : [  123.841525]  __hrtimer_run_queues+0xd3/0x230
> kern  :warn  : [  123.841528]  hrtimer_interrupt+0xa6/0x200
> kern  :warn  : [  123.841532]  smp_apic_timer_interrupt+0x56/0x130
> kern  :warn  : [  123.841534]  apic_timer_interrupt+0xa2/0xb0
> kern  :warn  : [  123.841535]  </IRQ>
> kern  :warn  : [  123.841539] RIP: 0010:alloc_pid+0xcf/0x2a0
> kern  :warn  : [  123.841539] RSP: 0018:ffffc900084b7db0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff11
> kern  :warn  : [  123.841540] RAX: 000000000000171e RBX: 0000000000000000 RCX: 0000000000000000
> kern  :warn  : [  123.841541] RDX: 000000000000171e RSI: ffff8810280f4470 RDI: ffffffff82205180
> kern  :warn  : [  123.841542] RBP: ffffffff8225a2e0 R08: 0000000000000044 R09: 0000000000000228
> kern  :warn  : [  123.841542] R10: ffff8810280f4498 R11: 000000000000001f R12: ffff881024787278
> kern  :warn  : [  123.841543] R13: ffffffff8225a2e0 R14: ffff881024787240 R15: ffffffff82205180
> kern  :warn  : [  123.841548]  copy_process+0xf5a/0x1b00
> kern  :warn  : [  123.841551]  _do_fork+0xbd/0x3d0
> kern  :warn  : [  123.841553]  ? task_work_run+0x48/0xd0
> kern  :warn  : [  123.841557]  do_syscall_64+0x61/0x190
> kern  :warn  : [  123.841559]  entry_SYSCALL64_slow_path+0x25/0x25
> kern  :warn  : [  123.841561] RIP: 0033:0x7fd41cec676b
> kern  :warn  : [  123.841561] RSP: 002b:00007ffc261df870 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> kern  :warn  : [  123.841562] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd41cec676b
> kern  :warn  : [  123.841563] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> kern  :warn  : [  123.841563] RBP: 00007ffc261df8b0 R08: 00007fd41d6d9700 R09: 000000000000001e
> kern  :warn  : [  123.841564] R10: 00007fd41d6d99d0 R11: 0000000000000246 R12: 0000000000000000
> kern  :warn  : [  123.841564] R13: 0000563f9799cae0 R14: 0000000000000000 R15: 0000563f9799cd10
> kern  :warn  : [  123.841566] Code: 48 89 83 20 09 00 00 eb c7 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 c7 c7 c8 fe 0a 82 c6 05 c3 69 35 01 01 e8 ad 01 fc ff <0f> ff c3 66 2e 0f 1f 84 00 00 00 00 00 48 c7 c7 15 04 0b 82 c6 
> kern  :warn  : [  123.841583] ---[ end trace 5f3bf5f199ab1f72 ]---
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml

Hummm, wondering how LTP sched tests could trigger this, since a quick
grep into ltp didn't show DEADLINE usage.

However, I'm currently thinking that we should update clock before
potentially calling sub_running_bw (which might trigger schedutil
update) in inactive_task_timer.

Would what follows cure it?

Thanks,

- Juri

--->8---
 kernel/sched/deadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9bb0e0c412ec..59761e635d12 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1261,6 +1261,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 	rq = task_rq_lock(p, &rf);
 
+	sched_clock_tick();
+	update_rq_clock(rq);
+
 	if (!dl_task(p) || p->state == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1280,9 +1283,6 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
-	sched_clock_tick();
-	update_rq_clock(rq);
-
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
