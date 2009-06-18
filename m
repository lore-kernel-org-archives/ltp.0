Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTA-0001P4-LX
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:12 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLT6-0007CL-8A
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:12 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHVO3V008232
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:31:24 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHW4Xw143070
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:32:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHW3u4026638
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:32:04 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A35264D.10800@bravegnu.org>
References: <4A35264D.10800@bravegnu.org>
Date: Thu, 18 Jun 2009 23:01:41 +0530
Message-Id: <1245346301.5041.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Using checkpatch.pl
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
To: Vijay Kumar <vijaykumar@bravegnu.org>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Send across a patch:
1) adding checkpatch.pl to LTP,
2) those instructions/future suggestions you have mentioned, update the
same in README.

Also remember to send patches against it in future when checkpatch.pl is
updated in the kernel tree itself.

Regards--
Subrata

On Sun, 2009-06-14 at 22:03 +0530, Vijay Kumar wrote: 
> Hi everyone,
> Michal Simek patched most of the LTP code base to use the Linux kernel
> coding style. But unfortunately new patches, that are flowing in, seem
> to add coding style violations. It is better to prevent new style
> violations than to fix them later on.
> 
> The kernel developers use a perl script called checkpatch.pl to
> identify style violations in patches. We could use the same script to
> check our patches, as well. The script uses files from the kernel to
> do kernel specific checks. This can be disabled by using the --no-tree
> option. So to check an LTP patch
> 
> $ checkpatch.pl --no-tree ltp-patch
> 
> If everybody is OK with it we can add the script to the LTP source
> tree, so that everyone checks their patches against the same
> script. And Subrata can easily check for style violations before
> merging the patch.
> 
> In the future, we could also customize the script to do userspace/LTP
> specific checks, like missing mode argument when open() is invoked
> with O_CREAT flag.
> 
> Please do send in your suggestions.
> 
> Regards,
> Vijay
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
