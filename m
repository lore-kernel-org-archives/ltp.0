From: Feng Feng24 Liu <liufeng24@lenovo.com>
Date: Fri, 23 Jun 2017 04:45:13 +0000
Subject: [LTP] Testcase oom01 cause RT kernel hang-up
Message-ID: <2B18E8E1DDAE074A82D1060396451DAE263CAF1D@CNMAILEX04.lenovo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Dear experts
	I run ltp-full-20170516 on my server . My kernel is RT kernel 4.4.70-rt83. 
	I use " ./runltp " to run the test suite,  and when run test case oom01, it will cause server hang-up. 
	It could be repeat .
	But when I run oom01 on normal kernel (non-RT), it will run smoothly.
	I do not know if LTP is not suitable for real-time kernel or there is a BUG?!

Following is the kernel log when server hang-up:
------------------------------------------------------------------------------------------------------------------------------------------------------------------
dev106 login: [597430.215525] oom01 invoked oom-killer: gfp_mask=0x24280ca, order=0, oom_score_adj=0
[597430.224547] oom01 cpuset=/ mems_allowed=0-1
[597430.229586] CPU: 8 PID: 12263 Comm: oom01 Not tainted 4.4.70-thinkcloud-nfv #1
[597430.229586] Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
[597430.229588]  0000000000000000 ffff88102ebebb50 ffffffff814093de ffff88102ebebd48
[597430.229589]  0000000000000000 ffff88102ebebbe8 ffffffff811a9ab6 ffff88102ebebb80
[597430.229590]  ffffffff81a9009a ffff88102ebebb80 ffffffff81a900e0 ffff88102ebebbd8
[597430.229590] Call Trace:
[597430.229596]  [<ffffffff814093de>] dump_stack+0x65/0x87
[597430.229600]  [<ffffffff811a9ab6>] dump_header+0x5b/0x1ef
[597430.229603]  [<ffffffff81a9009a>] ? _raw_spin_lock_irqsave+0x2a/0x50
[597430.229604]  [<ffffffff81a900e0>] ? _raw_spin_unlock_irqrestore+0x20/0x60
[597430.229606]  [<ffffffff810856e3>] ? preempt_count_add+0xa3/0xc0
[597430.229607]  [<ffffffff81a900e0>] ? _raw_spin_unlock_irqrestore+0x20/0x60
[597430.229610]  [<ffffffff8114c190>] oom_kill_process+0x210/0x3f0
[597430.229612]  [<ffffffff8114c7ec>] out_of_memory+0x41c/0x470
[597430.229614]  [<ffffffff8115222c>] __alloc_pages_nodemask+0x9bc/0xaf0
[597430.229616]  [<ffffffff81195b8f>] alloc_pages_vma+0x8f/0x180
[597430.229619]  [<ffffffff81178348>] handle_mm_fault+0xf78/0x1380
[597430.229620]  [<ffffffff81a8ee7a>] ? rt_mutex_lock+0x1a/0x20
[597430.229624]  [<ffffffff8104efaf>] __do_page_fault+0x16f/0x4d0
[597430.229625]  [<ffffffff8104f342>] do_page_fault+0x32/0x90
[597430.229627]  [<ffffffff811463cd>] ? context_tracking_exit+0x1d/0x30
[597430.229629]  [<ffffffff81a92718>] page_fault+0x28/0x30
[597430.229630] Mem-Info:
[597430.391784] active_anon:31299218 inactive_anon:1335634 isolated_anon:69
[597430.391784]  active_file:407 inactive_file:0 isolated_file:0
[597430.391784]  unevictable:0 dirty:0 writeback:447 unstable:0
[597430.391784]  slab_reclaimable:8139 slab_unreclaimable:15711
[597430.391784]  mapped:3681 shmem:3218 pagetables:67782 bounce:0
[597430.391784]  free:80896 free_pcp:1150 free_cma:0
[597430.431408] Node 0 DMA free:15896kB min:4kB low:4kB high:4kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15980kB managed:15896kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[597430.478939] lowmem_reserve[]: 0 1574 64040 64040
[597430.484504] Node 0 DMA32 free:250392kB min:532kB low:664kB high:796kB active_anon:1016688kB inactive_anon:338980kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:1629252kB managed:1612460kB mlocked:0kB dirty:0kB writeback:0kB mapped:224kB shmem:580kB slab_reclaimable:1004kB slab_unreclaimable:1376kB kernel_stack:48kB pagetables:2732kB unstable:0kB bounce:0kB free_pcp:36kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:270144 all_unreclaimable? yes
[597430.536417] lowmem_reserve[]: 0 0 62465 62465
[597430.541680] Node 0 Normal free:61672kB min:22348kB low:27932kB high:33520kB active_anon:60962332kB inactive_anon:2540044kB active_file:76kB inactive_file:1072kB unevictable:0kB isolated(anon):128kB isolated(file):0kB present:65011712kB managed:63964536kB mlocked:0kB dirty:0kB writeback:164kB mapped:4748kB shmem:4100kB slab_reclaimable:17644kB slab_unreclaimable:32472kB kernel_stack:4848kB pagetables:133656kB unstable:0kB bounce:0kB free_pcp:3524kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:1536 all_unreclaimable? no
[597430.596172] lowmem_reserve[]: 0 0 0 0
[597430.600662] Node 1 Normal free:27940kB min:22896kB low:28620kB high:34344kB active_anon:63163640kB inactive_anon:2481676kB active_file:136kB inactive_file:360kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:67108864kB managed:66057968kB mlocked:0kB dirty:0kB writeback:124kB mapped:8824kB shmem:8316kB slab_reclaimable:13908kB slab_unreclaimable:28472kB kernel_stack:4160kB pagetables:135064kB unstable:0kB bounce:0kB free_pcp:1824kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:4860 all_unreclaimable? no
[597430.654822] lowmem_reserve[]: 0 0 0 0
[597430.659307] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15896kB
[597430.680443] Node 0 DMA32: 500*4kB (UME) 355*8kB (UE) 173*16kB (UME) 43*32kB (UME) 10*64kB (UME) 5*128kB (UME) 12*256kB (UE) 9*512kB (UME) 5*1024kB (UE) 5*2048kB (UME) 53*4096kB (UME) = 250392kB
[597430.700782] Node 0 Normal: 861*4kB (UME) 1966*8kB (UMEH) 993*16kB (UME) 273*32kB (UME) 39*64kB (UME) 55*128kB (MEH) 18*256kB (ME) 2*512kB (E) 0*1024kB 0*2048kB 0*4096kB = 58964kB
[597430.719587] Node 1 Normal: 253*4kB (UMEH) 216*8kB (UMEH) 105*16kB (UMEH) 73*32kB (UME) 33*64kB (UME) 55*128kB (UMEH) 23*256kB (UME) 12*512kB (UME) 0*1024kB 0*2048kB 0*4096kB = 27940kB
[597430.738892] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[597430.749166] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[597430.759165] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[597430.769422] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[597430.779387] 109608 total pagecache pages
[597430.784086] 105428 pages in swap cache
[597430.788613] Swap cache stats: add 1203422, delete 1097994, find 367/716
[597430.796323] Free swap  = 384kB
[597430.800050] Total swap = 4194300kB
[597430.804170] 33441452 pages RAM
[597430.807902] 0 pages HighMem/MovableOnly
[597430.812512] 528737 pages reserved
[597430.816550] 131072 pages cma reserved
[597430.820973] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[597430.831084] [ 5633]     0  5633    13399     4503      33       3       40             0 systemd-journal
[597430.842242] [ 5654]     0  5654    48158        0      29       3      107             0 lvmetad
[597430.852612] [ 7156]     0  7156    10580        1      21       3      136         -1000 systemd-udevd
[597430.863573] [ 7521]     0  7521    13856        0      27       3      111         -1000 auditd
[597430.873872] [ 7545]    70  7545     7054        1      19       3      110             0 avahi-daemon
[597430.884735] [ 7547]   997  7547   132948        0      58       4      865             0 polkitd
[597430.895191] [ 7548]     0  7548     4890      105      14       3       51             0 irqbalance
[597430.905873] [ 7550]     0  7550     6050        2      16       3       78             0 systemd-logind
[597430.916947] [ 7556]    81  7556     6103        1      17       3      102          -900 dbus-daemon
[597430.927709] [ 7566]    70  7566     6997        0      18       3       59             0 avahi-daemon
[597430.938557] [ 7622]     0  7622     5702        0      15       3      105             0 ipmievd
[597430.948959] [ 8040]     0  8040   138290       96      88       4     2587             0 tuned
[597430.959139] [ 8212]     0  8212   153554       90     142       3     1506             0 libvirtd
[597430.969603] [ 8223]     0  8223    31558        1      20       3      154             0 crond
[597430.979793] [ 8235]   993  8235    20508        2      40       3      202             0 zabbix_agentd
[597430.990751] [ 8238]   993  8238    20508      850      41       3      182             0 zabbix_agentd
[597431.001725] [ 8241]   993  8241    20508        0      40       3      228             0 zabbix_agentd
[597431.012674] [ 8243]   993  8243    20508        0      40       3      228             0 zabbix_agentd
[597431.023631] [ 8245]   993  8245    20508        0      40       3      228             0 zabbix_agentd
[597431.034589] [ 8246]   993  8246    20508      127      40       3      214             0 zabbix_agentd
[597431.045554] [ 8293]     0  8293    27511        1      11       3       30             0 agetty
[597431.055840] [ 8329]     0  8329    85382       43     118       4      364             0 nmbd
[597431.066002] [ 8488]     0  8488    20619        0      43       3      216         -1000 sshd
[597431.076073] [ 8570]     0  8570   102059       10     145       3      559             0 smbd
[597431.086154] [ 8611]     0  8611   101109        9     139       3      535             0 smbd-notifyd
[597431.097012] [ 8612]     0  8612   101224        9     138       3      535             0 cleanupd
[597431.107464] [ 8665]     0  8665   102059       11     139       3      558             0 lpqd
[597431.117554] [ 9013]     0  9013    22247        1      42       3      257             0 master
[597431.127848] [ 9115]    89  9115    22290        1      45       3      257             0 qmgr
[597431.137935] [ 9416]    99  9416     3888        1      12       3       49             0 dnsmasq
[597431.148291] [ 9417]     0  9417     3881        0      12       3       46             0 dnsmasq
[597431.158668] [13186]     0 13186   103150       32     147       3      919             0 smbd
[597431.168755] [16001]     0 16001   102840       10     146       3      615             0 smbd
[597431.178856] [17130]     0 17130    36384        2      72       3      326             0 sshd
[597431.188953] [17132]  1000 17132    36418        0      69       3      332             0 sshd
[597431.199035] [17133]  1000 17133    28882        2      13       4      120             0 bash
[597431.209110] [17156]     0 17156    27511        1      10       3       32             0 agetty
[597431.219369] [ 2839]     0  2839    48999        1      52       3      218             0 sudo
[597431.229434] [ 2840]     0  2840    28881        2      13       3      129             0 bash
[597431.239515] [ 6580]     0  6580    28382        1      11       3      168             0 runltp
[597431.249809] [ 6735]     0  6735     1921        1       8       3      101             0 ltp-pan
[597431.260172] [31065]     0 31065    74446      863      45       3      102             0 rsyslogd
[597431.270645] [  935]    89   935    22273        1      44       3      254             0 pickup
[597431.280941] [12210]     0 12210     2700        1      11       3       36             0 oom01
[597431.291119] [12236]     0 12236 42525351 32515755   65594     165  1035703             0 oom01
[597431.301291] Out of memory: Kill process 12236 (oom01) score 960 or sacrifice child
[597431.310285] Killed process 12236 (oom01) total-vm:170101404kB, anon-rss:130063020kB, file-rss:0kB
[597608.291337] ------------[ cut here ]------------
[597608.296909] WARNING: CPU: 0 PID: 5783 at kernel/workqueue.c:926 wq_worker_sleeping+0x5f/0x70()
[597608.307097] Modules linked in: sctp rds xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ipt_REJECT xt_tcpudp ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter intel_rapl iosf_mbi intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 glue_helper lrw ablk_helper cryptd ipmi_devintf input_leds joydev led_class ipmi_si mxm_wmi ipmi_msghandler acpi_pad ioatdma sb_edac acpi_power_meter dca mei_me lpc_ich mfd_core shpchp edac_core mei tpm_tis wmi ip_tables x_tables megaraid_sas
[597608.373301] CPU: 0 PID: 5783 Comm: kworker/0:2 Not tainted 4.4.70-thinkcloud-nfv #1
[597608.373301] Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
[597608.373305] Workqueue: kacpid acpi_os_execute_deferred
[597608.373323]  0000000000000000 ffff8810319fb380 ffffffff814093de 0000000000000000
[597608.373324]  ffffffff81c99393 ffff8810319fb3b8 ffffffff810615d6 ffff882010f47470
[597608.373325]  ffff8810345a0000 ffff8810345a0000 0000000000000282 ffff881efa467530
[597608.373325] Call Trace:
[597608.373330]  [<ffffffff814093de>] dump_stack+0x65/0x87
[597608.373334]  [<ffffffff810615d6>] warn_slowpath_common+0x86/0xe0
[597608.373335]  [<ffffffff810616ea>] warn_slowpath_null+0x1a/0x30
[597608.373336]  [<ffffffff8107b46f>] wq_worker_sleeping+0x5f/0x70
[597608.373340]  [<ffffffff81a8d39e>] schedule+0x8e/0xe0
[597608.373341]  [<ffffffff81a8f117>] rt_spin_lock_slowlock+0x217/0x390
[597608.373343]  [<ffffffff81a903bf>] rt_spin_lock+0x1f/0x30
[597608.373344]  [<ffffffff813e9336>] blk_flush_plug_list+0x176/0x1f0
[597608.373346]  [<ffffffff81a8d3c5>] schedule+0xb5/0xe0
[597608.373347]  [<ffffffff81a8f638>] schedule_timeout+0x148/0x330
[597608.373349]  [<ffffffff810a2d88>] ? __try_to_take_rt_mutex+0x108/0x160
[597608.373353]  [<ffffffff810c3460>] ? trace_event_raw_event_tick_stop+0xd0/0xd0
[597608.373355]  [<ffffffff810856e3>] ? preempt_count_add+0xa3/0xc0
[597608.373356]  [<ffffffff81a8f87e>] schedule_timeout_uninterruptible+0x1e/0x20
[597608.373359]  [<ffffffff81168ac3>] wait_iff_congested+0xd3/0x190
[597608.373362]  [<ffffffff810a0260>] ? prepare_to_wait_event+0xf0/0xf0
[597608.373365]  [<ffffffff8115df1c>] shrink_inactive_list+0x4ac/0x5d0
[597608.373367]  [<ffffffff8115e949>] shrink_lruvec+0x559/0x740
[597608.373369]  [<ffffffff8115ec0d>] shrink_zone+0xdd/0x280
[597608.373370]  [<ffffffff8115f10f>] do_try_to_free_pages+0x14f/0x430
[597608.373372]  [<ffffffff8115f4aa>] try_to_free_pages+0xba/0x1f0
[597608.373375]  [<ffffffff81151dc6>] __alloc_pages_nodemask+0x556/0xaf0
[597608.373378]  [<ffffffff811944cd>] alloc_pages_current+0x8d/0x120
[597608.373380]  [<ffffffff81199540>] new_slab+0x2b0/0x380
[597608.373382]  [<ffffffff8119c01d>] ___slab_alloc+0x3bd/0x530
[597608.373385]  [<ffffffff81497c0e>] ? acpi_ut_create_generic_state+0x39/0x44
[597608.373388]  [<ffffffff81424eb7>] ? debug_smp_processor_id+0x17/0x20
[597608.373390]  [<ffffffff810620a6>] ? unpin_current_cpu+0x16/0x70
[597608.373392]  [<ffffffff811aa97a>] __slab_alloc.isra.73+0x6c/0x93
[597608.373393]  [<ffffffff81497c0e>] ? acpi_ut_create_generic_state+0x39/0x44
[597608.373394]  [<ffffffff81497c0e>] ? acpi_ut_create_generic_state+0x39/0x44
[597608.373396]  [<ffffffff8119d617>] kmem_cache_alloc+0xc7/0x190
[597608.373397]  [<ffffffff81490721>] ? acpi_os_acquire_object+0x2d/0x2f
[597608.373398]  [<ffffffff81497c0e>] acpi_ut_create_generic_state+0x39/0x44
[597608.373401]  [<ffffffff814904b1>] acpi_ps_push_scope+0x23/0x7b
[597608.373403]  [<ffffffff8148f3d2>] acpi_ps_parse_loop+0x19d/0x56c
[597608.373404]  [<ffffffff81490212>] acpi_ps_parse_aml+0x98/0x289
[597608.373405]  [<ffffffff81490a8d>] acpi_ps_execute_method+0x152/0x193
[597608.373407]  [<ffffffff8148b2b4>] acpi_ns_evaluate+0x1c1/0x259
[597608.373409]  [<ffffffff8147f111>] acpi_ev_asynch_execute_gpe_method+0xa0/0x107
[597608.373410]  [<ffffffff81469134>] acpi_os_execute_deferred+0x14/0x20
[597608.373411]  [<ffffffff8107a8f1>] process_one_work+0x151/0x480
[597608.373413]  [<ffffffff8107ad6b>] worker_thread+0x14b/0x4c0
[597608.373414]  [<ffffffff8107ac20>] ? process_one_work+0x480/0x480
[597608.373415]  [<ffffffff81080366>] kthread+0xd6/0xf0
[597608.373417]  [<ffffffff81080290>] ? kthread_worker_fn+0x160/0x160
[597608.373418]  [<ffffffff81a90bcf>] ret_from_fork+0x3f/0x70
[597608.373419]  [<ffffffff81080290>] ? kthread_worker_fn+0x160/0x160
[597608.373420] ---[ end trace 0000000000000002 ]---
[597620.934471] oom01 invoked oom-killer: gfp_mask=0x24280ca, order=0, oom_score_adj=0
[597620.943493] oom01 cpuset=/ mems_allowed=0-1
[597620.948532] CPU: 2 PID: 12291 Comm: oom01 Tainted: G        W       4.4.70-thinkcloud-nfv #1
[597620.948533] Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
[597620.948534]  0000000000000000 ffff882012e03b50 ffffffff814093de ffff882012e03d48
[597620.948535]  0000000000000000 ffff882012e03be8 ffffffff811a9ab6 ffff882012e03b80
[597620.948536]  ffffffff81a9009a ffff882012e03b80 ffffffff81a900e0 ffff882012e03bd8
[597620.948537] Call Trace:
[597620.948543]  [<ffffffff814093de>] dump_stack+0x65/0x87
[597620.948546]  [<ffffffff811a9ab6>] dump_header+0x5b/0x1ef
[597620.948549]  [<ffffffff81a9009a>] ? _raw_spin_lock_irqsave+0x2a/0x50
[597620.948550]  [<ffffffff81a900e0>] ? _raw_spin_unlock_irqrestore+0x20/0x60
[597620.948552]  [<ffffffff810856e3>] ? preempt_count_add+0xa3/0xc0
[597620.948553]  [<ffffffff81a900e0>] ? _raw_spin_unlock_irqrestore+0x20/0x60
[597620.948556]  [<ffffffff8114c190>] oom_kill_process+0x210/0x3f0
[597620.948557]  [<ffffffff8114c7ec>] out_of_memory+0x41c/0x470
[597620.948560]  [<ffffffff8115222c>] __alloc_pages_nodemask+0x9bc/0xaf0
[597620.948562]  [<ffffffff81195b8f>] alloc_pages_vma+0x8f/0x180
[597620.948565]  [<ffffffff81178348>] handle_mm_fault+0xf78/0x1380
[597620.948566]  [<ffffffff81a8ee7a>] ? rt_mutex_lock+0x1a/0x20
[597620.948570]  [<ffffffff8104efaf>] __do_page_fault+0x16f/0x4d0
[597620.948571]  [<ffffffff8104f342>] do_page_fault+0x32/0x90
[597620.948573]  [<ffffffff811463cd>] ? context_tracking_exit+0x1d/0x30
[597620.948574]  [<ffffffff81a92718>] page_fault+0x28/0x30
[597620.948575] Mem-Info:
[597621.111966] active_anon:31264564 inactive_anon:1373169 isolated_anon:77
[597621.111966]  active_file:486 inactive_file:207 isolated_file:0
[597621.111966]  unevictable:0 dirty:0 writeback:215 unstable:0
[597621.111966]  slab_reclaimable:8105 slab_unreclaimable:15624
[597621.111966]  mapped:1003 shmem:602 pagetables:67834 bounce:0
[597621.111966]  free:78868 free_pcp:34 free_cma:2174
[597621.151799] Node 0 DMA free:15896kB min:4kB low:4kB high:4kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15980kB managed:15896kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[597621.199218] lowmem_reserve[]: 0 1574 64040 64040
[597621.204790] Node 0 DMA32 free:250392kB min:532kB low:664kB high:796kB active_anon:1016288kB inactive_anon:338840kB active_file:8kB inactive_file:4kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:1629252kB managed:1612460kB mlocked:0kB dirty:0kB writeback:0kB mapped:92kB shmem:100kB slab_reclaimable:1068kB slab_unreclaimable:1372kB kernel_stack:32kB pagetables:2848kB unstable:0kB bounce:0kB free_pcp:8kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:576 all_unreclaimable? yes
[597621.256229] lowmem_reserve[]: 0 0 62465 62465
[597621.261500] Node 0 Normal free:24304kB min:22348kB low:27932kB high:33520kB active_anon:60998656kB inactive_anon:2542444kB active_file:904kB inactive_file:192kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:65011712kB managed:63964536kB mlocked:0kB dirty:0kB writeback:796kB mapped:1440kB shmem:752kB slab_reclaimable:17620kB slab_unreclaimable:32848kB kernel_stack:4752kB pagetables:137556kB unstable:0kB bounce:0kB free_pcp:124kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:20356 all_unreclaimable? yes
[597621.315677] lowmem_reserve[]: 0 0 0 0
[597621.320168] Node 1 Normal free:24880kB min:22896kB low:28620kB high:34344kB active_anon:63030512kB inactive_anon:2624448kB active_file:1032kB inactive_file:632kB unevictable:0kB isolated(anon):1204kB isolated(file):0kB present:67108864kB managed:66057968kB mlocked:0kB dirty:0kB writeback:64kB mapped:2480kB shmem:1556kB slab_reclaimable:13732kB slab_unreclaimable:28276kB kernel_stack:4288kB pagetables:130932kB unstable:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:8696kB writeback_tmp:0kB pages_scanned:94112 all_unreclaimable? yes
[597621.374837] lowmem_reserve[]: 0 0 0 0
[597621.379312] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15896kB
[597621.395104] Node 0 DMA32: 42*4kB (UE) 138*8kB (UE) 78*16kB (UME) 86*32kB (UE) 42*64kB (UE) 14*128kB (UME) 14*256kB (UME) 9*512kB (UME) 5*1024kB (UE) 5*2048kB (UME) 53*4096kB (UME) = 250392kB
[597621.415137] Node 0 Normal: 97*4kB (UM) 106*8kB (UMEH) 62*16kB (UME) 79*32kB (UMEH) 39*64kB (UMEH) 37*128kB (UME) 30*256kB (UME) 5*512kB (UME) 2*1024kB (UM) 0*2048kB 0*4096kB = 24276kB
[597621.434581] Node 1 Normal: 51*4kB (UMEHC) 68*8kB (UMEHC) 80*16kB (UMEHC) 58*32kB (UMEC) 33*64kB (UMEHC) 20*128kB (MEH) 20*256kB (MEC) 6*512kB (UE) 0*1024kB 0*2048kB 2*4096kB (C) = 24940kB
[597621.454316] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[597621.464596] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[597621.474591] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[597621.484867] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[597621.494846] 111013 total pagecache pages
[597621.499566] 110376 pages in swap cache
[597621.504072] Swap cache stats: add 2242762, delete 2132386, find 1675/3392
[597621.511981] Free swap  = 0kB
[597621.515534] Total swap = 4194300kB
[597621.519661] 33441452 pages RAM
[597621.523405] 0 pages HighMem/MovableOnly
[597621.528008] 528737 pages reserved
[597621.532031] 131072 pages cma reserved
[597621.536459] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[597621.546561] [ 5633]     0  5633    13399      338      33       3       33             0 systemd-journal
[597621.557732] [ 5654]     0  5654    48158        0      29       3      107             0 lvmetad
[597621.568105] [ 7156]     0  7156    10580        1      21       3      136         -1000 systemd-udevd
[597621.579064] [ 7521]     0  7521    13856       17      27       3       94         -1000 auditd
[597621.589358] [ 7545]    70  7545     7054       43      19       3       67             0 avahi-daemon
[597621.600203] [ 7547]   997  7547   132948       50      58       4      809             0 polkitd
[597621.610580] [ 7548]     0  7548     4890      103      14       3       53             0 irqbalance
[597621.621230] [ 7550]     0  7550     6050       40      16       3       39             0 systemd-logind
[597621.632269] [ 7556]    81  7556     6103       56      17       3       47          -900 dbus-daemon
[597621.643032] [ 7566]    70  7566     6997        0      18       3       59             0 avahi-daemon
[597621.653901] [ 7622]     0  7622     5702        4      15       3      103             0 ipmievd
[597621.664258] [ 8040]     0  8040   138290       69      88       4     2614             0 tuned
[597621.674440] [ 8212]     0  8212   153554        1     142       3     1595             0 libvirtd
[597621.684924] [ 8223]     0  8223    31558       24      20       3      130             0 crond
[597621.695098] [ 8235]   993  8235    20508        1      40       3      202             0 zabbix_agentd
[597621.706071] [ 8238]   993  8238    20508      337      41       3      182             0 zabbix_agentd
[597621.717047] [ 8241]   993  8241    20508        0      40       3      228             0 zabbix_agentd
[597621.728001] [ 8243]   993  8243    20508        0      40       3      228             0 zabbix_agentd
[597621.738974] [ 8245]   993  8245    20508        0      40       3      228             0 zabbix_agentd
[597621.749920] [ 8246]   993  8246    20508       16      40       3      216             0 zabbix_agentd
[597621.760878] [ 8293]     0  8293    27511        1      11       3       30             0 agetty
[597621.771140] [ 8329]     0  8329    85382       46     118       4      361             0 nmbd
[597621.781212] [ 8488]     0  8488    20619        0      43       3      216         -1000 sshd
[597621.791278] [ 8570]     0  8570   102059        1     145       3      568             0 smbd
[597621.801349] [ 8611]     0  8611   101109        0     139       3      544             0 smbd-notifyd
[597621.812207] [ 8612]     0  8612   101224        0     138       3      544             0 cleanupd
[597621.822770] [ 8665]     0  8665   102059       17     139       3      551             0 lpqd
[597621.832872] [ 9013]     0  9013    22247        0      42       3      257             0 master
[597621.843148] [ 9115]    89  9115    22290        1      45       3      257             0 qmgr
[597621.853215] [ 9416]    99  9416     3888        1      12       3       49             0 dnsmasq
[597621.863584] [ 9417]     0  9417     3881        0      12       3       46             0 dnsmasq
[597621.873960] [13186]     0 13186   103150       55     147       3      895             0 smbd
[597621.884041] [16001]     0 16001   102840       64     146       3      560             0 smbd
[597621.899550] [17130]     0 17130    36384        1      72       3      326             0 sshd
[597621.909627] [17132]  1000 17132    36418       24      69       3      308             0 sshd
[597621.919727] [17133]  1000 17133    28882        1      13       4      121             0 bash
[597621.929837] [17156]     0 17156    27511        1      10       3       32             0 agetty
[597621.940104] [ 2839]     0  2839    48999        1      52       3      218             0 sudo
[597621.950170] [ 2840]     0  2840    28881        1      13       3      130             0 bash
[597621.960226] [ 6580]     0  6580    28382        1      11       3      168             0 runltp
[597621.970505] [ 6735]     0  6735     1921        1       8       3      101             0 ltp-pan
[597621.980889] [31065]     0 31065    74446       83      45       3      104             0 rsyslogd
[597621.991343] [  935]    89   935    22273        0      44       3      254             0 pickup
[597622.001628] [12210]     0 12210     2700        8      11       3       28             0 oom01
[597622.011834] [12266]     0 12266 42525351 32524535   65594     165  1033619             0 oom01
[597622.022114] Out of memory: Kill process 12266 (oom01) score 960 or sacrifice child
[597622.031140] Killed process 12266 (oom01) total-vm:170101404kB, anon-rss:130098140kB, file-rss:0kB

------------------------------------------------------------------------------------------------------------------------------------------------------------------


Thanks
Feng



