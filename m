Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M6Mdg-0005RE-Jd
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2009 10:33:40 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6Mdb-0002xY-EO
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2009 10:33:40 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4JATqOU008492
	for <ltp-list@lists.sourceforge.net>; Tue, 19 May 2009 04:29:52 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4JAWIc1211022
	for <ltp-list@lists.sourceforge.net>; Tue, 19 May 2009 04:32:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4JAWHAO011030
	for <ltp-list@lists.sourceforge.net>; Tue, 19 May 2009 04:32:18 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090518.191243.15248034.caiqian@cclom.cn>
References: <20090518.191243.15248034.caiqian@cclom.cn>
Date: Tue, 19 May 2009 16:02:14 +0530
Message-Id: <1242729134.5961.47.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Fw:  Regarding ht_enable test case failure
Reply-To: subrata@linux.vnet.ibm.com
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Well,

Here are the results pot patching:

ht_enable    0  INFO  :  Begin: HyperThreading Enabled
ht_enable    0  INFO  :  The kernel boot paramter 'noht' is not set.
ht_enable    1  FAIL  :  HT feature is not included in this Linux
Kernel.
ht_enable    0  INFO  :  End: HyperThreading Enabled

ht_affinity    0  INFO  :  Begin: HyperThreading Affinity
ht_affinity    1  CONF  :  HT is not enabled or not supported.
ht_affinity    2  CONF  :  Remaining cases not appropriate for
configuration
ht_affinity    3  CONF  :  Remaining cases not appropriate for
configuration
ht_affinity    0  INFO  :  End: HyperThreading Affinity

ht_interrupt    0  INFO  :  Begin: HyperThreading Interrupt
ht_interrupt    1  CONF  :  HT is not enabled or not supported.
ht_interrupt    0  INFO  :  End: HyperThreading Interrupt

# cat /sys/devices/system/cpu/cpu0/topology/thread_siblings
00000003
# cat /sys/devices/system/cpu/cpu1/topology/thread_siblings
00000003

# uname -a
Linux 2.6.27.19-5-default #1 SMP 2009-02-28 04:40:21 +0100 i686 i686
i386 GNU/Linux
# cat /etc/issue
Welcome to SUSE Linux Enterprise Server 11 (i586) - Kernel \r (\l).

Regards--
Subrata

