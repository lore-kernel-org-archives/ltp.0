Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v0V-0004H9-6y
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:56:27 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v0U-0001nT-8X
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:56:27 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466n0PS007342
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:49:00 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466uK2C121612
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:56:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466uJLb030326
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:56:20 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:26:06 +0530
Message-Id: <20100506065604.23879.86248.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [01/12 FAILURE] LTPX Memory CGROUP test creates Call Trace and Badness at mm/oom_kill.c:393
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8309139811803070379=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============8309139811803070379==

Subject: LTP�� Memory CGROUP test creates Call Trace & Badness at mm/oom_kill.c:393

Issues Description Below:
===========================

# ./runltp -f memcg_control

You will see the following /var/log/messages entry:
***********************************************************************************************
Apr 22 23:16:42 mjs22lp1 kernel: memcg_control_t invoked oom-killer:
gfp_mask=0xd0, order=0, oom_adj=0
Apr 22 23:16:42 mjs22lp1 kernel: memcg_control_t invoked oom-killer:
gfp_mask=0xd0, order=0, oom_adj=0
Apr 22 23:16:42 mjs22lp1 kernel: memcg_control_t cpuset=/ mems_allowed=0-255
Apr 22 23:16:42 mjs22lp1 kernel: Call Trace:
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b520] [c0000000000161c8]
.show_stack+0xb0/0x1a0
Apr 22 23:16:42 mjs22lp1 kernel: memcg_control_t cpuset=/ mems_allowed=0-255
Apr 22 23:16:42 mjs22lp1 kernel: Call Trace:
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83520] [c0000000000161c8]
.show_stack+0xb0/0x1a0 (unreliable)
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec835e0] [c000000000735358]
.dump_stack+0x28/0x3c
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83660] [c000000000194700]
.dump_header+0xa8/0x1e0
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83720] [c0000000001948b8]
.oom_kill_process+0x80/0x194
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec837e0] [c000000000195348]
.mem_cgroup_out_of_memory+0x88/0xc0
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83890] [c0000000001ec750]
.__mem_cgroup_try_charge+0x21c/0x320
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83990] [c0000000001ed258]
.mem_cgroup_charge_common+0x84/0xd8
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83a60] [c0000000001ed334]
.mem_cgroup_newpage_charge+0x88/0xbc
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83b00] [c0000000001b57c0]
.do_wp_page+0x6f8/0x9e4
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83bf0] [c0000000001b77e0]
.handle_mm_fault+0x834/0x8d8
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83cf0] [c000000000731ce0]
.do_page_fault+0x434/0x65c
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83e30] [c0000000000056cc]
handle_page_fault+0x20/0x74
Apr 22 23:16:42 mjs22lp1 kernel: Task in /1/sub killed as a result of limit of
/1
Apr 22 23:16:42 mjs22lp1 kernel: (unreliable)
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b5e0] [c000000000735358]
.dump_stack+0x28/0x3c
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b660] [c000000000194700]
.dump_header+0xa8/0x1e0
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b720] [c0000000001948b8]
.oom_kill_process+0x80/0x194
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b7e0] [c000000000195348]
.mem_cgroup_out_of_memory+0x88/0xc0
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b890] [c0000000001ec750]
.__mem_cgroup_try_charge+0x21c/0x320
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8b990] [c0000000001ed258]
.mem_cgroup_charge_common+0x84/0xd8
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8ba60] [c0000000001ed334]
.mem_cgroup_newpage_charge+0x88/0xbc
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8bb00] [c0000000001b57c0]
.do_wp_page+0x6f8/0x9e4
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8bbf0] [c0000000001b77e0]
.handle_mm_fault+0x834/0x8d8
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8bcf0] [c000000000731ce0]
.do_page_fault+0x434/0x65c
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003eb8be30] [c0000000000056cc]
handle_page_fault+0x20/0x74
Apr 22 23:16:42 mjs22lp1 kernel: Task in /1/sub killed as a result of limit of
/1
Apr 22 23:16:42 mjs22lp1 kernel: memory: usage 4kB, limit 4kB, failcnt 15
Apr 22 23:16:42 mjs22lp1 kernel: memory+swap: usage 4kB, limit 4kB, failcnt 0
Apr 22 23:16:42 mjs22lp1 kernel: Mem-Info:
Apr 22 23:16:42 mjs22lp1 kernel: Node 0 DMA per-cpu:
Apr 22 23:16:42 mjs22lp1 kernel: CPU    0: hi:  186, btch:  31 usd:  90
Apr 22 23:16:42 mjs22lp1 kernel: CPU    1: hi:  186, btch:  31 usd: 109
Apr 22 23:16:42 mjs22lp1 kernel: CPU    2: hi:  186, btch:  31 usd:  68
Apr 22 23:16:42 mjs22lp1 kernel: CPU    3: hi:  186, btch:  31 usd: 121
Apr 22 23:16:42 mjs22lp1 kernel: CPU    4: hi:  186, btch:  31 usd: 134
Apr 22 23:16:42 mjs22lp1 kernel: CPU    5: hi:  186, btch:  31 usd: 125
Apr 22 23:16:42 mjs22lp1 kernel: CPU    6: hi:  186, btch:  31 usd: 137
Apr 22 23:16:42 mjs22lp1 kernel: CPU    7: hi:  186, btch:  31 usd: 104
Apr 22 23:16:42 mjs22lp1 kernel: Node 1 DMA per-cpu:
Apr 22 23:16:42 mjs22lp1 kernel: CPU    0: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    1: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    2: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    3: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    4: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    5: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    6: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    7: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: active_anon:4373 inactive_anon:0
isolated_anon:0
Apr 22 23:16:42 mjs22lp1 kernel: active_file:28578 inactive_file:22728
isolated_file:0
Apr 22 23:16:42 mjs22lp1 kernel: unevictable:0 dirty:11 writeback:0 unstable:0
Apr 22 23:16:42 mjs22lp1 kernel: free:506114 slab_reclaimable:5173
slab_unreclaimable:33442
Apr 22 23:16:42 mjs22lp1 kernel: mapped:4419 shmem:44 pagetables:477 bounce:0
Apr 22 23:16:42 mjs22lp1 kernel: Node 0 DMA free:761980kB min:3060kB low:3824kB
high:4588kB active_anon:17492kB inactive_anon:0kB active_file:114312kB
inactive_file:90912kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
present:1228160kB mlocked:0kB dirty:44kB writeback:0kB mapped:17664kB
shmem:176kB slab_reclaimable:19604kB slab_unreclaimable:121920kB
kernel_stack:3312kB pagetables:1908kB unstable:0kB bounce:0kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no
Apr 22 23:16:42 mjs22lp1 kernel: lowmem_reserve[]: 0 0 0
Apr 22 23:16:42 mjs22lp1 kernel: Node 1 DMA free:1262476kB min:3344kB
low:4180kB high:5016kB active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
present:1340416kB mlocked:0kB dirty:0kB writeback:0kB mapped:12kB shmem:0kB
slab_reclaimable:1088kB slab_unreclaimable:11848kB kernel_stack:64kB
pagetables:0kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0
all_unreclaimable? no
Apr 22 23:16:42 mjs22lp1 kernel: lowmem_reserve[]: 0 0 0
Apr 22 23:16:42 mjs22lp1 kernel: Node 0 DMA:
Apr 22 23:16:42 mjs22lp1 kernel: memory: usage 4kB, limit 4kB, failcnt 15
Apr 22 23:16:42 mjs22lp1 kernel: 6*4kB 7*8kB 3*16kB 2*32kB 1*64kB 7*128kB
10*256kB 3*512kB 3*1024kB 2*2048kB 3*4096kB 2*8192kB 44*16384kB = 761984kB
Apr 22 23:16:42 mjs22lp1 kernel: Node 1 DMA: 17*4kB
Apr 22 23:16:42 mjs22lp1 kernel: memory+swap: usage 4kB, limit 4kB, failcnt 0
Apr 22 23:16:42 mjs22lp1 kernel: 25*8kB 34*16kB 43*32kB 24*64kB 12*128kB
11*256kB 12*512kB 9*1024kB 9*2048kB 8*4096kB 5*8192kB 70*16384kB = 1262476kB
Apr 22 23:16:42 mjs22lp1 kernel: 51349 total pagecache pages
Apr 22 23:16:42 mjs22lp1 kernel: 0 pages in swap cache
Apr 22 23:16:42 mjs22lp1 kernel: Swap cache stats: add 0, delete 0, find 0/0
Apr 22 23:16:42 mjs22lp1 kernel: Free swap  = 9437160kB
Apr 22 23:16:42 mjs22lp1 kernel: Total swap = 9437160kB
Apr 22 23:16:42 mjs22lp1 kernel: Mem-Info:
Apr 22 23:16:42 mjs22lp1 kernel: Node 0 DMA per-cpu:
Apr 22 23:16:42 mjs22lp1 kernel: CPU    0: hi:  186, btch:  31 usd:  90
Apr 22 23:16:42 mjs22lp1 kernel: CPU    1: hi:  186, btch:  31 usd: 109
Apr 22 23:16:42 mjs22lp1 kernel: CPU    2: hi:  186, btch:  31 usd:  68
Apr 22 23:16:42 mjs22lp1 kernel: CPU    3: hi:  186, btch:  31 usd: 121
Apr 22 23:16:42 mjs22lp1 kernel: CPU    4: hi:  186, btch:  31 usd: 134
Apr 22 23:16:42 mjs22lp1 kernel: CPU    5: hi:  186, btch:  31 usd: 125
Apr 22 23:16:42 mjs22lp1 kernel: CPU    6: hi:  186, btch:  31 usd: 137
Apr 22 23:16:42 mjs22lp1 kernel: CPU    7: hi:  186, btch:  31 usd: 104
Apr 22 23:16:42 mjs22lp1 kernel: Node 1 DMA per-cpu:
Apr 22 23:16:42 mjs22lp1 kernel: CPU    0: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    1: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    2: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    3: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    4: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    5: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    6: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: CPU    7: hi:  186, btch:  31 usd:   0
Apr 22 23:16:42 mjs22lp1 kernel: active_anon:4373 inactive_anon:0
isolated_anon:0
Apr 22 23:16:42 mjs22lp1 kernel: active_file:28578 inactive_file:22728
isolated_file:0
Apr 22 23:16:42 mjs22lp1 kernel: unevictable:0 dirty:11 writeback:0 unstable:0
Apr 22 23:16:42 mjs22lp1 kernel: free:506114 slab_reclaimable:5173
slab_unreclaimable:33442
Apr 22 23:16:42 mjs22lp1 kernel: mapped:4419 shmem:44 pagetables:477 bounce:0
Apr 22 23:16:42 mjs22lp1 kernel: Node 0 DMA free:761980kB min:3060kB low:3824kB
high:4588kB active_anon:17492kB inactive_anon:0kB active_file:114312kB
inactive_file:90912kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
present:1228160kB mlocked:0kB dirty:44kB writeback:0kB mapped:17664kB
shmem:176kB slab_reclaimable:19604kB slab_unreclaimable:121920kB
kernel_stack:3312kB pagetables:1908kB unstable:0kB bounce:0kB writeback_tmp:0kB
pages_scanned:0 all_unreclaimable? no
Apr 22 23:16:42 mjs22lp1 kernel: lowmem_reserve[]: 0 0 0
Apr 22 23:16:42 mjs22lp1 kernel: Node 1 DMA free:1262476kB min:3344kB
low:4180kB high:5016kB active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
present:1340416kB mlocked:0kB dirty:0kB writeback:0kB mapped:12kB shmem:0kB
slab_reclaimable:1088kB slab_unreclaimable:11848kB kernel_stack:64kB
pagetables:0kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0
all_unreclaimable? no
Apr 22 23:16:42 mjs22lp1 kernel: lowmem_reserve[]: 0 0 0
Apr 22 23:16:42 mjs22lp1 kernel: Node 0 DMA: 6*4kB 7*8kB 3*16kB 2*32kB 1*64kB
7*128kB 10*256kB 3*512kB 3*1024kB 2*2048kB 3*4096kB 2*8192kB 44*16384kB =
761984kB
Apr 22 23:16:42 mjs22lp1 kernel: Node 1 DMA: 17*4kB 25*8kB 34*16kB 43*32kB
24*64kB 12*128kB 11*256kB 12*512kB 9*1024kB 9*2048kB 8*4096kB 5*8192kB
70*16384kB = 1262476kB
Apr 22 23:16:42 mjs22lp1 kernel: 51349 total pagecache pages
Apr 22 23:16:42 mjs22lp1 kernel: 0 pages in swap cache
Apr 22 23:16:42 mjs22lp1 kernel: Swap cache stats: add 0, delete 0, find 0/0
Apr 22 23:16:42 mjs22lp1 kernel: Free swap  = 9437160kB
Apr 22 23:16:42 mjs22lp1 kernel: Total swap = 9437160kB
Apr 22 23:16:42 mjs22lp1 kernel: 966656 pages RAM
Apr 22 23:16:42 mjs22lp1 kernel: 33079 pages reserved
Apr 22 23:16:42 mjs22lp1 kernel: 80979 pages shared
Apr 22 23:16:42 mjs22lp1 kernel: 170832 pages non-shared
Apr 22 23:16:42 mjs22lp1 kernel: Memory cgroup out of memory: kill process 1738
(memcg_control_t) score 131 or a child
Apr 22 23:16:42 mjs22lp1 kernel: Killed process 1743 (memcg_control_t)
vsz:5628kB, anon-rss:156kB, file-rss:12kB
Apr 22 23:16:42 mjs22lp1 kernel: VM: killing process memcg_control_t
Apr 22 23:16:42 mjs22lp1 kernel: 966656 pages RAM
Apr 22 23:16:42 mjs22lp1 kernel: 33079 pages reserved
Apr 22 23:16:42 mjs22lp1 kernel: 80822 pages shared
Apr 22 23:16:42 mjs22lp1 kernel: 170835 pages non-shared
Apr 22 23:16:42 mjs22lp1 kernel: ------------[ cut here ]------------
Apr 22 23:16:42 mjs22lp1 kernel: Badness at mm/oom_kill.c:393
Apr 22 23:16:42 mjs22lp1 kernel: NIP: c0000000001942f0 LR: c0000000001942e0
CTR: 0000000000000001
Apr 22 23:16:42 mjs22lp1 kernel: REGS: c00000003ec83400 TRAP: 0700   Tainted: G
       W   (2.6.33.1-19.fc13.ppc64)
