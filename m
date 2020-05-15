From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 15 May 2020 14:27:00 +0100
Subject: [LTP] [PATCH] pty04: Avoid receiving packets from all interfaces
In-Reply-To: <1899128312.12583700.1589546227679.JavaMail.zimbra@redhat.com>
References: <20200515103910.8703-1-rpalethorpe@suse.com>
 <20200515114837.GB3395@yuki.lan>
 <914267680.12582166.1589545134812.JavaMail.zimbra@redhat.com>
 <1899128312.12583700.1589546227679.JavaMail.zimbra@redhat.com>
Message-ID: <87y2ptqqfv.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> ----- Original Message -----
>> 
>> 
>> ----- Original Message -----
>> > Hi!
>> > Sounds reasonable, also hope it's the last patch. :-)
>> > 
>> > @Jan do you want to test this as well, or should I apply and proceed
>> > with the release?
>> 
>> I haven't spotted potential issue while looking at kernel code,
>> will test the patch just to be sure.
>
> It still gets occasionally stuck on 5.7.0-rc4, but the chance to hit
> it appears lower. I think merge the patch and we'll see how frequently
> it happens with single iteration. We can always disable it later in
> runtest file.
>
> # ./pty04 -i 10
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> pty04.c:130: INFO: PTS path is /dev/pts/2
> pty04.c:207: INFO: Netdev is sl0
> pty04.c:216: INFO: Netdev MTU is 8192 (we set 8192)
> pty04.c:233: INFO: Bound netdev 245 to socket 5
> tst_buffers.c:55: INFO: Test is using guarded buffers
> pty04.c:324: INFO: Reading from socket 5
> tst_buffers.c:55: INFO: Test is using guarded buffers
> pty04.c:180: PASS: Wrote PTY N_SLIP 3 (1)
> pty04.c:191: PASS: Wrote PTY N_SLIP 3 (2)
> pty04.c:328: PASS: Read netdev N_SLIP 5 (1)
>
>
> tst_checkpoint.c:149: BROK: pty04.c:364: tst_checkpoint_wait(0, 100000): ETIMEDOUT (110)
> tst_test.c:373: BROK: Reported by child (2990)
> pty04.c:306: BROK: Read 0 of 8191 bytes: ENETDOWN (100)
> pty04.c:196: PASS: Writing to PTY interrupted by hangup
> tst_test.c:373: WARN: Reported by child (2987)

Thanks for testing. I guess if the timeout is set long enough and you
have RCU stall detection enabled(?) or SLUB debug, then you will get
some stack trace. Probably related to memory allocation.

I tried again running it in parallel and still got the following stack
traces, but the system is able to recover afterwards. It seems like the
PTYs and line disciplines are a bit fragile. Which I suspect could be
fixed by using different memory pools , but I'm not sure it is very
important.

