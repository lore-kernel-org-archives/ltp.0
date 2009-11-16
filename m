Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N9wiw-00042x-18
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:14:10 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9wir-0002eH-8A
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:14:09 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAG8CpCq006734
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 01:12:51 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAG8Dxr8149820
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 01:13:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAG8Dwx2005212
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 01:13:59 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OFADCFBB49.BAA313D3-ON65257670.00168E44-65257670.0017980F@in.ibm.com>
References: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>
	<OFADCFBB49.BAA313D3-ON65257670.00168E44-65257670.0017980F@in.ibm.com>
Date: Mon, 16 Nov 2009 13:43:53 +0530
Message-Id: <1258359233.5677.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Power Management: Fix missing make targets.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, Poornima Nayak <Poornima.Nayak@in.ibm.com>

Garret,

Will you be fixing this ?

Regards--
Subrata

On Mon, 2009-11-16 at 09:49 +0530, Poornima Nayak wrote:
> Hi 
> 
> Patch to handle this issue was mailed on 20/8/2009. Garret Cooper had
> replied that makefile-infra-rework patch will take care of this
> requirement. If makefile-infra-rework patch is in this error should
> not have come up or makefile-rework-patch might have some issue. 
> 
> Anyway there was reply from maintainer, the patch which I had sent
> will be integrated till Garret Cooper's patch gets in. I am not sure
> how this issue would have come up. 
> I feel its better to check in this patch to avoid Power Management
> test case failures. 
> 
> Regards 
> Poornima 
> 
> 
> From: 
> sachinp@linux.vnet.ibm.com 
> To: 
> ltp-list@lists.sourceforge.net 
> Cc: 
> sachinp@linux.vnet.ibm.com 
> Date: 
> 11/12/2009 06:37 PM 
> Subject: 
> [LTP] [PATCH] Power Management: Fix
> missing make targets.
> 
> 
> ______________________________________________________________________
> 
> 
> 
> 
> Make sure required binaries used by the power management tests are
> compiled and
> installed properly. Without the required MAKE TARGETS the test fails
> with
> 
> <<<test_output>>>
> Are we really executing this ?
> /opt/ltp/testcases/bin/runpwtests.sh: line 57: check_kv_arch: command
> not found
> .....
> Power_Management    7  TPASS  :  CPUIDLE sysfs tests passed
> /opt/ltp/testcases/bin/runpwtests.sh: line 173: get_sched_values:
> command not
> found
> 
> Patch is against LTP October version.
> 
> Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
> ---
> diff -Naurp a/testcases/kernel/power_management/Makefile
> b/testcases/kernel/power_management/Makefile
> --- a/testcases/kernel/power_management/Makefile
> 2009-11-12 13:02:57.000000000 +0530
> +++ b/testcases/kernel/power_management/Makefile
> 2009-11-12 13:04:03.000000000 +0530
> @@ -26,6 +26,6 @@ $(eval $(call generate_vpath_rule,c,$(sr
> 
> INSTALL_TARGETS                                  := lib/*.py *.py *.sh
> 
> -MAKE_TARGETS                                  :=
> +MAKE_TARGETS                                  := check_kv_arch
> get_sched_values
> 
> include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
> 30-Day 
> trial. Simplify your report design, integration and deployment - and
> focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
