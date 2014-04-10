Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WYHS0-0004EC-M6
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 16:03:40 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WYHRy-0001MU-4o
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 16:03:40 +0000
Date: Thu, 10 Apr 2014 18:03:26 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140410180326.093f2749@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] ltplite test case crashes
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
To: ltp-list@lists.sourceforge.net

Hi,

I tried out the test case ltplite just for fun, and it crashed. The
last part of it was:

gf15        1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=14 termination_type=exited termination_id=0 corefile=no
cutime=1249 cstime=115
<<<test_end>>>
<<<test_start>>>
tag=gf17 stime=1397150754
cmdline="growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_"
contacts=""
analysis=exit
<<<test_output>>>
[11711.048780] growfiles invoked oom-killer: gfp_mask=0x200d2, order=0, oom_score_adj=0
[11711.056517] growfiles cpuset=/ mems_allowed=0
[11711.060885] CPU: 0 PID: 18426 Comm: growfiles Not tainted 3.10.34-ltsi-yocto-standard #2
[11711.068994] Hardware name: Hewlett-Packard HP Compaq Elite 8300 SFF/3397, BIOS K01 v02.90 07/16/2013
[11711.078147]  0000000000000000 ffff8801153d5930 ffffffff818e4f2f ffff8801153d59c0
[11711.085649]  ffffffff818e142e 0000000000000020 ffff8801153d5960 ffffffff8107460d
[11711.093108]  0000000000000001 ffff8801153d5978 ffffffff818f03b1 0000000000000206
[11711.100570] Call Trace:
[11711.103021]  [<ffffffff818e4f2f>] dump_stack+0x19/0x1b
[11711.108158]  [<ffffffff818e142e>] dump_header+0x7f/0x20e
[11711.113474]  [<ffffffff8107460d>] ? get_parent_ip+0xd/0x50
[11711.118976]  [<ffffffff818f03b1>] ? sub_preempt_count+0x71/0x100
[11711.124981]  [<ffffffff81100645>] oom_kill_process+0x1d5/0x340
[11711.130814]  [<ffffffff81100d92>] out_of_memory+0x422/0x460
[11711.136385]  [<ffffffff811061db>] __alloc_pages_nodemask+0x9fb/0xaa0
[11711.142739]  [<ffffffff8113d059>] alloc_pages_current+0xa9/0x160
[11711.148752]  [<ffffffff810fd007>] __page_cache_alloc+0x97/0xc0
[11711.154584]  [<ffffffff810fd6af>] grab_cache_page_write_begin+0x6f/0xd0
[11711.161193]  [<ffffffff81177cdb>] simple_write_begin+0x2b/0x110
[11711.167114]  [<ffffffff810fdcad>] generic_file_buffered_write+0x10d/0x290
[11711.173903]  [<ffffffff810feee1>] __generic_file_aio_write+0x1c1/0x3d0
[11711.180428]  [<ffffffff810ff14d>] generic_file_aio_write+0x5d/0xc0
[11711.186608]  [<ffffffff81153130>] do_sync_write+0x80/0xb0
[11711.192008]  [<ffffffff81153809>] vfs_write+0xb9/0x1c0
[11711.197146]  [<ffffffff81153e09>] SyS_write+0x49/0xa0
[11711.202193]  [<ffffffff818f430d>] tracesys+0xd0/0xd5
[11711.207158] Mem-Info:
[11711.209437] Node 0 DMA per-cpu:
[11711.212601] CPU    0: hi:    0, btch:   1 usd:   0
[11711.217395] CPU    1: hi:    0, btch:   1 usd:   0
[11711.222187] CPU    2: hi:    0, btch:   1 usd:   0
[11711.226972] CPU    3: hi:    0, btch:   1 usd:   0
[11711.231758] Node 0 DMA32 per-cpu:
[11711.235103] CPU    0: hi:  186, btch:  31 usd:  40
[11711.239888] CPU    1: hi:  186, btch:  31 usd: 158
[11711.244680] CPU    2: hi:  186, btch:  31 usd: 170
[11711.249469] CPU    3: hi:  186, btch:  31 usd: 155
[11711.254253] Node 0 Normal per-cpu:
[11711.257667] CPU    0: hi:  186, btch:  31 usd:  41
[11711.262452] CPU    1: hi:  186, btch:  31 usd: 163
[11711.267241] CPU    2: hi:  186, btch:  31 usd: 176
[11711.272036] CPU    3: hi:  186, btch:  31 usd: 171
[11711.276842] active_anon:1461 inactive_anon:194 isolated_anon:0
[11711.276842]  active_file:64 inactive_file:18 isolated_file:0
[11711.276842]  unevictable:1962822 dirty:0 writeback:0 unstable:0
[11711.276842]  free:11129 slab_reclaimable:15535 slab_unreclaimable:4025
[11711.276842]  mapped:898 shmem:212 pagetables:161 bounce:0
[11711.276842]  free_cma:0

Actually, there's a lot more error messages if anyone would care about
it, but I ended up at the login prompt. The system was quite unusable
after this.

Is this the reason why this test case is not in the default list of
test cases?

Does anyone know about this crash?

uname -a:
Linux intel-corei7-64 3.10.34-ltsi-yocto-standard #2 SMP PREEMPT Thu Apr 10 10:33:12 CEST 2014 x86_64 GNU/Linux


Best regards,
Mats

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
