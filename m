Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M72co-0001OJ-IW
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2009 07:23:34 +0000
Received: from smtp106.biz.mail.mud.yahoo.com ([68.142.200.254])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M72cQ-0006wQ-0K
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2009 07:23:34 +0000
Date: Thu, 21 May 2009 15:23:45 +0800 (CST)
Message-Id: <20090521.152345.260099485.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <d51f89b0905190522u484b457bk9fe3f80a322027d2@mail.gmail.com>
References: <20090518.191243.15248034.caiqian@cclom.cn>
	<1242729134.5961.47.camel@subratamodak.linux.ibm.com>
	<d51f89b0905190522u484b457bk9fe3f80a322027d2@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [LTP] Fw: Regarding ht_enable test case failure
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
To: rohit.170309@gmail.com
Cc: ltp-list@lists.sourceforge.net

From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] Fw: Regarding ht_enable test case failure
Date: Tue, 19 May 2009 17:52:26 +0530

> Dear CAI Qian,
> 
>  I want to discuss few issues/obervations regarding ht_interrupt.
> 
>  I have  two test PC:
> 
> 1. Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
> cat /etc/issue
> Fedora release 10 (Cambridge)
> Kernel \r on an \m (\l)
> 
> 2. Intel(R) Pentium(R) 4 CPU 3.00GHz
> cat /etc/issue
> Fedora release 10 (Cambridge)
> Kernel \r on an \m (\l)
> 
> 
> I have commented check_ht_capability( ) in test code just for testing
> purpose.
>

OK. I have also need to change,

#ifndef ARCH_i386
        tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architecture.");
#else

to

#ifndef __i386__
        tst_brkm(TCONF, NULL, "This test suite can only excute on i386 architecture.");
#else

in order to get it working on 32-bit systems.

> In ht_interrupt, timer interrupt is used to check whether interrupt is
> balancable or not.
> 
> # cat /proc/interrupts
>         CPU0       CPU1
>   0:        142         30   IO-APIC-edge      timer
> 
> 
> I have changed that check to ethernet interrupt, because on my first test PC
> these number (142 and 30 ) remains same till the execution of test and test
> case fails with following messages.
> "Interrupt distribution is not balancable"
>

It works fine on a RHEL5.3 here without need to change,

# lscpu
Architecture:          i686
CPU(s):                8
Thread(s) per core:    2
Core(s) per socket:    2
CPU socket(s):         2
Vendor ID:             GenuineIntel
CPU family:            15
Model:                 6
Stepping:              4
CPU MHz:               3725.610
...

# uname -r
2.6.18-128.el5

# ./ht_interrupt
ht_interrupt    0  INFO  :  Begin: HyperThreading Interrupt
ht_interrupt    0  INFO  :  Get interrupts distribution with HT.
..........

Timer interrupt counts per CPU:
1263 1260 1224 1223 1262 1262 1263 1263

max value: 1263
min value: 1223

ht_interrupt    1  PASS  :  Interrupt distribution is balanceable.
ht_interrupt    0  INFO  :  End: HyperThreading Interrupt

However, it is not working on a Fedora 10 system,

# lscpu
Architecture:          i686
CPU(s):                2
Thread(s) per core:    2
Core(s) per socket:    1
CPU socket(s):         1
Vendor ID:             GenuineIntel
CPU family:            15
Model:                 4
Stepping:              3
CPU MHz:               2992.428

# uname -r
2.6.27.5-117.fc10.i686

# ./ht_interrupt
ht_interrupt    0  INFO  :  Begin: HyperThreading Interrupt
ht_interrupt    0  INFO  :  Get interrupts distribution with HT.
..........

Timer interrupt counts per CPU:
0 0

max value: 0
min value: 0

ht_interrupt    1  FAIL  :  Interrupt distribution is not balanceable.
ht_interrupt    0  INFO  :  End: HyperThreading Interrupt

I am not sure if that is because they are using different kernel
versions?
 
> Test case passes on first test PC after the change (checking ethernet
> interrupt).
> 
> On second test PC with hyperthreading enabled, this test case fails:
> 
> #cat /proc/irq/27/smp_affinity
> # 3
> 
> #cat /proc/interrupts
>           CPU0       CPU1
>    27:    2002896        449   PCI-MSI-edge      eth0
> 
>  #cat /proc/interrupts
>           CPU0       CPU1
>    27:    20032957       449   PCI-MSI-edge      eth0
> Interrupt count for only CPU0 is incrementing.
> 
> I change the smp_affinity
> 
>  # echo 2 > /proc/irq/27/smp_affinity
>  # cat /proc/irq/27/smp_affinity
> # 2
> 
>  #cat /proc/interrupts
>           CPU0       CPU1
> 27:    2004494        564   PCI-MSI-edge      eth0
> Here, interrupt count for CPU1 is incrementing.
> 
> How can I get the balanced ethernet interrupts on both CPUs.
>

Same here on the Fedora 10 system.

# echo 3 >/proc/irq/16/smp_affinity

...
 16:    7412900       1212   IO-APIC-fasteoi   eth1
...
 16:    7412991       1212   IO-APIC-fasteoi   eth1
...

# echo 2 >/proc/irq/16/smp_affinity

...
 16:    7413106       1281   IO-APIC-fasteoi   eth1
...
 16:    7413106       1283   IO-APIC-fasteoi   eth1
...

No idea on how to get a balanced interrupts.

It is rather strange on the RHEL5.3 system.

# echo 3 >/proc/irq/90/smp_affinity

The interrupt count is increasing on only CPU0.

# cat /proc/interrupts
...
90: 107078 0 0 0 0 0 0 0 PCI-MS eth0
...
90: 107608 0 0 0 0 0 0 0 PCI-MS eth0

The same for changing it to 2.

# echo 2 >/proc/irq/90/smp_affinity

# cat /proc/interrupts
...
90: 108121 0 0 0 0 0 0 0 PCI-MS eth0
...
90: 108163 0 0 0 0 0 0 0 PCI-MS eth0

> 
> I am also getting an error message, when i try to change smp_affinity
> for timer interrupt.
> 
> # echo 3 > /proc/irq/0/smp_affinity
> -bash: echo: write error: Input/output error
>

This works fine on the RHEL5 system,

# echo 3 > /proc/irq/0/smp_affinity

Then, the interrupt counts on both CPU0 and CPU1 are increasing.

The Fedora 10 system is not,

# echo 3 > /proc/irq/0/smp_affinity

CAI Qian
 
>  # echo 3 > /proc/irq/<eth interrupt no>/smp_affinity works fine.
> 
> 
> Regards,
> Rohit
> 
> 

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