[   58.454313] rcu: INFO: rcu_sched self-detected stall on CPU
[   58.455115] rcu: 	2-....: (26000 ticks this GP) idle=bea/1/0x4000000000000002 softirq=2439/2439 fqs
[   58.456405] 	(t=26003 jiffies g=4233 q=26)
[   58.456949] NMI backtrace for cpu 2
[   58.457405] CPU: 2 PID: 280 Comm: kworker/u8:6 Not tainted 5.7.0-rc4+ #49
[   58.458286] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt4
[   58.459766] Workqueue: events_unbound flush_to_ldisc
[   58.460438] Call Trace:
[   58.460777]  <IRQ>
[   58.461063]  dump_stack+0x97/0xe0
[   58.461518]  nmi_cpu_backtrace.cold+0x46/0x80
[   58.462103]  ? lapic_can_unplug_cpu.cold+0x46/0x46
[   58.462741]  nmi_trigger_cpumask_backtrace+0x125/0x154
[   58.463438]  rcu_dump_cpu_stacks+0x1a0/0x1ea
[   58.464041]  rcu_sched_clock_irq.cold+0x518/0x978
[   58.464683]  update_process_times+0x24/0x50
[   58.465248]  tick_sched_handle+0xf7/0x160
[   58.465792]  tick_sched_timer+0x38/0xf0
[   58.466315]  __hrtimer_run_queues+0x4ae/0xa90
[   58.466902]  ? tick_sched_do_timer+0x150/0x150
[   58.467523]  ? enqueue_hrtimer+0x2d0/0x2d0
[   58.468092]  hrtimer_interrupt+0x2bf/0x740
[   58.468668]  smp_apic_timer_interrupt+0x109/0x4e0
[   58.469303]  apic_timer_interrupt+0xf/0x20
[   58.469852]  </IRQ>
[   58.470150] RIP: 0010:enqueue_to_backlog+0x156/0xb40
[   58.470821] Code: 74 08 3c 03 0f 8e 90 05 00 00 83 83 30 01 00 00 01 4c 89 ef e8 5b f4 7a 00 41 f7 c4 f
[   58.473235] RSP: 0018:ffffc900005479b0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[   58.474225] RAX: 0000000000000007 RBX: ffff88806b535d80 RCX: 1ffffffff1e2bffa
[   58.475155] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8d42ee73
[   58.476090] RBP: ffff888048188c80 R08: 0000000000000001 R09: ffffed100d6a6bdb
[   58.477068] R10: ffff88806b535ed3 R11: ffffed100d6a6bda R12: 0000000000000282
[   58.478003] R13: ffff88806b535ed0 R14: ffff888048188c90 R15: 00000000000003e9
[   58.479059]  ? enqueue_to_backlog+0x153/0xb40
[   58.479674]  netif_rx_internal+0xc6/0x450
[   58.480265]  ? enqueue_to_backlog+0xb40/0xb40
[   58.480985]  netif_rx_ni+0x4b/0x3a0
[   58.481545]  slcan_receive_buf+0x970/0xbb0 [slcan]
[   58.482295]  ? slcan_transmit+0x3e0/0x3e0 [slcan]
[   58.483047]  ? slcan_transmit+0x3e0/0x3e0 [slcan]
[   58.483793]  ? slcan_transmit+0x3e0/0x3e0 [slcan]
[   58.484544]  tty_ldisc_receive_buf+0x100/0x1d0
[   58.485246]  ? tty_ldisc_receive_buf+0x5/0x1d0
[   58.485970]  tty_port_default_receive_buf+0x61/0x90
[   58.486576]  flush_to_ldisc+0x1a7/0x3e0
[   58.487046]  process_one_work+0x926/0x16d0
[   58.487550]  ? pwq_dec_nr_in_flight+0x290/0x290
[   58.488077]  ? ftrace_graph_caller+0x6b/0xa0
[   58.488584]  ? rwlock_bug.part.0+0x90/0x90
[   58.489081]  worker_thread+0x92/0xfa0
[   58.489535]  ? process_one_work+0x16d0/0x16d0
[   58.490048]  kthread+0x2ba/0x3b0
[   58.490433]  ? kthread_create_on_node+0xd0/0xd0
[   58.490966]  ret_from_fork+0x3a/0x50
[   59.114357] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 2-... } 26468 jiffies s: 2.
[   59.115656] rcu: blocking rcu_node structures:
[   59.116176] Task dump for CPU 2:
[   59.116580] kworker/u8:6    R  running task    28768   280      2 0x80004008
[   59.117488] Workqueue: events_unbound flush_to_ldisc
[   59.118068] Call Trace:
[   59.118409]  ? pwq_dec_nr_in_flight+0x290/0x290
[   59.118936]  ? ftrace_graph_caller+0x6b/0xa0
[   59.119476]  ? rwlock_bug.part.0+0x90/0x90
[   59.119976]  ? worker_thread+0x92/0xfa0
[   59.120472]  ? process_one_work+0x16d0/0x16d0
[   59.120987]  ? kthread+0x2ba/0x3b0
[   59.121415]  ? kthread_create_on_node+0xd0/0xd0
[   59.121948]  ? ret_from_fork+0x3a/0x50
[   63.805607] warn_alloc: 1915 callbacks suppressed

