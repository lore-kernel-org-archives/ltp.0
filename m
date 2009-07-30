Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWMQj-000449-98
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:35:45 +0000
Received: from rv-out-0708.google.com ([209.85.198.245])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWMQb-0002sQ-7s
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:35:45 +0000
Received: by rv-out-0708.google.com with SMTP id b17so300592rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 20:35:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907272350n258c4018mcbf1c5806c3bd27f@mail.gmail.com>
References: <f5a7b3810907200605r5fc2f575ta761cd45c92b0837@mail.gmail.com>
	<f5a7b3810907272350n258c4018mcbf1c5806c3bd27f@mail.gmail.com>
Date: Wed, 29 Jul 2009 20:35:31 -0700
Message-ID: <364299f40907292035v683f05a2nbe22082f9e20c837@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [FIX PATCHES] open_posix_execute.sh
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>

On Mon, Jul 27, 2009 at 11:50 PM, naresh kamboju<naresh.kernel@gmail.com> wrote:
> Hi,
>
> Hope you have reviewed below patch.
> If you any issue please let me know.
>
> Subrata/ Garrett,
> Please review, if you feel okay.
> commit.
>
> Best regards,
> Naresh Kamboju
>
>
> On Mon, Jul 20, 2009 at 6:35 PM, naresh kamboju<naresh.kernel@gmail.com> wrote:
>> Hi,
>>
>> As per the execute.sh script file there is time limit of two minutes
>> for each test case execution if it takes more time it will be reported
>> as HUNG.
>>
>> shm_open/23-1.c test case under posix test suite which executes more
>> than two minitutes so test case reported as HUNG.
>>
>> I have changed time limit from 120 to 300 sec. that is nothing but two
>> minutes to five minutes. In low end machines this test case taking 4
>> min to complete execution.
>>
>> Now test cases reported as PASS
>>
>> I have attached patch and below.
>> Please review the same.

Naresh,
    I looked at the testcase, and I think I can see where your concern
stems from, as this is a stress test, more than a functional test
(1000 child PIDs looping 1000 times each... that's a fair number of
cycles :)...). What I'd be really be interested in is the number of
cycles being generated (msec is `randomly' generated -- see line 75).
However, when I ran the testcase on my machine -- it took less than 10
seconds (!):


    I do have more RAM and all, and I have a fairly recent Intel
processor (posted below), but what do you have that's so sluggish by
chance?
    I wonder why it failed though *shrugs*.
Thanks,
-Garrett

gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ gcc
-Itestcases/open_posix_testsuite/include/
testcases/open_posix_testsuite/conformance/interfaces/shm_open/23-1.c
gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ time ./a.out
create_cnt: 890
Test FAILED

real    0m10.947s
user    0m4.074s
sys     0m9.189s

gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ uname -a
Linux orangebox 2.6.29-gentoo-r5 #2 SMP PREEMPT Sun Jun 14 01:11:32
PDT 2009 x86_64 Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
GenuineIntel GNU/Linux
gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ cat
/proc/meminfo /proc/cpuinfo
MemTotal:        8197172 kB
MemFree:          180264 kB
Buffers:          227552 kB
Cached:          6427308 kB
SwapCached:         5744 kB
Active:           914940 kB
Inactive:        6820352 kB
Active(anon):     310092 kB
Inactive(anon):   776660 kB
Active(file):     604848 kB
Inactive(file):  6043692 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       6498284 kB
SwapFree:        6472696 kB
Dirty:               484 kB
Writeback:             0 kB
AnonPages:       1075824 kB
Mapped:            56784 kB
Slab:             192872 kB
SReclaimable:     162736 kB
SUnreclaim:        30136 kB
PageTables:        10908 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    10596868 kB
Committed_AS:    1617720 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      334552 kB
VmallocChunk:   34359384571 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:     8119808 kB
DirectMap2M:      268288 kB
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz
stepping        : 10
cpu MHz         : 2664.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
lahf_lm tpr_shadow vnmi flexpriority
bogomips        : 5343.38
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz
stepping        : 10
cpu MHz         : 2664.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 4
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
lahf_lm tpr_shadow vnmi flexpriority
bogomips        : 5343.00
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz
stepping        : 10
cpu MHz         : 2664.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 2
cpu cores       : 4
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
lahf_lm tpr_shadow vnmi flexpriority
bogomips        : 5343.03
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz
stepping        : 10
cpu MHz         : 2664.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 3
cpu cores       : 4
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
lahf_lm tpr_shadow vnmi flexpriority
bogomips        : 5343.03
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
