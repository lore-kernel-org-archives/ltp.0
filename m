Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MATUL-0000uN-Oa
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 18:41:01 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MATUK-0000oA-CU
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 18:41:01 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4UIc6g3004752
	for <ltp-list@lists.sourceforge.net>; Sat, 30 May 2009 12:38:06 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4UIew1n252504
	for <ltp-list@lists.sourceforge.net>; Sat, 30 May 2009 12:40:58 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4UIewVL018460
	for <ltp-list@lists.sourceforge.net>; Sat, 30 May 2009 12:40:58 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A1FE470.6090400@in.ibm.com>
References: <4A1EC3AC.2080901@in.ibm.com>
	<1243601711.5188.40.camel@subratamodak.linux.ibm.com>
	<4A1FE470.6090400@in.ibm.com>
Date: Sun, 31 May 2009 00:10:54 +0530
Message-Id: <1243708854.5556.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Patch getcpu01 testcase
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, sharyath@in.ibm.com

On Fri, 2009-05-29 at 19:04 +0530, Suzuki Poulose wrote: 
> Subrata,
> 
> Good ! Then thats more suitable here :)
> 
> Refreshed the patch with TCONF and a better error message.

Thanks.

Regards--
Subrata

> 
> Thanks
> 
> Suzuki
> Subrata Modak wrote:
> > On Thu, 2009-05-28 at 22:32 +0530, Suzuki Poulose wrote:
> >> Hi,
> >>
> >> The getcpu01 always exits with a non-zero exit code (indicating a 
> >> Failure as per UNIX semantics) on non-NUMA machines.
> >>
> >> This is due to the following code :
> >>
> >>             tst_resm(TWARN,
> >>                     "/sys not mounted or not a numa system. Assuming
> >> one 
> >> node: %s",
> >>                          strerror(errno));
> >>
> >>
> >> Being a non-NUMA machine is not a failure, but an info. So it should
> >> not 
> >> cause the test to have a non zero exit status.
> > 
> > Correct,
> > 
> >> I have attached a patch which could do the same and provide a more 
> >> friendly o/p.
> >>
> >>
> >> Please apply.
> >>
> >> Thanks
> >> Suzuki
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >> plain text
> >> document
> >> attachment
> >> (fix-warning-getcpu01.diff)
> >>
> >>
> >> Index: ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c
> >> ===================================================================
> >> ---
> >> ltp-20081031.orig/testcases/kernel/syscalls/getcpu/getcpu01.c       2008-10-23 02:23:19.000000000 -0500
> >> +++
> >> ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c    2009-05-28
> >> 11:52:54.000000000 -0500
> >> @@ -47,6 +47,8 @@
> >>   * HISTORY
> >>   *     06/2008 written by Sharyathi Nagesh <sharyathi@in.ibm.com>
> >>   *
> >> + *     05/2009         Suzuki K P <suzuki@in.ibm.com>
> >> + *                     Friendly messages for non-NUMA machines.
> >>   * RESTRICTIONS
> >>   *     none
> >>   */
> >> @@ -234,8 +236,10 @@
> >>
> >>          directory_parent = opendir("/sys/devices/system/node");
> >>          if (!directory_parent)  {
> >> -                tst_resm(TWARN,
> >> -                   "/sys not mounted or not a numa system. Assuming
> >> one node: %s",
> >> +                tst_resm(TINFO,
> >> +                        "/sys not mounted or not a numa system.
> >> Assuming one node");
> >> +               tst_resm(TINFO,
> > 
> > Use TCONF instead of TINFO. That reflects that some system configuration
> > was missing, and, it will not return error value at all.
> > 
> > Regards--
> > Subrata
> > 
> >> +                       "Reason /sys/devices/system/node :%s",
> >>                          strerror(errno));
> >>                         return 0; //By Default assume it to belong to
> >> node Zero 
> >>          } else {
> >>
> > 
> 
> plain text document attachment (fix-warning-getcpu01.diff)
> Index: ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c
> ===================================================================
> --- ltp-20081031.orig/testcases/kernel/syscalls/getcpu/getcpu01.c	2008-10-23 02:23:19.000000000 -0500
> +++ ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c	2009-05-29 08:33:01.000000000 -0500
> @@ -47,6 +47,9 @@
>   * HISTORY
>   *	06/2008 written by Sharyathi Nagesh <sharyathi@in.ibm.com>
>   *
> + *	05/2009 	Suzuki K P <suzuki@in.ibm.com>
> + *			Use TCONF instead of TWARN for non-NUMA machines
> + *	
>   * RESTRICTIONS
>   *	none
>   */
> @@ -234,8 +237,10 @@
> 
>          directory_parent = opendir("/sys/devices/system/node");
>          if (!directory_parent)  {
> -                tst_resm(TWARN,
> -                   "/sys not mounted or not a numa system. Assuming one node: %s",
> +                tst_resm(TCONF,
> +                   "/sys not mounted or not a numa system. Assuming one node");
> +		tst_resm(TCONF,
> +			"Error opening: /sys/devices/system/node :%s",
>                          strerror(errno));
>                 	return 0; //By Default assume it to belong to node Zero 
>          } else {


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