Apr 22 23:16:42 mjs22lp1 kernel: MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR:
24224422  XER: 00000000
Apr 22 23:16:42 mjs22lp1 kernel: TASK = c00000004e230000[1743]
'memcg_control_t' THREAD: c00000003ec80000 CPU: 7
Apr 22 23:16:42 mjs22lp1 kernel: GPR00: c0000000001942e0 c00000003ec83680
c000000001329558 0000000000000001
Apr 22 23:16:42 mjs22lp1 kernel: GPR04: c00000004d8259c8 000000000000000c
0000000000000000 0000000000000002
Apr 22 23:16:42 mjs22lp1 kernel: GPR08: 0000000000000000 0000000000000000
0000000000000934 000000000000079b
Apr 22 23:16:42 mjs22lp1 kernel: GPR12: 0000000024224484 c00000000135c300
0000000000000000 00000000100f0000
Apr 22 23:16:42 mjs22lp1 kernel: GPR16: 00000000100f4a54 0000000046ba0093
c00000004e0410d8 f000000000cdcaa8
Apr 22 23:16:42 mjs22lp1 kernel: GPR20: c00000004e041058 c00000004e041068
c00000003ec83900 0000000000000000
Apr 22 23:16:42 mjs22lp1 kernel: GPR24: c000000000c7dd10 c00000000095e4aa
00000000000000d0 0000000000000000
Apr 22 23:16:42 mjs22lp1 kernel: GPR28: c00000004d8259b0 c00000004d824f80
c0000000012a4f68 c00000003ec83680
Apr 22 23:16:42 mjs22lp1 kernel: NIP [c0000000001942f0]
.__oom_kill_task+0x74/0x15c
Apr 22 23:16:42 mjs22lp1 kernel: LR [c0000000001942e0]
.__oom_kill_task+0x64/0x15c
Apr 22 23:16:42 mjs22lp1 kernel: Call Trace:
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83680] [c0000000001942e0]
.__oom_kill_task+0x64/0x15c (unreliable)
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83720] [c000000000194940]
.oom_kill_process+0x108/0x194
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec837e0] [c000000000195348]
.mem_cgroup_out_of_memory+0x88/0xc0
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83890] [c0000000001ec750]
.__mem_cgroup_try_charge+0x21c/0x320
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83990] [c0000000001ed258]
.mem_cgroup_charge_common+0x84/0xd8
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83a60] [c0000000001ed334]
.mem_cgroup_newpage_charge+0x88/0xbc
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83b00] [c0000000001b57c0]
.do_wp_page+0x6f8/0x9e4
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83bf0] [c0000000001b77e0]
.handle_mm_fault+0x834/0x8d8
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83cf0] [c000000000731ce0]
.do_page_fault+0x434/0x65c
Apr 22 23:16:42 mjs22lp1 kernel: [c00000003ec83e30] [c0000000000056cc]
handle_page_fault+0x20/0x74
Apr 22 23:16:42 mjs22lp1 kernel: Instruction dump:
Apr 22 23:16:42 mjs22lp1 kernel: 0fe00000 e87e8000 485a1275 60000000 480000e4
3b9d0a30 7f83e378 4859aa69
Apr 22 23:16:42 mjs22lp1 kernel: 60000000 e93d0288 2fa90000 40be002c <0fe00000>
e87e8008 38bd04e8 e89d02b2
Apr 22 23:16:42 mjs22lp1 kernel: tried to kill an mm-less task 1738
(memcg_control_t)!
Apr 22 23:16:42 mjs22lp1 kernel: VM: killing process memcg_control_t
***********************************************************************************************

Regards--
Subrata



--===============8309139811803070379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8309139811803070379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8309139811803070379==--