[   26.819715] reproducer: page allocation failure: order:1, mode:0x40a20(GFP_ATOMIC|__GFP_COMP), nodemas0
[   26.820140] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.821191] CPU: 1 PID: 456 Comm: reproducer Not tainted 5.7.0-rc4+ #49
[   26.822013]   cache: skbuff_head_cache, object size: 224, buffer size: 320, default order: 1, min orde0
[   26.822583] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.822590]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.822596]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.822604]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.822712] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.822719]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.822724]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.822732]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.822760] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.822767]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.822772]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.822780]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.822807] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt4
[   26.822813] Call Trace:
[   26.822818] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.822823]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.822828]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.822834]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.822870] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.822876]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.822882]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.822890]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.822932] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.822939]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.822946]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.822953]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.822995] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.823002]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.823007]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.823015]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.823057] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.823064]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.823069]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.823076]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.823116] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
[   26.823121]   cache: kmalloc-4k, object size: 4096, buffer size: 8192, default order: 3, min order: 1
[   26.823128]   kmalloc-4k debugging increased min order, use slub_debug=O to disable.
[   26.823134]   node 0: slabs: 44294, objs: 177164, free: 0
[   26.824222]   node 0: slabs: 12353, objs: 308825, free: 0
[   26.825031]  dump_stack+0x97/0xe0
[   26.859539]  warn_alloc.cold+0x87/0x18d
pty04.c:328:    26.860015]  ? zone_watermark_ok_safe+0x270/0x270
;32mPASS: Re[   26.860709]  ? zone_watermark_ok_safe+0x270/0x270
ad netdev N_SLCA[   26.861611]  ? __alloc_pages_slowpath.constprop.0+0x1cf3/0x2180
N 26 (1)[   26.862395]  ? prepare_ftrace_return+0xa1/0xf0

