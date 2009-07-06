Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqTu-0002r5-PV
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:50 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqTu-0002dr-Ah
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:50 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A51CEDC.6080605@linux.vnet.ibm.com>
References: <4A51CEDC.6080605@linux.vnet.ibm.com>
Date: Mon, 06 Jul 2009 21:21:07 +0530
Message-Id: <1246895467.4887.56.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
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
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

On Mon, 2009-07-06 at 15:45 +0530, gowrishankar wrote: 
> Hi Subrata,
> Please accept the patch below.
> 
> Thanks,
> Gowri
> ---
> cgroups: conditionally enable building cgroup tests
> 
> controllers tests gets included into default ltp build if "/proc/cgroup"
> exists. It stops the ltp build in realtime kernel environment where kernel
> is new and supports cgroups, but necessary file "linux/cgroupstats.h" may not
> exist in the base OS (like RHEL5.3). So configure command enables the build,
> but actual build fails, due to missing header file.
> 
> Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for header file
> "linux/cgroupstats.h" and include controllers in the list of tests to build.
> 
> Tested the patch in non-RT as well as RT environment for the changes.
> 
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Thanks Gowri.

Regards--
Subrata

> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> ---
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
