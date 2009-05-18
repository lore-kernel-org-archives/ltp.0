Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M64L8-0004cd-Eq
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 15:01:18 +0000
Received: from smtp100.biz.mail.re2.yahoo.com ([206.190.52.46])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M64L7-0000U3-35
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 15:01:18 +0000
Date: Mon, 18 May 2009 19:08:37 +0800 (CST)
Message-Id: <20090518.190837.229737820.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <d51f89b0905150450l6506055dr36337f6096d17e9a@mail.gmail.com>
References: <d51f89b0905130233r4e3b5bd4tfc3e4cae549e1194@mail.gmail.com>
	<20090513.234703.112605595.caiqian@cclom.cn>
	<d51f89b0905150450l6506055dr36337f6096d17e9a@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [LTP] Regarding ht_enable test case failure
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

Again, I am forwarding this to the mailing list, since I am not sure
about some questions either.

From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] Regarding ht_enable test case failure
Date: Fri, 15 May 2009 17:20:40 +0530

> Dear CAI Qian,
> 
> I am also trying to update HT_affinity also.
> 
> Issues:
> 
> function: HT_GetAffinity()
> 
> Line: mask1=get_porc_affinity(pid);
> 
> function, get_porc_affinity() returns error ; No such file or directory.
> 
> This is due the that this file eg. /proc/<pid>/affinity is not present in my
> system FC10.
> 
> Is it removed/changed?.
>

I am not familiar with it.
 
> Can you pls confirm that.
>

I can't find such files on both RHEL5 (2.6.18-128.el5) and Fedora
(2.6.27.5-117.fc10.i686) kernels.
 
> If it is removed/changed then we can simply compare the values of mask and
> mask2 or modify the the path.
> 
> Test is passed on my system after removing the same
> 

I don't have an IA-32 system with a HT capable processor at the moment.

> One more thing, system call sched_getaffinity returns 4.
> 
> It should return 0 or -1.
> 
> Is it bug in the kernel?.
> 

Or probably glibc? From the manpage,

RETURN VALUE
       On success, sched_setaffinity() and sched_getaffinity() return
       0.  On error, -1 is returned, and errno is set
       appropriately.RETURN VALUE

Looks like only -1 or 0 is valid here.

CAI Qian