On Mon, 2009-05-18 at 19:12 +0800, CAI Qian wrote: 
> Forwarding the patch from Rohit, so someone has an i386 system with HT
> capable processors may try it out.
> 
> CAI Qian
> email message attachment
> > -------- Forwarded Message --------
> > From: rohit verma <rohit.170309@gmail.com>
> > To: CAI Qian <caiqian@cclom.cn>
> > Subject: Re: [LTP] Regarding ht_enable test case failure
> > Date: Fri, 15 May 2009 18:25:35 +0530
> > 
> >  Hi, 
> >   
> > As written in the previous mail , I have modify some code. 
> >   
> > PFA the patch for HT_affinity.Test is Passed in my system. 
> >   
> > Kindly confirm that whether it is working fine on your system also. 
> >   
> >   
> > Regards, 
> > Rohit
> > 
> > 
> > On Fri, May 15, 2009 at 5:20 PM, rohit verma
> > <rohit.170309@gmail.com> wrote: 
> >         Dear CAI Qian, 
> >           
> >         I am also trying to update HT_affinity also. 
> >           
> >         Issues: 
> >           
> >         function: HT_GetAffinity() 
> >           
> >         Line: mask1=get_porc_affinity(pid); 
> >           
> >         function, get_porc_affinity() returns error ; No such file
> >         or directory. 
> >           
> >         This is due the that this file eg. /proc/<pid>/affinity is
> >         not present in my system FC10. 
> >           
> >         Is it removed/changed?. 
> >           
> >         Can you pls confirm that. 
> >           
> >         If it is removed/changed then we can simply compare the
> >         values of mask and mask2 or modify the the path. 
> >           
> >         Test is passed on my system after removing the same 
> >           
> >         One more thing, system call sched_getaffinity returns 4. 
> >           
> >         It should return 0 or -1. 
> >           
> >         Is it bug in the kernel?. 
> >           
> >         Thanks and Regards, 
> >         Rohit 
> >         
> >         
> >           
> >         On Wed, May 13, 2009 at 9:17 PM, CAI Qian <caiqian@cclom.cn>
> >         wrote: 
> >                 From: rohit verma <rohit.170309@gmail.com>
> >                 
> >                 Subject: Re: [LTP] Regarding ht_enable test case
> >                 failure 
> >                 Date: Wed, 13 May 2009 15:03:39 +0530
> >                 
> >                 
> >                 > Hi,
> >                 >
> >                 > I want to update HT_enable test case in LTP.
> >                 >
> >                 > *HT_enabled:*Test for whether HT enabling is the
> >                 default setting and the
> >                 > kernel option works as expected.
> >                 >
> >                 > *Issue:* Reported as failed in my System.
> >                 However /proc/cpuinfo shows two
> >                 > cpu and ht flag.
> >                 >
> >                 
> >                 
> >                 If HT has been disabled in BIOS, you can still see
> >                 the ht flag in
> >                 /proc/cpuinfo, so it is not enough to just look at
> >                 it there. We have
> >                 looked at this before, and looks like the proper
> >                 place to see if HT or
> >                 more generic term -- symmetrical multithreading
> >                 (SMT) is sysfs (at least
> >                 for RHEL 5 kernels). There is a CPU topology
> >                 information,
> >                 
> >                 /sys/devices/system/cpu/cpuX/topology/thread_siblings
> >                 
> >                 It looks like this,
> >                 
> >                 00000001
> >                 
> >                 00000002
> >                 
> >                 00000008
> >                 
> >                 In all those case, It means there is no HT or SMT.
> >                 
> >                 If you see something like this,
> >                 
> >                 00000003
> >                 
> >                 This one mean CPU0 and CPU1 are two threads in the
> >                 same CPU core. This
> >                 is because the nth CPU id is,
> >                 
> >                 2 raised to n.
> >                 
> >                 3 = CPU0 (1) + CPU1 (2)
> >                 
> >                 There is also a tool to find out this information.
> >                 
> >                 lscpu from the latest utils-linux-ng package,
> >                 http://koji.fedoraproject.org/koji/packageinfo?packageID=4906 
> >                 
> >                 > Can you pls tell me how to enable/disable
> >                 hyperthreading in linux kernel. I
> >                 > could not found proper document for the same.
> >                 >
> >                 
> >                 
> >                 I am not sure if "noht" is still working. At least
> >                 it has no effect in
> >                 RHEL5 kernel. Instead, it was suggested to use the
> >                 following commands to
> >                 enable/disable it,
> >                 
> >                 From a public bug in Red Hat Bugzilla,
> >                 https://bugzilla.redhat.com/show_bug.cgi?id=440321
> >                 
> >                 "RHEL5 ships with CPU_HOTPLUG enabled.  This option
> >                 allows a user to
> >                 disable and enable HW or HT cores.
> >                 
> >                 For example,
> >                 
> >                 I have a 4 cpu system with two HT processors.
> >                 
> >                 To disable the HT processors one can do:
> >                 
> >                 echo 0 > /sys/devices/system/node/node0/cpu1/online
> >                 echo 0 > /sys/devices/system/node/node0/cpu3/online
> >                 
> >                 You could write a system service script that does
> >                 something similar to
> >                 (please note that this code is untested and is just
> >                 a suggestion):
> >                 
> >                 grep noht /proc/cmdline
> >                 
> >                 if [ $? -eq 0 ]; then
> >                     # noht specified on the command line, disabling
> >                 HT cpus
> >                     echo 0
> >                 > /sys/devices/system/node/node0/cpu1/online
> >                     echo 0
> >                 > /sys/devices/system/node/node0/cpu3/online
> >                 fi 
> >                 "
> >                 
> >                 > I also found that the check for kernel option
> >                 "noht" is useless by looking
> >                 > into code(HT_enabled.c).
> >                 >
> >                 > I think, we can remove that.
> >                 
> >                 
> >                 I guess we can remove it if it is proved to be a
> >                 dead option.
> >                 
> >                 CAI Qian 
> >                 
> >                 
> >                 >
> >                 > Regards,
> >                 >
> >                 > Rohit
> >                 >
> >                 > On Sat, Apr 11, 2009 at 2:25 PM, CAI Qian
> >                 <caiqian@cclom.cn> wrote:
> >                 >>
> >                 >> Hi,
> >                 >>
> >                 >> --- On Mon, 3/30/09, rohit verma
> >                 <rohit.170309@gmail.com> wrote:
> >                 >>
> >                 >>> From: rohit verma <rohit.170309@gmail.com>
> >                 >>> Subject: [LTP] Regarding ht_enable test case
> >                 failure
> >                 >>> To: ltp-list@lists.sourceforge.net
> >                 >>> Date: Monday, March 30, 2009, 9:10 PM
> >                 >>> O/P:
> >                 >>>
> >                 >>>
> >                 >>> ht_enable    0  INFO  :
> >                 >>> Begin: HyperThreading Enabled
> >                 >>> ht_enable    0  INFO  :  The kernel boot
> >                 paramter
> >                 >>> 'noht' is not set.
> >                 >>>
> >                 >>> ht_enable    1  FAIL  :  HT feature is not
> >                 included
> >                 >>> in this Linux Kernel.
> >                 >>> ht_enable    0  INFO  :  End: HyperThreading
> >                 Enabled
> >                 >>>
> >                 >>>
> >                 >>>
> >                 >>>
> >                 >>> but noht is for
> >                 >>> disabling
> >                 >>> hyperthreading.
> >                 >>>
> >                 >>>
> >                 >>>
> >                 >>> Function
> >                 >>> is_ht_kernel (file:
> >                 >
> >                 testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c) checks for
> >                 >>> string cpu_package in /proc/cpuinfo
> >                 >>> .
> >                 >>>
> >                 >>>
> >                 >>>  but
> >                 >>> cpu_package string
> >                 >>>  information  does not exist in  /proc/cpuinfo
> >                 for
> >                 >>> 2.6.29 kernel
> >                 >>>
> >                 >>
> >                 >> From the page,
> >                 >>
> >                 >>
> >                 >
> >                 https://lists.linux-foundation.org/pipermail/cgl_discussion/2002-October/002632.html
> >                 >>
> >                 >> looks like cpu_package has been added in 2.4.x
> >                 kernel by HT patches.
> >                 >> Has this field been removed later? I can't see it
> >                 with 2.6.18 kernel.
> >                 >>
> >                 >> I have copied the author of those tests - Sonic
> >                 Zhang to see if he has any
> >                 >> insight of it.
> >                 >>
> >                 >> Anyway, this piece of code seems check if the
> >                 kernel has HT support or
> >                 > not.
> >                 >> I am not sure if we'll still need it, because HT
> >                 support has been added
> >                 >> to kernel many years ago.
> >                 >>
> >                 >> CAI Qian
> >                 >>
> >                 >>>
> >                 >>>
> >                 >>>
> >                 >>> Regards,
> >                 >>> Rohit
> >                 >>>
> >                 
> >         
> >         
> > 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


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
