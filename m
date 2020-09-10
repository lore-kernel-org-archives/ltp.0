From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Thu, 10 Sep 2020 05:55:05 +0000
Subject: [LTP] Error with cpuset_inherit
In-Reply-To: <241fc12f-a7ad-7285-579d-07f2de4d7b73@cn.fujitsu.com>
References: <BMXPR01MB234415DBFA9A047126CABB85EE260@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <1ca0f38c-59b5-4e9d-5090-8af0ee8a2c98@cn.fujitsu.com>
 <BMXPR01MB2344600330F2585F9F6609A6EE260@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>,
 <241fc12f-a7ad-7285-579d-07f2de4d7b73@cn.fujitsu.com>
Message-ID: <BMXPR01MB2344CBD58CD8BDB60301BF47EE270@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,
It seems NUMA is not supported on my arch.
I have other question, I saw LTP is getting maintained on Master branch only but i am able to see there are some tags i want to know on what basis these tags are getting updated ??



Thanks!
________________________________
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Sent: Thursday, September 10, 2020 8:09 AM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] Error with cpuset_inherit

Hi Pankaj

grep it on kernel code as below:
[root@localhost linux]# grep -nsr has_normal_memory
drivers/base/node.c:971:        [N_NORMAL_MEMORY] =
_NODE_ATTR(has_normal_memory, N_NORMAL_MEMORY),
Documentation/ABI/stable/sysfs-devices-node:13:What:
/sys/devices/system/node/has_normal_memory
[root@localhost linux]#

vim driver/base/Makefile
obj-$(CONFIG_NUMA)      += node.o

I guess your kernel doesn't enable CONFIG_NUMA.

