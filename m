From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Oct 2019 20:31:12 +0200
Subject: [LTP] LTP-cpuset test cases
In-Reply-To: <MA1PR0101MB18158831A03644C622793C6B989B0@MA1PR0101MB1815.INDPRD01.PROD.OUTLOOK.COM>
References: <MA1PR0101MB18158831A03644C622793C6B989B0@MA1PR0101MB1815.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20191007183111.GA26203@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am running LTP to test cpuset test cases. I have created new command file after copying 2 commands from runltp.
> 
>   cpuset_load_balance cpuset_load_balance_test.sh
>   cpuset_base_ops cpuset_base_ops_testset.sh
> 
> with above sequence, crash is happening
> 
> [10546.587463] Workqueue: cgroup_destroy css_killed_work_fn
> [10546.592762] pstate: 80400009 (Nzcv daif +PAN -UAO)
> [10546.597550] pc : build_sched_domains+0x244/0xb48
> [10546.602154] lr : build_sched_domains+0x228/0xb48
> [10546.606757] sp : ffff000031fc3b70
> [10546.610059] x29: ffff000031fc3b70 x28: ffff00001157d730
> [10546.615357] x27: ffff0000115a7000 x26: ffff00001118d000
> [10546.620655] x25: 00000000000000e0 x24: 0000000000000000
> [10546.625953] x23: ffff00001118dc80 x22: ffff00001157d730
> [10546.631251] x21: ffff80bf54723940 x20: ffff80bded3aef00
> [10546.636549] x19: ffff00001157f1e4 x18: 0000000000000000
> [10546.641848] x17: 0000000000000000 x16: 0000000000000000
> .546
>   kernel:Internal error: Oops: 96000007 [#1] SMP
> [10546.661905] x13: 00000000ffffffff x12: ffffffff00000000
> [10546.667203] x11: 0000000000000000 x10: 0000000000000000
> [10546.672501] x9 : 0000000000000000 x8 : ffff80bded45c000
> [10546.677799] x7 : 0000000000000000 x6 : 000000000000003f
> [10546.683097] x5 : 0000000000000040 x4 : 0000000000000000
> [10546.688395] x3 : 0000000000000000 x2 : 0000000000000000
> [10546.693693] x1 : ffff00001118dc80 x0 : 00000000ffffffff
> [10546.698991] Call trace:
> [10546.701426]  build_sched_domains+0x244/0xb48
> [10546.705684]  partition_sched_domains+0x1dc/0x2dc
> [10546.710300]  rebuild_sched_domains_locked+0x64/0xa8
> [10546.715166]  update_flag+0x174/0x190
> [10546.718729]  cpuset_css_offline+0xb0/0xc8
> [10546.722725]  css_killed_work_fn+0x54/0x118
> [10546.726811]  process_one_work+0x1b4/0x3d8
> [10546.730807]  worker_thread+0x4c/0x420
> [10546.734463]  kthread+0x108/0x138
> [10546.737685]  ret_from_fork+0x10/0x18
> [10546.741249] Code: aa0003e1 12800000 f862dac2 aa0103f7 (f8616855)
> [10546.747330] ---[ end trace c4f1497fb4a860c8 ]---

This does not seem to be the whole trace, it should start with something
as: ---[ cut here ] --

> Strangely, If I run sequence [1] or [2] no crash is happening
> [1]
> cpuset_load_balance     cpuset_load_balance_test.sh
> cpuset_load_balance     cpuset_load_balance_test.sh
> 
> [2]
> cpuset_load_balance     cpuset_load_balance_test.sh
> cpuset_sched_domains    cpuset_sched_domains_test.sh
> cpuset_hotplug  cpuset_hotplug_test.sh
> 
> What I can infer that the cpuset_load_balance, cpuset_sched_domains, cpuset_hotplug are usig cpuset_set(). While cpuset_base_ops doesnt use cpuset_set().
> Also, combination of cpuset_load_balance with any cpuset tests *not* using cpuset_set() causing above type of crash.
> 
> I have seen this crash on Linux 5.09 and 5.4.rc0 kernel.
> 
> 
> Any clue will help me in moving forward.

Report a kernel bug? If you can crash a kernel with a particular
sequence of tests its likely a kernel bug.

-- 
Cyril Hrubis
chrubis@suse.cz