[   26.863008]  ? wakeup_kcompactd+0x18a/0x3e0
[   26.863526]  ? __isolate_free_page+0x4e0/0x4e0
[   26.864070]  __alloc_pages_slowpath.constprop.0+0x1cf3/0x2180
[   26.864739]  ? get_page_from_freelist+0x753/0x3920
pty04.c:332:    26.865300]  ? __isolate_free_page+0x4e0/0x4e0
;32mPASS: Re[   26.865989]  ? __alloc_pages_nodemask+0x277/0x6e0
ad netdev N_SLCA[   26.866675]  ? warn_alloc+0x120/0x120
N 26 (2)
[   26.867260]  ? ftrace_graph_caller+0x6b/0xa0
[   26.867867]  ? function_graph_enter+0x34b/0x520
[   26.868396]  ? __isolate_free_page+0x4e0/0x4e0
[   26.868914]  ? ftrace_graph_stop+0x10/0x10
[   26.869409]  __alloc_pages_nodemask+0x517/0x6e0
[   26.869942]  ? __alloc_pages_slowpath.constprop.0+0x2180/0x2180
[   26.870618]  ? ftrace_graph_caller+0x6b/0xa0
[   26.871141]  new_slab+0x28b/0x340
[   26.871547]  ___slab_alloc+0x370/0x5d0
[   26.871995]  ? __tty_buffer_request_room+0x1c0/0x560
[   26.872577]  ? __tty_buffer_request_room+0x1c0/0x560
[   26.873150]  ? ftrace_graph_caller+0x6b/0xa0
[   26.873645]  ? prepare_ftrace_return+0xa1/0xf0
[   26.874172]  ? __tty_buffer_request_room+0x1c0/0x560
[   26.874747]  ? __slab_alloc+0x38/0x70
[   26.875176]  __slab_alloc+0x38/0x70
[   26.875648]  ? __tty_buffer_request_room+0x1c0/0x560
[   26.876403]  __kmalloc+0x25e/0x2c0
[   26.876814]  __tty_buffer_request_room+0x1c0/0x560
[   26.877380]  tty_insert_flip_string_fixed_flag+0x7d/0x1f0
[   26.878181]  pty_write+0x103/0x1d0
[   26.878684]  n_tty_write+0x753/0xf90
[   26.879108]  ? ftrace_graph_stop+0x10/0x10
[   26.879585]  ? n_tty_read+0x16e0/0x16e0
[   26.880053]  ? tty_write+0x3c0/0x700
[   26.880472]  ? prepare_ftrace_return+0xa1/0xf0
[   26.880989]  ? n_tty_read+0x16e0/0x16e0
[   26.881435]  ? ftrace_graph_caller+0x6b/0xa0
[   26.881934]  ? prepare_to_wait_exclusive+0x200/0x200
[   26.882509]  ? n_tty_read+0x16e0/0x16e0
[   26.882973]  tty_write+0x3c0/0x700
[   26.883379]  ? n_tty_read+0x16e0/0x16e0
[   26.883857]  vfs_write+0x154/0x450
[   26.884324]  ksys_write+0xf9/0x1d0
[   26.884783]  ? __ia32_sys_read+0xb0/0xb0
[   26.885324]  do_syscall_64+0x95/0x4a0
[   26.885819]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   26.886485] RIP: 0033:0x7f56ae533563
[   26.886961] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 64 8b 04 25 18 8
[   26.889355] RSP: 002b:00007ffc3026c138 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   26.890335] RAX: ffffffffffffffda RBX: 0000000000422600 RCX: 00007f56ae533563
[   26.891258] RDX: 0000000000002000 RSI: 00007f56ae42a000 RDI: 0000000000000015
[   26.892206] RBP: 00007f56ae60a580 R08: 0000000000000000 R09: 00007ffc3026ba80
[   26.893231] R10: 00000000000003cb R11: 0000000000000246 R12: 0000000000002000
[   26.894077] R13: 00007f56ae42a000 R14: 0000000000000015 R15: 0000000000000001
[   26.895141] Mem-Info:
[   26.895441] active_anon:3997 inactive_anon:4284 isolated_anon:0
[   26.895441]  active_file:0 inactive_file:0 isolated_file:0
[   26.895441]  unevictable:0 dirty:0 writeback:0 unstable:0
[   26.895441]  slab_reclaimable:4267 slab_unreclaimable:385849
[   26.895441]  mapped:913 shmem:7230 pagetables:205 bounce:0
[   26.895441]  free:5770 free_pcp:737 free_cma:0
[   26.899022] Node 0 active_anon:15988kB inactive_anon:17136kB active_file:0kB inactive_file:0kB unevicts
[   26.902008] Node 0 DMA free:6340kB min:444kB low:552kB high:660kB reserved_highatomic:2048KB active_anB
[   26.905162] lowmem_reserve[]: 0 1548 1548 1548 1548
[   26.905737] Node 0 DMA32 free:16612kB min:44608kB low:55760kB high:66912kB reserved_highatomic:18432KBB
[   26.909330] lowmem_reserve[]: 0 0 0 0 0
[   26.909856] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 0*32kB 1*64kB (H) 1*128kB (H) 0*256kB 0*512kB 0*1024kB B
[   26.911422] Node 0 DMA32: 45*4kB (ME) 18*8kB (UME) 4*16kB (UME) 11*32kB (UM) 3*64kB (M) 2*128kB (UM) 1B
[   26.913285] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[   26.914279] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[   26.915231] 7230 total pagecache pages
[   26.915672] 0 pages in swap cache
[   26.916068] Swap cache stats: add 0, delete 0, find 0/0
[   26.916666] Free swap  = 0kB
[   26.917006] Total swap = 0kB
[   26.917345] 524156 pages RAM
[   26.917686] 0 pages HighMem/MovableOnly
[   26.918130] 115119 pages reserved


-- 
Thank you,
Richard.