> Hi,
> Can you suggest what all configs are needed for this testcase??
> ------------------------------------------------------------------------
> *From:* Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> *Sent:* Wednesday, September 9, 2020 2:19 PM
> *To:* Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>;
> ltp@lists.linux.it <ltp@lists.linux.it>
> *Subject:* Re: [LTP] Error with cpuset_inherit
> Hi Pankaj
>
> :
>> Hi,
>> i am running cpuset_inherit from LTP version:20200515-267-g9677c5573 on
>> custom kernel 5.5.6 but i am getting following failure with the
>> mentioned testcase
>>
>> earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait console=ttySIF0
>> console=tty0
>>
>> Gnu C                  gcc (GCC) 8.3.0
>> Clang
>> Gnu make               4.2.1
>> util-linux             2.34
>> mount                  linux 2.34 (libmount 2.34.0: btrfs, namespaces,
>> assert, debug)
>> modutils               26
>> e2fsprogs              1.45.4
>> Linux C Library        > libc.2.30
>> Dynamic linker (ldd)   2.30
>> Linux C++ Library      6.0.25
>> Procps                 3.3.15
>> iproute2               iproute2-ss190924
>> iputils                'V'
>> Kbd                    2.2.0
>> Sh-utils               8.31
>> Modules Loaded         veth ofpart cmdlinepart spi_nor
>>
>> free reports:
>>                total        used        free      shared  buff/cache
>> available
>> Mem:        8167360       63568     7098176       17980     1005616
>> 7994892
>> Swap:             0           0           0
>>
>> cpuinfo:
>> Architecture:        riscv64
>> Byte Order:          Little Endian
>> CPU(s):              4
>> On-line CPU(s) list: 0-3
>> Thread(s) per core:  4
>> Core(s) per socket:  1
>> Socket(s):           1
>> L1d cache:           32 KiB
>> L1i cache:           32 KiB
>> L2 cache:            2 MiB
>>
>> AppArmor disabled
>>
>> SELinux mode: unknown
>> no big block device was specified on commandline.
>> Tests which require a big block device are disabled.
>> You can specify it with option -z
>> COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 10318     -n 10318 -p -f
>> /tmp/ltp-NOCHmuGYM1/alltests -l
>> /opt/ltp/results/LTP_RUN_ON-2020_09_08-11h_09m_36s.log  -C
>> /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.failed -T
>> /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.tconf
>> INFO: Restricted to cpuset_inherit
>> LOG File: /opt/ltp/results/LTP_RUN_ON-2020_09_08-11h_09m_36s.log
>> FAILED COMMAND File:
>> /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.failed
>> TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_09_08-11h_09m_36s.tconf
>> Running tests.......
>> <<<test_start>>>
>> tag=cpuset_inherit stime=1599563376
>> cmdline="cpuset_inherit_testset.sh"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> cat: /sys/devices/system/node/has_normal_memory: No such file or directory
> You should investigate why your system doesn't have this file because we
> use this file value to compare in test case.
>
> I guess you may miss some kernel config.
>
>
>> cpuset_inherit 1 TPASS: cpus: Inherited information is right!
>> cpuset_inherit 3 TPASS: cpus: Inherited information is right!
>> cpuset_inherit 5 TPASS: cpus: Inherited information is right!
>> cpuset_inherit 7 TPASS: cpus: Inherited information is right!
>> cpuset_inherit 9 TPASS: cpus: Inherited information is right!
>> cpuset_inherit 11 TPASS: cpus: Inherited information is right!
>> cpuset_inherit 13 TPASS: mems: Inherited information is right!
>> cpuset_inherit 15 TPASS: mems: Inherited information is right!
>> cpuset_inherit 17 TPASS: mems: Inherited information is right!
>> cpuset_inherit 19 TPASS: mems: Inherited information is right!
>> cpuset_inherit 21 TPASS: mems: Inherited information is right!
>> *cpuset_inherit 23 TFAIL: mems: Test result - 0 Expected string - ""*
>> cpuset_inherit 25 TPASS: cpu_exclusive: Inherited information is right!
>> cpuset_inherit 27 TPASS: cpu_exclusive: Inherited information is right!
>> cpuset_inherit 29 TPASS: mem_exclusive: Inherited information is right!
>> cpuset_inherit 31 TPASS: mem_exclusive: Inherited information is right!
>> cpuset_inherit 33 TPASS: mem_hardwall: Inherited information is right!
>> cpuset_inherit 35 TPASS: mem_hardwall: Inherited information is right!
>> cpuset_inherit 37 TPASS: memory_migrate: Inherited information is right!
>> cpuset_inherit 39 TPASS: memory_migrate: Inherited information is right!
>> cpuset_inherit 41 TPASS: memory_spread_page: Inherited information is right!
>> cpuset_inherit 43 TPASS: memory_spread_page: Inherited information is right!
>> cpuset_inherit 45 TPASS: memory_spread_slab: Inherited information is right!
>> cpuset_inherit 47 TPASS: memory_spread_slab: Inherited information is right!
>> cpuset_inherit 49 TPASS: sched_load_balance: Inherited information is right!
>> cpuset_inherit 51 TPASS: sched_load_balance: Inherited information is right!
>> cpuset_inherit 53 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> cpuset_inherit 55 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> cpuset_inherit 57 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> cpuset_inherit 59 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> cpuset_inherit 61 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> cpuset_inherit 63 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> cpuset_inherit 65 TPASS: sched_relax_domain_level: Inherited information
>> is right!
>> incrementing stop
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=3 termination_type=exited termination_id=1 corefile=no
>> cutime=131 cstime=194
>> <<<test_end>>>
>> INFO: ltp-pan reported some tests FAIL
>> LTP Version: 20200515-267-g9677c5573
>>
>>         ###############################################################
>>
>>              Done executing testcases.
>>              LTP Version:  20200515-267-g9677c5573
>>         ###############################################################
>>
>> Can someone help me why this test is getting failed and how i can
>> resolve it??
>>
>> Thanks!
>>
>>
>>
>>
>
>
> [EXT]


[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200910/911097ce/attachment-0001.htm>
