From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 9 Sep 2020 16:49:43 +0800
Subject: [LTP] Error with cpuset_inherit
In-Reply-To: <BMXPR01MB234415DBFA9A047126CABB85EE260@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB234415DBFA9A047126CABB85EE260@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <1ca0f38c-59b5-4e9d-5090-8af0ee8a2c98@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Pankaj

:
> Hi,
> i am running cpuset_inherit from LTP version:20200515-267-g9677c5573 on 
> custom kernel 5.5.6 but i am getting following failure with the 
> mentioned testcase
> 
> earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait console=ttySIF0 
> console=tty0
> 
> Gnu C ? ? ? ? ? ? ? ? ?gcc (GCC) 8.3.0
> Clang
> Gnu make ? ? ? ? ? ? ? 4.2.1
> util-linux ? ? ? ? ? ? 2.34
> mount ? ? ? ? ? ? ? ? ?linux 2.34 (libmount 2.34.0: btrfs, namespaces, 
> assert, debug)
> modutils ? ? ? ? ? ? ? 26
> e2fsprogs ? ? ? ? ? ? ?1.45.4
> Linux C Library ? ? ? ?> libc.2.30
> Dynamic linker (ldd) ? 2.30
> Linux C++ Library ? ? ?6.0.25
> Procps ? ? ? ? ? ? ? ? 3.3.15
> iproute2 ? ? ? ? ? ? ? iproute2-ss190924
> iputils ? ? ? ? ? ? ? ?'V'
> Kbd ? ? ? ? ? ? ? ? ? ?2.2.0
> Sh-utils ? ? ? ? ? ? ? 8.31
> Modules Loaded ? ? ? ? veth ofpart cmdlinepart spi_nor
> 
> free reports:
>  ? ? ? ? ? ? ? total ? ? ? ?used ? ? ? ?free ? ? ?shared ?buff/cache   
> available
> Mem: ? ? ? ?8167360 ? ? ? 63568 ? ? 7098176 ? ? ? 17980 ? ? 1005616     
> 7994892
> Swap: ? ? ? ? ? ? 0 ? ? ? ? ? 0 ? ? ? ? ? 0
> 
> cpuinfo:
> Architecture: ? ? ? ?riscv64
> Byte Order: ? ? ? ? ?Little Endian
> CPU(s): ? ? ? ? ? ? ?4
> On-line CPU(s) list: 0-3
> Thread(s) per core: ?4
> Core(s) per socket: ?1
> Socket(s): ? ? ? ? ? 1
> L1d cache: ? ? ? ? ? 32 KiB
> L1i cache: ? ? ? ? ? 32 KiB
> L2 cache: ? ? ? ? ? ?2 MiB
> 
> AppArmor disabled
> 
> SELinux mode: unknown
> no big block device was specified on commandline.
> Tests which require a big block device are disabled.
> You can specify it with option -z
> COMMAND: ? ?/opt/ltp/bin/ltp-pan ? -e -S ? -a 10318 ? ? -n 10318 -p -f 
> /tmp/ltp-NOCHmuGYM1/alltests -l 
> /opt/ltp/results/LTP_RUN_ON-2020_09_08-11h_09m_36s.log ?-C 
> /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.failed -T 
> /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.tconf
> INFO: Restricted to cpuset_inherit
> LOG File: /opt/ltp/results/LTP_RUN_ON-2020_09_08-11h_09m_36s.log
> FAILED COMMAND File: 
> /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.failed
> TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.tconf
> Running tests.......
> <<<test_start>>>
> tag=cpuset_inherit stime=1599563376
> cmdline="cpuset_inherit_testset.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> cat: /sys/devices/system/node/has_normal_memory: No such file or directory
You should investigate why your system doesn't have this file because we 
use this file value to compare in test case.

I guess you may miss some kernel config.


> cpuset_inherit 1 TPASS: cpus: Inherited information is right!
> cpuset_inherit 3 TPASS: cpus: Inherited information is right!
> cpuset_inherit 5 TPASS: cpus: Inherited information is right!
> cpuset_inherit 7 TPASS: cpus: Inherited information is right!
> cpuset_inherit 9 TPASS: cpus: Inherited information is right!
> cpuset_inherit 11 TPASS: cpus: Inherited information is right!
> cpuset_inherit 13 TPASS: mems: Inherited information is right!
> cpuset_inherit 15 TPASS: mems: Inherited information is right!
> cpuset_inherit 17 TPASS: mems: Inherited information is right!
> cpuset_inherit 19 TPASS: mems: Inherited information is right!
> cpuset_inherit 21 TPASS: mems: Inherited information is right!
> *cpuset_inherit 23 TFAIL: mems: Test result - 0 Expected string - ""*
> cpuset_inherit 25 TPASS: cpu_exclusive: Inherited information is right!
> cpuset_inherit 27 TPASS: cpu_exclusive: Inherited information is right!
> cpuset_inherit 29 TPASS: mem_exclusive: Inherited information is right!
> cpuset_inherit 31 TPASS: mem_exclusive: Inherited information is right!
> cpuset_inherit 33 TPASS: mem_hardwall: Inherited information is right!
> cpuset_inherit 35 TPASS: mem_hardwall: Inherited information is right!
> cpuset_inherit 37 TPASS: memory_migrate: Inherited information is right!
> cpuset_inherit 39 TPASS: memory_migrate: Inherited information is right!
> cpuset_inherit 41 TPASS: memory_spread_page: Inherited information is right!
> cpuset_inherit 43 TPASS: memory_spread_page: Inherited information is right!
> cpuset_inherit 45 TPASS: memory_spread_slab: Inherited information is right!
> cpuset_inherit 47 TPASS: memory_spread_slab: Inherited information is right!
> cpuset_inherit 49 TPASS: sched_load_balance: Inherited information is right!
> cpuset_inherit 51 TPASS: sched_load_balance: Inherited information is right!
> cpuset_inherit 53 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> cpuset_inherit 55 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> cpuset_inherit 57 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> cpuset_inherit 59 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> cpuset_inherit 61 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> cpuset_inherit 63 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> cpuset_inherit 65 TPASS: sched_relax_domain_level: Inherited information 
> is right!
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=3 termination_type=exited termination_id=1 corefile=no
> cutime=131 cstime=194
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20200515-267-g9677c5573
> 
>  ? ? ? ?###############################################################
> 
>  ? ? ? ? ? ? Done executing testcases.
>  ? ? ? ? ? ? LTP Version: ?20200515-267-g9677c5573
>  ? ? ? ?###############################################################
> 
> Can someone help me why this test is getting failed and how i can 
> resolve it??
> 
> Thanks!
> 
> 
> 
> 


