From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 13 Jul 2017 13:27:08 +0200
Subject: [LTP] Testcase oom01 cause RT kernel hang-up
In-Reply-To: <2B18E8E1DDAE074A82D1060396451DAE263CAF1D@CNMAILEX04.lenovo.com>
References: <2B18E8E1DDAE074A82D1060396451DAE263CAF1D@CNMAILEX04.lenovo.com>
Message-ID: <87k23cinlf.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Feng Feng24 Liu writes:

> Dear experts
> 	I run ltp-full-20170516 on my server . My kernel is RT kernel 4.4.70-rt83.
> 	I use " ./runltp " to run the test suite,  and when run test case oom01, it will cause server hang-up.
> 	It could be repeat .
> 	But when I run oom01 on normal kernel (non-RT), it will run smoothly.
> 	I do not know if LTP is not suitable for real-time kernel or there is a BUG?!
>

Thanks for reporting the failure! Maybe the following is significant as
it does not appear to be part of an OOM killer invocation.

> [597608.291337] ------------[ cut here ]------------
> [597608.296909] WARNING: CPU: 0 PID: 5783 at kernel/workqueue.c:926 wq_worker_sleeping+0x5f/0x70()
> [597608.307097] Modules linked in: sctp rds xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ipt_REJECT xt_tcpudp ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter intel_rapl iosf_mbi intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 glue_helper lrw ablk_helper cryptd ipmi_devintf input_leds joydev led_class ipmi_si mxm_wmi ipmi_msghandler acpi_pad ioatdma sb_edac acpi_power_meter dca mei_me lpc_ich mfd_core shpchp edac_core mei tpm_tis wmi ip_tables x_tables megaraid_sas
> [597608.373301] CPU: 0 PID: 5783 Comm: kworker/0:2 Not tainted 4.4.70-thinkcloud-nfv #1
> [597608.373301] Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
> [597608.373305] Workqueue: kacpid acpi_os_execute_deferred
> [597608.373323]  0000000000000000 ffff8810319fb380 ffffffff814093de 0000000000000000
> [597608.373324]  ffffffff81c99393 ffff8810319fb3b8 ffffffff810615d6 ffff882010f47470
> [597608.373325]  ffff8810345a0000 ffff8810345a0000 0000000000000282 ffff881efa467530
> [597608.373325] Call Trace:
> [597608.373330]  [<ffffffff814093de>] dump_stack+0x65/0x87
> [597608.373334]  [<ffffffff810615d6>] warn_slowpath_common+0x86/0xe0
> [597608.373335]  [<ffffffff810616ea>] warn_slowpath_null+0x1a/0x30
> [597608.373336]  [<ffffffff8107b46f>] wq_worker_sleeping+0x5f/0x70
> [597608.373340]  [<ffffffff81a8d39e>] schedule+0x8e/0xe0
> [597608.373341]  [<ffffffff81a8f117>] rt_spin_lock_slowlock+0x217/0x390
> [597608.373343]  [<ffffffff81a903bf>] rt_spin_lock+0x1f/0x30
> [597608.373344]  [<ffffffff813e9336>] blk_flush_plug_list+0x176/0x1f0
> [597608.373346]  [<ffffffff81a8d3c5>] schedule+0xb5/0xe0
> [597608.373347]  [<ffffffff81a8f638>] schedule_timeout+0x148/0x330
> [597608.373349]  [<ffffffff810a2d88>] ? __try_to_take_rt_mutex+0x108/0x160
> [597608.373353]  [<ffffffff810c3460>] ? trace_event_raw_event_tick_stop+0xd0/0xd0
> [597608.373355]  [<ffffffff810856e3>] ? preempt_count_add+0xa3/0xc0
> [597608.373356]  [<ffffffff81a8f87e>] schedule_timeout_uninterruptible+0x1e/0x20
> [597608.373359]  [<ffffffff81168ac3>] wait_iff_congested+0xd3/0x190
> [597608.373362]  [<ffffffff810a0260>] ? prepare_to_wait_event+0xf0/0xf0
> [597608.373365]  [<ffffffff8115df1c>] shrink_inactive_list+0x4ac/0x5d0
> [597608.373367]  [<ffffffff8115e949>] shrink_lruvec+0x559/0x740
> [597608.373369]  [<ffffffff8115ec0d>] shrink_zone+0xdd/0x280
> [597608.373370]  [<ffffffff8115f10f>] do_try_to_free_pages+0x14f/0x430
> [597608.373372]  [<ffffffff8115f4aa>] try_to_free_pages+0xba/0x1f0
> [597608.373375]  [<ffffffff81151dc6>] __alloc_pages_nodemask+0x556/0xaf0
> [597608.373378]  [<ffffffff811944cd>] alloc_pages_current+0x8d/0x120
> [597608.373380]  [<ffffffff81199540>] new_slab+0x2b0/0x380
> [597608.373382]  [<ffffffff8119c01d>] ___slab_alloc+0x3bd/0x530
> [597608.373385]  [<ffffffff81497c0e>] ? acpi_ut_create_generic_state+0x39/0x44
> [597608.373388]  [<ffffffff81424eb7>] ? debug_smp_processor_id+0x17/0x20
> [597608.373390]  [<ffffffff810620a6>] ? unpin_current_cpu+0x16/0x70
> [597608.373392]  [<ffffffff811aa97a>] __slab_alloc.isra.73+0x6c/0x93
> [597608.373393]  [<ffffffff81497c0e>] ? acpi_ut_create_generic_state+0x39/0x44
> [597608.373394]  [<ffffffff81497c0e>] ? acpi_ut_create_generic_state+0x39/0x44
> [597608.373396]  [<ffffffff8119d617>] kmem_cache_alloc+0xc7/0x190
> [597608.373397]  [<ffffffff81490721>] ? acpi_os_acquire_object+0x2d/0x2f
> [597608.373398]  [<ffffffff81497c0e>] acpi_ut_create_generic_state+0x39/0x44
> [597608.373401]  [<ffffffff814904b1>] acpi_ps_push_scope+0x23/0x7b
> [597608.373403]  [<ffffffff8148f3d2>] acpi_ps_parse_loop+0x19d/0x56c
> [597608.373404]  [<ffffffff81490212>] acpi_ps_parse_aml+0x98/0x289
> [597608.373405]  [<ffffffff81490a8d>] acpi_ps_execute_method+0x152/0x193
> [597608.373407]  [<ffffffff8148b2b4>] acpi_ns_evaluate+0x1c1/0x259
> [597608.373409]  [<ffffffff8147f111>] acpi_ev_asynch_execute_gpe_method+0xa0/0x107
> [597608.373410]  [<ffffffff81469134>] acpi_os_execute_deferred+0x14/0x20
> [597608.373411]  [<ffffffff8107a8f1>] process_one_work+0x151/0x480
> [597608.373413]  [<ffffffff8107ad6b>] worker_thread+0x14b/0x4c0
> [597608.373414]  [<ffffffff8107ac20>] ? process_one_work+0x480/0x480
> [597608.373415]  [<ffffffff81080366>] kthread+0xd6/0xf0
> [597608.373417]  [<ffffffff81080290>] ? kthread_worker_fn+0x160/0x160
> [597608.373418]  [<ffffffff81a90bcf>] ret_from_fork+0x3f/0x70
> [597608.373419]  [<ffffffff81080290>] ? kthread_worker_fn+0x160/0x160
> [597608.373420] ---[ end trace 0000000000000002 ]---

Looking at workqueue.c in 4.11 this might indicate that the kernel is trying to
perform a sleep/wakeup action on a different CPU/core than the one which
the task is assigned to. Which is probably bad because it prints a
warning message.

The LTP OOM test is just a userland process which uses up all the memory
with various different overcommit_memory settings, including
overcommit_memory=1 which is not recommended. It is known to cause
problems on a normal kernel also, even in 4.11, although you may find
the test passes OK for you.

You should probably report this to one of the kernel mailing lists
(maybe mm and rt). It might also be useful to see the LTP oom1 log
output.

--
Thank you,
Richard.
