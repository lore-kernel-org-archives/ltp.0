Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MWOqn-0001fw-F2
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 06:10:49 +0000
Received: from mail-yx0-f188.google.com ([209.85.210.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWOqi-0001O9-3e
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 06:10:49 +0000
Received: by mail-yx0-f188.google.com with SMTP id 26so2231729yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 23:10:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907292035v683f05a2nbe22082f9e20c837@mail.gmail.com>
References: <f5a7b3810907200605r5fc2f575ta761cd45c92b0837@mail.gmail.com>
	<f5a7b3810907272350n258c4018mcbf1c5806c3bd27f@mail.gmail.com>
	<364299f40907292035v683f05a2nbe22082f9e20c837@mail.gmail.com>
Date: Thu, 30 Jul 2009 11:40:42 +0530
Message-ID: <f5a7b3810907292310n1a388595q1759a3d972d611fc@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>

On Thu, Jul 30, 2009 at 9:05 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Mon, Jul 27, 2009 at 11:50 PM, naresh kamboju<naresh.kernel@gmail.com>=
 wrote:
>> Hi,
>>
>> Hope you have reviewed below patch.
>> If you any issue please let me know.
>>
>> Subrata/ Garrett,
>> Please review, if you feel okay.
>> commit.
>>
>> Best regards,
>> Naresh Kamboju
>>
>>
>> On Mon, Jul 20, 2009 at 6:35 PM, naresh kamboju<naresh.kernel@gmail.com>=
 wrote:
>>> Hi,
>>>
>>> As per the execute.sh script file there is time limit of two minutes
>>> for each test case execution if it takes more time it will be reported
>>> as HUNG.
>>>
>>> shm_open/23-1.c test case under posix test suite which executes more
>>> than two minitutes so test case reported as HUNG.
>>>
>>> I have changed time limit from 120 to 300 sec. that is nothing but two
>>> minutes to five minutes. In low end machines this test case taking 4
>>> min to complete execution.
>>>
>>> Now test cases reported as PASS
>>>
>>> I have attached patch and below.
>>> Please review the same.
>
> Naresh,
> =A0 =A0I looked at the testcase, and I think I can see where your concern
> stems from, as this is a stress test, more than a functional test
> (1000 child PIDs looping 1000 times each... that's a fair number of
> cycles :)...). What I'd be really be interested in is the number of
> cycles being generated (msec is `randomly' generated -- see line 75).
> However, when I ran the testcase on my machine -- it took less than 10
> seconds (!):
>
>
> =A0 =A0I do have more RAM and all, and I have a fairly recent Intel
> processor (posted below), but what do you have that's so sluggish by
> chance?

Hi Garrett,

Your comments are absolutely correct.

> =A0 =A0I wonder why it failed though *shrugs*.


This test case is passed on high end machines with 128 MB and high RAM.
When you execute this test case on 32/16 MB RAM Embedded Board this
test case reports has Hung. because it is taking more than 3 min.
To resolve this issue I made this patch.

This patch is a Max limit of test cases execution time.
If test case exceeds given time then test case will report as HUNG.

I think there is no harm to apply this patch.
It is not going to effect performance of test and the rest of the test case=
s.

Best regards,
Naresh Kamboju

> Thanks,
> -Garrett
>
> gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ gcc
> -Itestcases/open_posix_testsuite/include/
> testcases/open_posix_testsuite/conformance/interfaces/shm_open/23-1.c
> gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ time ./a.out
> create_cnt: 890
> Test FAILED
>
> real =A0 =A00m10.947s
> user =A0 =A00m4.074s
> sys =A0 =A0 0m9.189s
>
> gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ uname -a
> Linux orangebox 2.6.29-gentoo-r5 #2 SMP PREEMPT Sun Jun 14 01:11:32
> PDT 2009 x86_64 Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
> GenuineIntel GNU/Linux
> gcooper@orangebox /scratch/ltp-makefile-infra-rework/ltp $ cat
> /proc/meminfo /proc/cpuinfo
> MemTotal: =A0 =A0 =A0 =A08197172 kB
> MemFree: =A0 =A0 =A0 =A0 =A0180264 kB
> Buffers: =A0 =A0 =A0 =A0 =A0227552 kB
> Cached: =A0 =A0 =A0 =A0 =A06427308 kB
> SwapCached: =A0 =A0 =A0 =A0 5744 kB
> Active: =A0 =A0 =A0 =A0 =A0 914940 kB
> Inactive: =A0 =A0 =A0 =A06820352 kB
> Active(anon): =A0 =A0 310092 kB
> Inactive(anon): =A0 776660 kB
> Active(file): =A0 =A0 604848 kB
> Inactive(file): =A06043692 kB
> Unevictable: =A0 =A0 =A0 =A0 =A0 0 kB
> Mlocked: =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
> SwapTotal: =A0 =A0 =A0 6498284 kB
> SwapFree: =A0 =A0 =A0 =A06472696 kB
> Dirty: =A0 =A0 =A0 =A0 =A0 =A0 =A0 484 kB
> Writeback: =A0 =A0 =A0 =A0 =A0 =A0 0 kB
> AnonPages: =A0 =A0 =A0 1075824 kB
> Mapped: =A0 =A0 =A0 =A0 =A0 =A056784 kB
> Slab: =A0 =A0 =A0 =A0 =A0 =A0 192872 kB
> SReclaimable: =A0 =A0 162736 kB
> SUnreclaim: =A0 =A0 =A0 =A030136 kB
> PageTables: =A0 =A0 =A0 =A010908 kB
> NFS_Unstable: =A0 =A0 =A0 =A0 =A00 kB
> Bounce: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
> WritebackTmp: =A0 =A0 =A0 =A0 =A00 kB
> CommitLimit: =A0 =A010596868 kB
> Committed_AS: =A0 =A01617720 kB
> VmallocTotal: =A0 34359738367 kB
> VmallocUsed: =A0 =A0 =A0334552 kB
> VmallocChunk: =A0 34359384571 kB
> HugePages_Total: =A0 =A0 =A0 0
> HugePages_Free: =A0 =A0 =A0 =A00
> HugePages_Rsvd: =A0 =A0 =A0 =A00
> HugePages_Surp: =A0 =A0 =A0 =A00
> Hugepagesize: =A0 =A0 =A0 2048 kB
> DirectMap4k: =A0 =A0 8119808 kB
> DirectMap2M: =A0 =A0 =A0268288 kB
> processor =A0 =A0 =A0 : 0
> vendor_id =A0 =A0 =A0 : GenuineIntel
> cpu family =A0 =A0 =A0: 6
> model =A0 =A0 =A0 =A0 =A0 : 23
> model name =A0 =A0 =A0: Intel(R) Core(TM)2 Quad CPU =A0 =A0Q9400 =A0@ 2.6=
6GHz
> stepping =A0 =A0 =A0 =A0: 10
> cpu MHz =A0 =A0 =A0 =A0 : 2664.000
> cache size =A0 =A0 =A0: 3072 KB
> physical id =A0 =A0 : 0
> siblings =A0 =A0 =A0 =A0: 4
> core id =A0 =A0 =A0 =A0 : 0
> cpu cores =A0 =A0 =A0 : 4
> apicid =A0 =A0 =A0 =A0 =A0: 0
> initial apicid =A0: 0
> fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
> fpu_exception =A0 : yes
> cpuid level =A0 =A0 : 13
> wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
> flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep m=
trr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
> lahf_lm tpr_shadow vnmi flexpriority
> bogomips =A0 =A0 =A0 =A0: 5343.38
> clflush size =A0 =A0: 64
> cache_alignment : 64
> address sizes =A0 : 36 bits physical, 48 bits virtual
> power management:
>
> processor =A0 =A0 =A0 : 1
> vendor_id =A0 =A0 =A0 : GenuineIntel
> cpu family =A0 =A0 =A0: 6
> model =A0 =A0 =A0 =A0 =A0 : 23
> model name =A0 =A0 =A0: Intel(R) Core(TM)2 Quad CPU =A0 =A0Q9400 =A0@ 2.6=
6GHz
> stepping =A0 =A0 =A0 =A0: 10
> cpu MHz =A0 =A0 =A0 =A0 : 2664.000
> cache size =A0 =A0 =A0: 3072 KB
> physical id =A0 =A0 : 0
> siblings =A0 =A0 =A0 =A0: 4
> core id =A0 =A0 =A0 =A0 : 1
> cpu cores =A0 =A0 =A0 : 4
> apicid =A0 =A0 =A0 =A0 =A0: 1
> initial apicid =A0: 1
> fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
> fpu_exception =A0 : yes
> cpuid level =A0 =A0 : 13
> wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
> flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep m=
trr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
> lahf_lm tpr_shadow vnmi flexpriority
> bogomips =A0 =A0 =A0 =A0: 5343.00
> clflush size =A0 =A0: 64
> cache_alignment : 64
> address sizes =A0 : 36 bits physical, 48 bits virtual
> power management:
>
> processor =A0 =A0 =A0 : 2
> vendor_id =A0 =A0 =A0 : GenuineIntel
> cpu family =A0 =A0 =A0: 6
> model =A0 =A0 =A0 =A0 =A0 : 23
> model name =A0 =A0 =A0: Intel(R) Core(TM)2 Quad CPU =A0 =A0Q9400 =A0@ 2.6=
6GHz
> stepping =A0 =A0 =A0 =A0: 10
> cpu MHz =A0 =A0 =A0 =A0 : 2664.000
> cache size =A0 =A0 =A0: 3072 KB
> physical id =A0 =A0 : 0
> siblings =A0 =A0 =A0 =A0: 4
> core id =A0 =A0 =A0 =A0 : 2
> cpu cores =A0 =A0 =A0 : 4
> apicid =A0 =A0 =A0 =A0 =A0: 2
> initial apicid =A0: 2
> fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
> fpu_exception =A0 : yes
> cpuid level =A0 =A0 : 13
> wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
> flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep m=
trr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
> lahf_lm tpr_shadow vnmi flexpriority
> bogomips =A0 =A0 =A0 =A0: 5343.03
> clflush size =A0 =A0: 64
> cache_alignment : 64
> address sizes =A0 : 36 bits physical, 48 bits virtual
> power management:
>
> processor =A0 =A0 =A0 : 3
> vendor_id =A0 =A0 =A0 : GenuineIntel
> cpu family =A0 =A0 =A0: 6
> model =A0 =A0 =A0 =A0 =A0 : 23
> model name =A0 =A0 =A0: Intel(R) Core(TM)2 Quad CPU =A0 =A0Q9400 =A0@ 2.6=
6GHz
> stepping =A0 =A0 =A0 =A0: 10
> cpu MHz =A0 =A0 =A0 =A0 : 2664.000
> cache size =A0 =A0 =A0: 3072 KB
> physical id =A0 =A0 : 0
> siblings =A0 =A0 =A0 =A0: 4
> core id =A0 =A0 =A0 =A0 : 3
> cpu cores =A0 =A0 =A0 : 4
> apicid =A0 =A0 =A0 =A0 =A0: 3
> initial apicid =A0: 3
> fpu =A0 =A0 =A0 =A0 =A0 =A0 : yes
> fpu_exception =A0 : yes
> cpuid level =A0 =A0 : 13
> wp =A0 =A0 =A0 =A0 =A0 =A0 =A0: yes
> flags =A0 =A0 =A0 =A0 =A0 : fpu vme de pse tsc msr pae mce cx8 apic sep m=
trr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave
> lahf_lm tpr_shadow vnmi flexpriority
> bogomips =A0 =A0 =A0 =A0: 5343.03
> clflush size =A0 =A0: 64
> cache_alignment : 64
> address sizes =A0 : 36 bits physical, 48 bits virtual
> power management:
>

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
