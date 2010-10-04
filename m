Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1P2fF5-0008I3-Ei
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 07:13:47 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P2fF2-0006mM-WB
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 07:13:47 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9476gc3025901
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Oct 2010 03:06:42 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o947DdwY351248
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Oct 2010 03:13:39 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o947Ddhw023794
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Oct 2010 03:13:39 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1285689961.11429.12.camel@subratamodak.linux.ibm.com>
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
Date: Mon, 04 Oct 2010 12:43:38 +0530
Message-Id: <1286176418.4882.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v2] Add ftrace-stress-test to LTP
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi Li,

Can you please address the following queries/issues ?

Regards--
Subrata

On Tue, 2010-09-28 at 21:35 +0530, Subrata Modak wrote: 
> On Tue, 2010-09-07 at 10:50 +0800, Li Zefan wrote:
> > We test ftrace by forking processes to simultaneously and
> > constantly read/write different tracing files in debugfs
> > and procfs. This stress test aims at revealing races in
> > various corner cases
> > 
> > The test will be skipped if the kernel is older than 2.6.34,
> > mainly because it can crash old kernels.
> > 
> > The test will run by default and will run for 90 seconds.
> > 
> > To run this test only:
> > 
> > 	# ./runltp -f tracing
> > 
> > 
> > Changelog for v2:
> > 
> > - Addressed the comments from Garrett
> > 
> > Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> 
> Sorry for responding late. I gave a try to these tests and has my
> following observations:
> 
> You said that the tests can run on kernels above 2.6.34 without issues.
> But, i ran them on stable 2.6.35.4 and still found kernel panics. I
> built kernel 2.6.35.4 on my existing Fedora 13 PowerPC box.
> 
> # uname -a
> Linux 2.6.35.4 #2 SMP Tue Sep 28 16:07:27 IST 2010 ppc64 ppc64 ppc64
> GNU/Linux
> # cat /etc/issue
> Fedora release 13 (Goddard)
> Kernel \r on an \m (\l)
> 
> When i ran the tests:
> Running tests.......
> <<<test_start>>>
> tag=ftrace-stress-test stime=1285684343
> cmdline="ftrace_stress_test.sh 90"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> Ftrace Stress Test Begin
> ...
> 
> The following panic and system reboot was observed on mu Serial console:
> ========================================================================
> Unable to handle kernel paging request for data at address
> 0xbffffe4007fc8040
> Unable to handle kernel paging request for data at address
> 0xbffffe4007fc8040
> Faulting instruction address: 0xc00000000010f4a8
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA pSeries
> last sysfs
> file: /sys/devices/vio/30000002/host0/target0:0:2/0:0:2:0/model
> Modules linked in: sunrpc ipv6 uinput ehea ibmvscsic scsi_transport_srp
> scsi_tgt [last unloaded: scsi_wait_scan]
> NIP: c00000000010f4a8 LR: c00000000010f30c CTR: c00000000020f698
> REGS: c0000000dafa70a0 TRAP: 0300   Tainted: G        W    (2.6.35.4)
> MSR: 8000000000001032 <ME,IR,DR>  CR: 48002048  XER: 00000000
> DAR: bffffe4007fc8040, DSISR: 0000000040000000
> TASK = c0000000daf950d0[9] 'migration/2' THREAD: c0000000dafa4000 CPU: 2
> GPR00: 0000000000009c35 c0000000dafa7320 c000000001735d40
> 0000000000000000 
> GPR04: c00000000010f308 c0000000dafa7278 0000000000000000
> 0000000000009c34 
> GPR08: fffffe4000000000 c0000000de003580 bffffe4007fc8000
> c000000001033720 
> GPR12: 0000000028002042 c000000007fc8e00 0000000006e3fa78
> 00000000005f3000 
> GPR16: c0000000dafa77d0 c000000001c852b0 c0000000dafa77c0
> 0000000000000000 
> GPR20: 0000000000000000 c000000001813350 7fffffffffffffff
> c0000000017dea80 
> GPR24: 0000000000c55000 c0000000daeabc00 0000000001dcff22
> c0000000daf950d0 
> GPR28: c000000001c87780 c0000000017cea80 c0000000016a5df0
> c0000000dafa7320 
> NIP [c00000000010f4a8] .update_curr_rt+0x1e8/0x538
> LR [c00000000010f30c] .update_curr_rt+0x4c/0x538
> Call Trace:
> [c0000000dafa7320] [c00000000010f30c] .update_curr_rt+0x4c/0x538
> (unreliable)
> [c0000000dafa73f0] [c00000000010f848] .task_tick_rt+0x50/0x1a4
> [c0000000dafa7490] [c000000000121468] .scheduler_tick+0x2ac/0x684
> [c0000000dafa7550] [c00000000014c2c8] .update_process_times+0xd0/0x120
> [c0000000dafa75f0] [c00000000018b76c] .tick_sched_timer+0x128/0x1a8
> [c0000000dafa76a0] [c000000000174324] .__run_hrtimer+0x28c/0x3d8
> [c0000000dafa7750] [c000000000174960] .hrtimer_interrupt+0x18c/0x3c8
> [c0000000dafa7860] [c000000000047c00] .timer_interrupt+0x40c/0x598
> [c0000000dafa7900] [c000000000003728] decrementer_common+0x128/0x180
> --- Exception: 901 at .raw_local_irq_restore+0x168/0x194
>     LR = .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafa7bf0] [c0000000dafa7cb0] 0xc0000000dafa7cb0 (unreliable)
> [c0000000dafa7c90] [c0000000001d66c8] .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafa7d50] [c0000000001d6238] .cpu_stopper_thread+0x1dc/0x3c8
> [c0000000dafa7ec0] [c00000000016be28] .kthread+0x124/0x13c
> [c0000000dafa7f90] [c00000000004e270] .kernel_thread+0x54/0x70
> Instruction dump:
> e9290050 1d080700 f80b5888 48000038 e95e8010 e97e8000 e94a0000 e8eb5890 
> 7d4a4214 38070001 f80b5890 e9690020 <e94a0040> 7c0b502a 7c00d214
> 7c0b512a 
> Faulting instruction address: 0xc00000000010f4a8
> Oops: Kernel access of bad area, sig: 11 [#2]
> SMP NR_CPUS=128 NUMA pSeries
> last sysfs
> file: /sys/devices/vio/30000002/host0/target0:0:2/0:0:2:0/model
> Modules linked in: sunrpc ipv6 uinput ehea ibmvscsic scsi_transport_srp
> scsi_tgt [last unloaded: scsi_wait_scan]
> NIP: c00000000010f4a8 LR: c00000000010f30c CTR: c00000000020f698
> REGS: c0000000dafc30a0 TRAP: 0300   Tainted: G      D W    (2.6.35.4)
> MSR: 8000000000001032 <ME,IR,DR>  CR: 48002048  XER: 00000000
> DAR: bffffe4007fc8040, DSISR: 0000000040000000
> TASK = c0000000dafb35e0[12] 'migration/3' THREAD: c0000000dafc0000 CPU:
> 3
> GPR00: 0000000000009c34 c0000000dafc3320 c000000001735d40
> 0000000000000000 
> GPR04: c00000000010f308 c0000000dafc3278 0000000000000000
> 0000000000009c33 
> GPR08: fffffe4000000000 c0000000de003580 bffffe4007fc8000
> c000000001033720 
> GPR12: c0000000d1725300 c000000007fc9500 0000000006e3fa78
> 00000000005f3000 
> GPR16: c0000000dafc37d0 c000000001cc52b0 c0000000dafc37c0
> 0000000000000000 
> GPR20: 0000000000000000 c000000001813350 7fffffffffffffff
> c0000000017dea80 
> GPR24: 0000000000c95000 c0000000dafb8800 0000000001daff3e
> c0000000dafb35e0 
> GPR28: c000000001cc7780 c0000000017cea80 c0000000016a5df0
> c0000000dafc3320 
> NIP [c00000000010f4a8] .update_curr_rt+0x1e8/0x538
> LR [c00000000010f30c] .update_curr_rt+0x4c/0x538
> Call Trace:
> [c0000000dafc3320] [c00000000010f30c] .update_curr_rt+0x4c/0x538
> (unreliable)
> [c0000000dafc33f0] [c00000000010f848] .task_tick_rt+0x50/0x1a4
> [c0000000dafc3490] [c000000000121468] .scheduler_tick+0x2ac/0x684
> [c0000000dafc3550] [c00000000014c2c8] .update_process_times+0xd0/0x120
> [c0000000dafc35f0] [c00000000018b76c] .tick_sched_timer+0x128/0x1a8
> [c0000000dafc36a0] [c000000000174324] .__run_hrtimer+0x28c/0x3d8
> [c0000000dafc3750] [c000000000174960] .hrtimer_interrupt+0x18c/0x3c8
> [c0000000dafc3860] [c000000000047c00] .timer_interrupt+0x40c/0x598
> [c0000000dafc3900] [c000000000003728] decrementer_common+0x128/0x180
> --- Exception: 901 at .raw_local_irq_restore+0x168/0x194
>     LR = .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafc3bf0] [c0000000dafc3cb0] 0xc0000000dafc3cb0 (unreliable)
> [c0000000dafc3c90] [c0000000001d66c8] .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafc3d50] [c0000000001d6238] .cpu_stopper_thread+0x1dc/0x3c8
> [c0000000dafc3ec0] [c00000000016be28] .kthread+0x124/0x13c
> [c0000000dafc3f90] [c00000000004e270] .kernel_thread+0x54/0x70
> Instruction dump:
> e9290050 1d080700 f80b5888 48000038 e95e8010 e97e8000 e94a0000 e8eb5890 
> 7d4a4214 38070001 f80b5890 e9690020 <e94a0040> 7c0b502a 7c00d214
> 7c0b512a 
> Kernel panic - not syncing: Fatal exception in interrupt
> Call Trace:
> [c0000000dafa6ce0] [c00000000001d068] .show_stack+0x148/0x384
> (unreliable)
> [c0000000dafa6dc0] [c000000000bdd208] .dump_stack+0x50/0x78
> [c0000000dafa6e50] [c000000000bdd328] .panic+0xf8/0x26c
> [c0000000dafa6ef0] [c00000000004a2d8] .die+0x434/0x494
> [c0000000dafa6fa0] [c0000000000679a8] .bad_page_fault+0x154/0x184
> [c0000000dafa7030] [c000000000005704] handle_page_fault+0x3c/0x74
> --- Exception: 300 at .update_curr_rt+0x1e8/0x538
>     LR = .update_curr_rt+0x4c/0x538
> [c0000000dafa73f0] [c00000000010f848] .task_tick_rt+0x50/0x1a4
> [c0000000dafa7490] [c000000000121468] .scheduler_tick+0x2ac/0x684
> [c0000000dafa7550] [c00000000014c2c8] .update_process_times+0xd0/0x120
> [c0000000dafa75f0] [c00000000018b76c] .tick_sched_timer+0x128/0x1a8
> [c0000000dafa76a0] [c000000000174324] .__run_hrtimer+0x28c/0x3d8
> [c0000000dafa7750] [c000000000174960] .hrtimer_interrupt+0x18c/0x3c8
> [c0000000dafa7860] [c000000000047c00] .timer_interrupt+0x40c/0x598
> [c0000000dafa7900] [c000000000003728] decrementer_common+0x128/0x180
> --- Exception: 901 at .raw_local_irq_restore+0x168/0x194
>     LR = .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafa7bf0] [c0000000dafa7cb0] 0xc0000000dafa7cb0 (unreliable)
> Kernel panic - not syncing: Fatal exception in interrupt
> [c0000000dafa7c90] [c0000000001d66c8] .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafa7d50] [c0000000001d6238] .cpu_stopper_thread+0x1dc/0x3c8
> [c0000000dafa7ec0] [c00000000016be28] .kthread+0x124/0x13c
> [c0000000dafa7f90] [c00000000004e270] .kernel_thread+0x54/0x70
> Call Trace:
> [c0000000dafc2ce0] [c00000000001d068] .show_stack+0x148/0x384
> (unreliable)
> [c0000000dafc2dc0] [c000000000bdd208] .dump_stack+0x50/0x78
> [c0000000dafc2e50] [c000000000bdd328] .panic+0xf8/0x26c
> [c0000000dafc2ef0] [c00000000004a2d8] .die+0x434/0x494
> [c0000000dafc2fa0] [c0000000000679a8] .bad_page_fault+0x154/0x184
> [c0000000dafc3030] [c000000000005704] handle_page_fault+0x3c/0x74
> --- Exception: 300 at .update_curr_rt+0x1e8/0x538
>     LR = .update_curr_rt+0x4c/0x538
> [c0000000dafc33f0] [c00000000010f848] .task_tick_rt+0x50/0x1a4
> [c0000000dafc3490] [c000000000121468] .scheduler_tick+0x2ac/0x684
> [c0000000dafc3550] [c00000000014c2c8] .update_process_times+0xd0/0x120
> [c0000000dafc35f0] [c00000000018b76c] .tick_sched_timer+0x128/0x1a8
> [c0000000dafc36a0] [c000000000174324] .__run_hrtimer+0x28c/0x3d8
> [c0000000dafc3750] [c000000000174960] .hrtimer_interrupt+0x18c/0x3c8
> [c0000000dafc3860] [c000000000047c00] .timer_interrupt+0x40c/0x598
> [c0000000dafc3900] [c000000000003728] decrementer_common+0x128/0x180
> --- Exception: 901 at .raw_local_irq_restore+0x168/0x194
>     LR = .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafc3bf0] [c0000000dafc3cb0] 0xc0000000dafc3cb0 (unreliable)
> [c0000000dafc3c90] [c0000000001d66c8] .stop_machine_cpu_stop+0x2a4/0x2f4
> [c0000000dafc3d50] [c0000000001d6238] .cpu_stopper_thread+0x1dc/0x3c8
> [c0000000dafc3ec0] [c00000000016be28] .kthread+0x124/0x13c
> [c0000000dafc3f90] [c00000000004e270] .kernel_thread+0x54/0x70
> RTAS: event: 29, Type: Platform Error, Severity: 2
> ibm,os-term call failed -1
> Rebooting in 180 seconds..
> RTAS: event: 30, Type: Platform Error, Severity: 2
> ibm,os-term call failed -1
> Rebooting in 180 seconds..
> ========================================================================
> 
> Can you please address the following things:
>      1. I was not sure which particular CONFIG options to enable when
>         building kernel to enable tracing options that these tests would
>         require. So, i had enabled most of them while building the
>         kernel. Please see the attached config file. In your next
>         patch[v3], can you please a bit of documentation on this front
>         of what other system requirements are needed to execute these
>         tests, including the kernel CONFIG options to be enabled,
>      2. So, going by your description, the tests should run on kernel
>         greater than 2.6.34. But, on kernel 2.6.35.4 it still creates
>         kernel panic. So, is this
>              I. a test case issues ?
>             II. or, real kernel bug which has not yet being addressed
>                 till now ?
> 
> Regards--
> Subrata
> 
> > ---
> >  runltp                                             |    3 +-
> >  runtest/tracing                                    |    2 +
> >  testcases/kernel/Makefile                          |    2 +-
> >  testcases/kernel/tracing/Makefile                  |    5 +
> >  .../kernel/tracing/ftrace_stress_test/Makefile     |    7 +
> >  .../ftrace_stress_test/ftrace_get_page_size.c      |   10 +
> >  .../ftrace_stress/ftrace_buffer_size.sh            |   43 ++++
> >  .../ftrace_stress/ftrace_current_tracer.sh         |   34 +++
> >  .../ftrace_stress/ftrace_ftrace_enabled.sh         |   39 ++++
> >  .../ftrace_stress/ftrace_profile_enabled.sh        |   50 ++++
> >  .../ftrace_stress/ftrace_set_event.sh              |   44 ++++
> >  .../ftrace_stress/ftrace_set_ftrace_pid.sh         |   44 ++++
> >  .../ftrace_stress/ftrace_stack_max_size.sh         |   39 ++++
> >  .../ftrace_stress/ftrace_stack_trace.sh            |   46 ++++
> >  .../ftrace_stress/ftrace_trace.sh                  |   27 +++
> >  .../ftrace_stress/ftrace_trace_clock.sh            |   46 ++++
> >  .../ftrace_stress/ftrace_trace_options.sh          |   42 ++++
> >  .../ftrace_stress/ftrace_trace_pipe.sh             |   52 +++++
> >  .../ftrace_stress/ftrace_trace_stat.sh             |   45 ++++
> >  .../ftrace_stress/ftrace_tracing_enabled.sh        |   39 ++++
> >  .../ftrace_stress/ftrace_tracing_max_latency.sh    |   38 +++
> >  .../ftrace_stress/ftrace_tracing_on.sh             |   39 ++++
> >  .../ftrace_stress_test/ftrace_stress_test.sh       |  237 ++++++++++++++++++++
> >  23 files changed, 931 insertions(+), 2 deletions(-)
> >  create mode 100644 runtest/tracing
> >  create mode 100644 testcases/kernel/tracing/Makefile
> >  create mode 100644 testcases/kernel/tracing/ftrace_stress_test/Makefile
> >  create mode 100644 testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
> >  create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> > 
> > diff --git a/runltp b/runltp
> > index b385984..89b1717 100755
> > --- a/runltp
> > +++ b/runltp
> > @@ -593,7 +593,8 @@ main()
> >                           ${LTPROOT}/runtest/numa                    \
> >                           ${LTPROOT}/runtest/hugetlb                 \
> >                           ${LTPROOT}/runtest/commands                \
> > -                         ${LTPROOT}/runtest/hyperthreading
> > +                         ${LTPROOT}/runtest/hyperthreading          \
> > +                         ${LTPROOT}/runtest/tracing
> >          do
> >              [ -e "$SCENFILES" ] || \
> >              {
> > diff --git a/runtest/tracing b/runtest/tracing
> > new file mode 100644
> > index 0000000..ef3a048
> > --- /dev/null
> > +++ b/runtest/tracing
> > @@ -0,0 +1,2 @@
> > +#DESCRIPTION:Tracing testing
> > +ftrace-stress-test	ftrace_stress_test.sh 90
> > diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> > index e2a9d8e..8c50025 100644
> > --- a/testcases/kernel/Makefile
> > +++ b/testcases/kernel/Makefile
> > @@ -30,7 +30,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
> >  ifneq ($(UCLINUX),1)
> >  SUBDIRS		:= containers connectors controllers fs hotplug io ipc mem \
> >  		   numa performance_counters power_management pty sched \
> > -		   security syscalls timers
> > +		   security syscalls timers tracing
> >  else
> >  SUBDIRS		:= syscalls
> >  endif
> > diff --git a/testcases/kernel/tracing/Makefile b/testcases/kernel/tracing/Makefile
> > new file mode 100644
> > index 0000000..e9f96c3
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/Makefile
> > @@ -0,0 +1,5 @@
> > +top_srcdir		?= ../../..
> > +
> > +include $(top_srcdir)/include/mk/env_pre.mk
> > +
> > +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/Makefile b/testcases/kernel/tracing/ftrace_stress_test/Makefile
> > new file mode 100644
> > index 0000000..e4a913a
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/Makefile
> > @@ -0,0 +1,7 @@
> > +top_srcdir              ?= ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +INSTALL_TARGETS         := *.sh ftrace_stress/*
> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> > new file mode 100644
> > index 0000000..b52a109
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> > @@ -0,0 +1,10 @@
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +
> > +int main(void)
> > +{
> > +	printf("%d\n", getpagesize());
> > +
> > +	return 0;
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
> > new file mode 100755
> > index 0000000..af5a98e
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
> > @@ -0,0 +1,43 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=200
> > +
> > +# Use up to 10% of free memory
> > +free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
> > +step=$(( $free_mem / 10 / $LOOP ))
> > +if [ $step -eq 0 ]; then
> > +	$step=1
> > +	LOOP=50
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +	new_size=1
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		echo $new_size > "$TRACING_PATH"/buffer_size_kb
> > +		new_size=$(( $new_size + $step ))
> > +	}
> > +
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		new_size=$(( $new_size - $step ))
> > +		echo $new_size > "$TRACING_PATH"/buffer_size_kb
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
> > new file mode 100755
> > index 0000000..88d576f
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
> > @@ -0,0 +1,34 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=200
> > +
> > +for ((; ;))
> > +{
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		for tracer in `cat "$TRACING_PATH"/available_tracers`
> > +		do
> > +			if [ "$tracer" = mmiotrace ]; then
> > +				continue
> > +			fi
> > +
> > +			echo $tracer > "$TRACING_PATH"/current_tracer 2> /dev/null
> > +		done
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
> > new file mode 100755
> > index 0000000..20bb234
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
> > @@ -0,0 +1,39 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +MAX_LOOP=1500
> > +count=0
> > +
> > +for ((; ;))
> > +{
> > +	count=$(( $count + 1 ))
> > +
> > +	for ((i = 0; i < $MAX_LOOP; i++))
> > +	{
> > +		echo 0 > /proc/sys/kernel/ftrace_enabled
> > +		echo 1 > /proc/sys/kernel/ftrace_enabled
> > +	}
> > +
> > +	enable=$(( $count % 3 ))
> > +
> > +	if [ $enable -eq 0 ]; then
> > +		echo 1 > /proc/sys/kernel/ftrace_enabled
> > +	else
> > +		echo 0 > /proc/sys/kernel/ftrace_enabled
> > +	fi
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
> > new file mode 100755
> > index 0000000..9c6162a
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
> > @@ -0,0 +1,50 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +MAX_LOOP=1500
> > +count=0
> > +
> > +if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
> > +	should_skip=1
> > +else
> > +	should_skip=0
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +	if [ $should_skip -eq 1 ]; then
> > +		sleep 2
> > +		continue
> > +	fi
> > +
> > +	count=$(( $count + 1 ))
> > +
> > +	for ((i = 0; i < $MAX_LOOP; i++))
> > +	{
> > +		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> > +		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> > +	}
> > +
> > +	enable=$(( $count % 3 ))
> > +
> > +	if [ $enable -eq 0 ]; then
> > +		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> > +	else
> > +		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
> > +	fi
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
> > new file mode 100755
> > index 0000000..d7efdd4
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
> > @@ -0,0 +1,44 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +for ((; ;))
> > +{
> > +	for ((i = 0; i < 100; i++))
> > +	{
> > +		echo 1 > "$TRACING_PATH"/events/enable
> > +		echo 0 > "$TRACING_PATH"/events/enable
> > +	}
> > +
> > +	for dir in `ls $TRACING_PATH/events/`
> > +	do
> > +		if [ ! -d $dir -o "$dir" = ftrace ]; then
> > +			continue;
> > +		fi
> > +
> > +		for ((i = 0; i < 20; i++))
> > +		{
> > +			echo 1 > "$TRACING_PATH"/events/$dir/enable
> > +			echo 0 > "$TRACING_PATH"/events/$dir/enable
> > +		}
> > +	done
> > +
> > +	for event in `cat $TRACING_PATH/available_events`;
> > +	do
> > +		echo $event >> "$TRACING_PATH"/set_event
> > +	done
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> > new file mode 100755
> > index 0000000..541215c
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> > @@ -0,0 +1,44 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=300
> > +
> > +if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
> > +	should_skip=1
> > +else
> > +	should_skip=0
> > +fi
> > +
> > +for ((; ; ))
> > +{
> > +	if [ $should_skip -eq 1 ]; then
> > +		sleep 2
> > +		continue
> > +	fi
> > +
> > +	for ((j = 0; j < $LOOP; j++))
> > +	{
> > +		for ((k = 1; k <= NR_PIDS; k++))
> > +		{
> > +			str="\$pid$k"
> > +			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
> > +		}
> > +
> > +		echo > "$TRACING_PATH"/set_ftrace_pid
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
> > new file mode 100755
> > index 0000000..682d05e
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
> > @@ -0,0 +1,39 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +MAX_STACK_SIZE=8192
> > +
> > +if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> > +	should_skip=1
> > +else
> > +	should_skip=0
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +	if [ $should_skip -eq 1 ]; then
> > +		sleep 2
> > +		continue
> > +	fi
> > +
> > +	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
> > +	{
> > +		echo $i > "$TRACING_PATH"/stack_max_size
> > +		cat "$TRACING_PATH"/stack_max_size > /dev/null
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
> > new file mode 100755
> > index 0000000..a406c51
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
> > @@ -0,0 +1,46 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=400
> > +
> > +if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> > +	should_skip=1
> > +else
> > +	should_skip=0
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +	if [ $should_skip -eq 1 ]; then
> > +		sleep 2
> > +		continue
> > +	fi
> > +
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		cat "$TRACING_PATH"/stack_trace > /dev/null
> > +	}
> > +
> > +	sleep 1
> > +
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		echo 0 > /proc/sys/kernel/stack_tracer_enabled
> > +		echo 1 > /proc/sys/kernel/stack_tracer_enabled
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
> > new file mode 100755
> > index 0000000..e36712b
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
> > @@ -0,0 +1,27 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=200
> > +
> > +for ((; ;))
> > +{
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		cat "$TRACING_PATH"/trace > /dev/null
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
> > new file mode 100755
> > index 0000000..de6bbea
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
> > @@ -0,0 +1,46 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=400
> > +
> > +# In kernel which is older than 2.6.32, we set global clock
> > +# via trace_options.
> > +tst_kvercmp 2 6 32
> > +if [ $? -eq 0 ]; then
> > +        old_kernel=1
> > +else
> > +        old_kernel=0
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +	if [ $old_kernel -eq 1 ];
> > +	then
> > +		for ((i = 0; i < $LOOP; i++))
> > +		{
> > +			echo 1 > "$TRACING_PATH"/options/global-clock
> > +			echo 0 > "$TRACING_PATH"/options/global-clock
> > +		}
> > +	else
> > +		for ((i = 0; i < $LOOP; i++))
> > +		{
> > +			echo local > "$TRACING_PATH"/trace_clock
> > +			echo global > "$TRACING_PATH"/trace_clock
> > +		}
> > +	fi
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
> > new file mode 100755
> > index 0000000..47d2a62
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
> > @@ -0,0 +1,42 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=200
> > +
> > +trace_options=(print-parent sym-offset sym-addr verbose raw hex bin block trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj printk-msg-only context-info latency-format sleep-time graph-time)
> > +
> > +NR_TRACE_OPTIONS=19
> > +
> > +for ((; ; ))
> > +{
> > +	for ((j = 0; j < $LOOP; j++))
> > +	{
> > +		num=`date +%N`
> > +		num=`printf 1%s $num`
> > +
> > +		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
> > +		{
> > +			n=$(( ( $num >> $i ) % 2 ))
> > +			if [ $n -eq 0 ]; then
> > +				echo 0 > "$TRACING_PATH"/options/${trace_options[$i]}
> > +			else
> > +				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
> > +			fi
> > +		}
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
> > new file mode 100755
> > index 0000000..47d42bc
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
> > @@ -0,0 +1,52 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +ftrace_sleep()
> > +{
> > +	# usleep is not a standard command?
> > +	usleep 200000 2> /dev/null
> > +	if [ $? -ne 0 ]; then
> > +		sleep 1
> > +	fi
> > +}
> > +
> > +kill_this_pid()
> > +{
> > +	/bin/kill -SIGKILL $this_pid
> > +	wait $this_pid
> > +	exit 0
> > +}
> > +
> > +trap kill_this_pid SIGUSR1
> > +
> > +LOOP=20
> > +
> > +for ((; ;))
> > +{
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		cat "$TRACING_PATH"/trace_pipe > /dev/null &
> > +
> > +		this_pid=$!
> > +		ftrace_sleep
> > +		/bin/kill -SIGINT $this_pid
> > +		wait $this_pid
> > +		this_pid=0
> > +		ftrace_sleep
> > +	}
> > +
> > +	sleep 2
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
> > new file mode 100755
> > index 0000000..cb601db
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
> > @@ -0,0 +1,45 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +LOOP=200
> > +
> > +should_skip=0
> > +
> > +if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
> > +        should_skip=1
> > +fi
> > +
> > +# For kernels older than 2.6.36, this testcase can result in 
> > +# divide-by-zero kernel bug
> > +tst_kvercmp 2 6 36
> > +if [ $? -eq 0 ]; then
> > +	should_skip=1
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +	if [ $should_skip -eq 1 ]; then
> > +		sleep 2
> > +		continue
> > +	fi
> > +
> > +	for ((i = 0; i < $LOOP; i++))
> > +	{
> > +		cat "$TRACING_PATH"/trace_stat/function0 > /dev/null 2>&1
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
> > new file mode 100755
> > index 0000000..69f2ae6
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
> > @@ -0,0 +1,39 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +MAX_LOOP=1500
> > +count=0
> > +
> > +for ((; ;))
> > +{
> > +	count=$(( $count + 1 ))
> > +
> > +	for ((i = 0; i < $MAX_LOOP; i++))
> > +	{
> > +		echo 0 > "$TRACING_PATH"/tracing_enabled
> > +		echo 1 > "$TRACING_PATH"/tracing_enabled
> > +	}
> > +
> > +	enable=$(( $count % 3 ))
> > +
> > +	if [ $enable -eq 0 ]; then
> > +		echo 0 > "$TRACING_PATH"/tracing_enabled
> > +	else
> > +		echo 1 > "$TRACING_PATH"/tracing_enabled
> > +	fi
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
> > new file mode 100755
> > index 0000000..f19d734
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
> > @@ -0,0 +1,38 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +MAX_LATENCY=100000
> > +
> > +if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
> > +        should_skip=1
> > +else
> > +        should_skip=0
> > +fi
> > +
> > +for ((; ;))
> > +{
> > +        if [ $should_skip -eq 1 ]; then
> > +                sleep 2
> > +                continue
> > +        fi
> > +
> > +	for ((i = 0; i < $MAX_LATENCY; i += 400))
> > +	{
> > +		echo $i > "$TRACING_PATH"/tracing_max_latency
> > +	}
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
> > new file mode 100755
> > index 0000000..672c223
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
> > @@ -0,0 +1,39 @@
> > +#! /bin/sh
> > +
> > +###############################################################################
> > +#                                                                             #
> > +# Copyright (c) 2010 FUJITSU LIMITED                                          #
> > +#                                                                             #
> > +# This program is free software; you can redistribute it and/or modify it     #
> > +# under the terms of the GNU General Public License as published by the Free  #
> > +# Software Foundation; either version 2 of the License, or (at your option)   #
> > +# any later version.                                                          #
> > +#                                                                             #
> > +# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
> > +#                                                                             #
> > +###############################################################################
> > +
> > +MAX_LOOP=1500
> > +count=0
> > +
> > +for ((; ;))
> > +{
> > +	count=$(( $count + 1 ))
> > +
> > +	for ((i = 0; i < $MAX_LOOP; i++))
> > +	{
> > +		echo 0 > "$TRACING_PATH"/tracing_on
> > +		echo 1 > "$TRACING_PATH"/tracing_on
> > +	}
> > +
> > +	enable=$(( $count % 3 ))
> > +
> > +	if [ $enable -eq 0 ]; then
> > +		echo 0 > "$TRACING_PATH"/tracing_on
> > +	else
> > +		echo 1 > "$TRACING_PATH"/tracing_on
> > +	fi
> > +
> > +	sleep 1
> > +}
> > +
> > diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> > new file mode 100755
> > index 0000000..874268e
> > --- /dev/null
> > +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> > @@ -0,0 +1,237 @@
> > +#! /bin/sh
> > +
> > +################################################################################
> > +##                                                                            ##
> > +## Copyright (c) 2010 FUJITSU LIMITED                                         ##
> > +##                                                                            ##
> > +## This program is free software;  you can redistribute it and#or modify      ##
> > +## it under the terms of the GNU General Public License as published by       ##
> > +## the Free Software Foundation; either version 2 of the License, or          ##
> > +## (at your option) any later version.                                        ##
> > +##                                                                            ##
> > +## This program is distributed in the hope that it will be useful, but        ##
> > +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> > +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> > +## for more details.                                                          ##
> > +##                                                                            ##
> > +## You should have received a copy of the GNU General Public License          ##
> > +## along with this program;  if not, write to the Free Software               ##
> > +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> > +##                                                                            ##
> > +## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
> > +##                                                                            ##
> > +################################################################################
> > +
> > +cd $LTPROOT/testcases/bin
> > +
> > +export TCID="ftrace-stress-test"
> > +export TST_TOTAL=1
> > +export TST_COUNT=1
> > +
> > +export TPATH="$PWD"
> > +export DEBUGFS_PATH="$PWD/debugfs"
> > +export TRACING_PATH="$PWD/debugfs/tracing"
> > +export SPATH="$TPATH/ftrace_stress"
> > +
> > +test_interval=$1
> > +
> > +save_old_setting()
> > +{
> > +	cd $TRACING_PATH
> > +
> > +	old_trace_options=( `cat trace_options` )
> > +	old_tracing_on=`cat tracing_on`
> > +	old_tracing_enabled=`cat tracing_enabled`
> > +	old_buffer_size=`cat buffer_size_kb`
> > +
> > +	if [ -e stack_max_size ]; then
> > +		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
> > +	fi
> > +
> > +	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> > +		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
> > +	fi
> > +
> > +	if [ -e "function_profile_enabled" ]; then
> > +		old_profile_enabled=`cat function_profile_enabled`
> > +	fi
> > +
> > +	cd - > /dev/null
> > +}
> > +
> > +restore_old_setting()
> > +{
> > +	cd $TRACING_PATH
> > +
> > +	echo nop > current_tracer
> > +	echo 0 > events/enable
> > +	echo 0 > tracing_max_latency 2> /dev/null
> > +
> > +	if [ -e trace_clock ]; then
> > +		echo local > trace_clock
> > +	fi
> > +
> > +	if [ -e "function_pofile_enabled" ]; then
> > +		echo $old_profile_enabled > function_profile_enabled
> > +	fi
> > +
> > +	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> > +		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
> > +	fi
> > +
> > +	if [ -e stack_max_size ]; then
> > +		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
> > +		echo 0 > stack_max_size
> > +	fi
> > +
> > +	echo $old_buffer_size > buffer_size_kb
> > +	echo $old_tracing_on > tracing_on
> > +	echo $old_tracing_enabled > tracing_enabled
> > +
> > +	for option in $old_trace_options
> > +	do
> > +		echo $option > trace_options 2> /dev/null
> > +	done
> > +
> > +	echo > trace
> > +
> > +	cd - > /dev/null
> > +}
> > +
> > +clean_up()
> > +{
> > +	kill -KILL $pid1
> > +	kill -KILL $pid2
> > +	kill -KILL $pid3
> > +	kill -KILL $pid4
> > +	kill -KILL $pid5
> > +	kill -KILL $pid6
> > +	kill -KILL $pid7
> > +	kill -KILL $pid8
> > +	kill -KILL $pid9
> > +	kill -KILL $pid10
> > +	kill -KILL $pid11
> > +	kill -USR1 $pid12
> > +	kill -KILL $pid13
> > +	kill -KILL $pid14
> > +	kill -KILL $pid15
> > +	kill -KILL $pid16
> > +
> > +	sleep 2
> > +	restore_old_setting
> > +
> > +	umount $DEBUGFS_PATH
> > +	rmdir $DEBUGFS_PATH
> > +}
> > +
> > +clean_up_exit()
> > +{
> > +	clean_up
> > +	exit 1
> > +}
> > +
> > +export_pids()
> > +{
> > +	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
> > +		pid13 pid14 pid15 pid16
> > +
> > +	export NR_PIDS=16
> > +}
> > +
> > +test_begin()
> > +{
> > +	start_time=`date +%s`
> > +}
> > +
> > +test_wait()
> > +{
> > +	for ((; ;))
> > +	{
> > +		sleep 2
> > +
> > +		cur_time=`date +%s`
> > +		elapsed=$(( $cur_time - $start_time ))
> > +
> > +		# run the stress test for $test_interval secs
> > +		if [ $elapsed -ge $test_interval ]; then
> > +			break
> > +		fi
> > +	}
> > +}
> > +
> > +trap clean_up_exit SIGINT
> > +
> > +# Should be run by root user
> > +if [ `id -ru` != 0 ]; then
> > +	tst_brkm TCONF ignored "The test should be run by root user. Skip the test..."
> > +	exit 0
> > +fi
> > +
> > +# Don't run the test on kernels older than 2.6.34, otherwise
> > +# it can crash the system if the kernel is not latest-stable
> > +tst_kvercmp 2 6 34
> > +if [ $? -eq 0 ]; then
> > +	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
> > +	exit 0
> > +fi
> > +
> > +mkdir $DEBUGFS_PATH
> > +mount -t debugfs xxx $DEBUGFS_PATH
> > +
> > +# Check to see tracing feature is supported or not
> > +if [ ! -d $TRACING_PATH ]; then
> > +	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
> > +	umount $DEBUGFS_PATH
> > +	rmdir $DEBUGFS_PATH
> > +	exit 0
> > +fi
> > +
> > +echo "Ftrace Stress Test Begin"
> > +
> > +save_old_setting
> > +
> > +test_begin
> > +
> > +$SPATH/ftrace_trace_clock.sh &
> > +pid1=$!
> > +$SPATH/ftrace_current_tracer.sh &
> > +pid2=$!
> > +$SPATH/ftrace_trace_options.sh &
> > +pid3=$!
> > +$SPATH/ftrace_tracing_max_latency.sh &
> > +pid4=$!
> > +$SPATH/ftrace_stack_trace.sh &
> > +pid5=$!
> > +$SPATH/ftrace_stack_max_size.sh &
> > +pid6=$!
> > +$SPATH/ftrace_tracing_on.sh &
> > +pid7=$!
> > +$SPATH/ftrace_tracing_enabled.sh &
> > +pid8=$!
> > +$SPATH/ftrace_set_event.sh &
> > +pid9=$!
> > +$SPATH/ftrace_buffer_size.sh &
> > +pid10=$!
> > +$SPATH/ftrace_trace.sh &
> > +pid11=$!
> > +$SPATH/ftrace_trace_pipe.sh &
> > +pid12=$!
> > +$SPATH/ftrace_ftrace_enabled.sh &
> > +pid13=$!
> > +$SPATH/ftrace_set_ftrace_pid.sh &
> > +pid14=$!
> > +$SPATH/ftrace_profile_enabled.sh &
> > +pid15=$!
> > +$SPATH/ftrace_trace_stat.sh &
> > +pid16=$!
> > +
> > +export_pids
> > +
> > +test_wait
> > +
> > +clean_up
> > +
> > +echo "Ftrace Stress Test End"
> > +
> > +tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
> > +
> > -- 
> > 1.6.3
> > 
> > ------------------------------------------------------------------------------
> > This SF.net Dev2Dev email is sponsored by:
> > 
> > Show off your parallel programming skills.
> > Enter the Intel(R) Threading Challenge 2010.
> > http://p.sf.net/sfu/intel-thread-sfd
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