> Thanks and Regards,
> Rohit
> 
> 
> On Wed, May 13, 2009 at 9:17 PM, CAI Qian <caiqian@cclom.cn> wrote:
> 
>> From: rohit verma <rohit.170309@gmail.com>
>> Subject: Re: [LTP] Regarding ht_enable test case failure
>> Date: Wed, 13 May 2009 15:03:39 +0530
>>
>> > Hi,
>> >
>> > I want to update HT_enable test case in LTP.
>> >
>> > *HT_enabled:*Test for whether HT enabling is the default setting and the
>> > kernel option works as expected.
>> >
>> > *Issue:* Reported as failed in my System. However /proc/cpuinfo shows two
>> > cpu and ht flag.
>> >
>>
>> If HT has been disabled in BIOS, you can still see the ht flag in
>> /proc/cpuinfo, so it is not enough to just look at it there. We have
>> looked at this before, and looks like the proper place to see if HT or
>> more generic term -- symmetrical multithreading (SMT) is sysfs (at least
>> for RHEL 5 kernels). There is a CPU topology information,
>>
>> /sys/devices/system/cpu/cpuX/topology/thread_siblings
>>
>> It looks like this,
>>
>> 00000001
>>
>> 00000002
>>
>> 00000008
>>
>> In all those case, It means there is no HT or SMT.
>>
>> If you see something like this,
>>
>> 00000003
>>
>> This one mean CPU0 and CPU1 are two threads in the same CPU core. This
>> is because the nth CPU id is,
>>
>> 2 raised to n.
>>
>> 3 = CPU0 (1) + CPU1 (2)
>>
>> There is also a tool to find out this information.
>>
>> lscpu from the latest utils-linux-ng package,
>> http://koji.fedoraproject.org/koji/packageinfo?packageID=4906
>>
>> > Can you pls tell me how to enable/disable hyperthreading in linux kernel.
>> I
>> > could not found proper document for the same.
>> >
>>
>> I am not sure if "noht" is still working. At least it has no effect in
>> RHEL5 kernel. Instead, it was suggested to use the following commands to
>> enable/disable it,
>>
>> From a public bug in Red Hat Bugzilla,
>> https://bugzilla.redhat.com/show_bug.cgi?id=440321
>>
>> "RHEL5 ships with CPU_HOTPLUG enabled.  This option allows a user to
>> disable and enable HW or HT cores.
>>
>> For example,
>>
>> I have a 4 cpu system with two HT processors.
>>
>> To disable the HT processors one can do:
>>
>> echo 0 > /sys/devices/system/node/node0/cpu1/online
>> echo 0 > /sys/devices/system/node/node0/cpu3/online
>>
>> You could write a system service script that does something similar to
>> (please note that this code is untested and is just a suggestion):
>>
>> grep noht /proc/cmdline
>>
>> if [ $? -eq 0 ]; then
>>     # noht specified on the command line, disabling HT cpus
>>     echo 0 > /sys/devices/system/node/node0/cpu1/online
>>     echo 0 > /sys/devices/system/node/node0/cpu3/online
>> fi
>> "
>>
>> > I also found that the check for kernel option "noht" is useless by
>> looking
>> > into code(HT_enabled.c).
>> >
>> > I think, we can remove that.
>>
>> I guess we can remove it if it is proved to be a dead option.
>>
>> CAI Qian
>>
>> >
>> > Regards,
>> >
>> > Rohit
>> >
>> > On Sat, Apr 11, 2009 at 2:25 PM, CAI Qian <caiqian@cclom.cn> wrote:
>> >>
>> >> Hi,
>> >>
>> >> --- On Mon, 3/30/09, rohit verma <rohit.170309@gmail.com> wrote:
>> >>
>> >>> From: rohit verma <rohit.170309@gmail.com>
>> >>> Subject: [LTP] Regarding ht_enable test case failure
>> >>> To: ltp-list@lists.sourceforge.net
>> >>> Date: Monday, March 30, 2009, 9:10 PM
>> >>> O/P:
>> >>>
>> >>>
>> >>> ht_enable    0  INFO  :
>> >>> Begin: HyperThreading Enabled
>> >>> ht_enable    0  INFO  :  The kernel boot paramter
>> >>> 'noht' is not set.
>> >>>
>> >>> ht_enable    1  FAIL  :  HT feature is not included
>> >>> in this Linux Kernel.
>> >>> ht_enable    0  INFO  :  End: HyperThreading Enabled
>> >>>
>> >>>
>> >>>
>> >>>
>> >>> but noht is for
>> >>> disabling
>> >>> hyperthreading.
>> >>>
>> >>>
>> >>>
>> >>> Function
>> >>> is_ht_kernel (file:
>> > testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c) checks for
>> >>> string cpu_package in /proc/cpuinfo
>> >>> .
>> >>>
>> >>>
>> >>>  but
>> >>> cpu_package string
>> >>>  information  does not exist in  /proc/cpuinfo for
>> >>> 2.6.29 kernel
>> >>>
>> >>
>> >> From the page,
>> >>
>> >>
>> >
>> https://lists.linux-foundation.org/pipermail/cgl_discussion/2002-October/002632.html
>> >>
>> >> looks like cpu_package has been added in 2.4.x kernel by HT patches.
>> >> Has this field been removed later? I can't see it with 2.6.18 kernel.
>> >>
>> >> I have copied the author of those tests - Sonic Zhang to see if he has
>> any
>> >> insight of it.
>> >>
>> >> Anyway, this piece of code seems check if the kernel has HT support or
>> > not.
>> >> I am not sure if we'll still need it, because HT support has been added
>> >> to kernel many years ago.
>> >>
>> >> CAI Qian
>> >>
>> >>>
>> >>>
>> >>>
>> >>> Regards,
>> >>> Rohit
>> >>>
>>

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
