Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqCD-0004VZ-G5
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:29 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqCB-0000Jn-Pe
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:28 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07AxI9S004972
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 03:59:18 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o07B6FgC118138
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:06:15 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o07B6Ejh011269
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:06:15 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1261678498.12037.15.camel@localhost.localdomain>
References: <1261678498.12037.15.camel@localhost.localdomain>
Date: Thu, 07 Jan 2010 16:36:10 +0530
Message-Id: <1262862370.12213.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 0/4]Patches to enable Power Management
	testcases	to run on Power Platform
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
To: poornima nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, ssant@in.ibm.com, gautham <ego@in.ibm.com>, vaidy <svaidy@linux.vnet.ibm.com>, Arun <arun@linux.vnet.ibm.com>

Hi Poornima,

On Thu, 2009-12-24 at 23:44 +0530, poornima nayak wrote: 
> The existing Power Management testcases in LTP would run only on X
> machines. Subset of existing testcases in LTP can run on Power platform
> also. So modified some of the functions which is to learn topology of
> system from proc/cpuinfo to sysfs.
> Only runltp -f power_management_tests command has to be used for testing
> Power management features on Power platform. This command will only test
> interfaces
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Would you be resending the patches addressing the comments ?

Regards--
Subrata

> 
> Regards
> Poornima
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
