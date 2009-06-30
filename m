Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLXzQ-0002RP-Dx
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:42:52 +0000
Received: from [32.97.182.138] (helo=e8.ny.us.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLXzM-00022W-TO
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:42:52 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7V9aM027675
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:31:09 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7fuHi256906
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:41:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7fuDg015771
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 03:41:56 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245346301.5041.36.camel@subratamodak.linux.ibm.com>
References: <4A35264D.10800@bravegnu.org>
	<1245346301.5041.36.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 13:11:03 +0530
Message-Id: <1246347663.4819.26.camel@subratamodak.linux.ibm.com>
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

Vijay,

Are you working on such a patch ?

Regards--
Subrata

On Thu, 2009-06-18 at 23:01 +0530, Subrata Modak wrote: 
> Send across a patch:
> 1) adding checkpatch.pl to LTP,
> 2) those instructions/future suggestions you have mentioned, update the
> same in README.
> 
> Also remember to send patches against it in future when checkpatch.pl is
> updated in the kernel tree itself.
> 
> Regards--
> Subrata
> 
> On Sun, 2009-06-14 at 22:03 +0530, Vijay Kumar wrote: 
> > Hi everyone,
> > Michal Simek patched most of the LTP code base to use the Linux kernel
> > coding style. But unfortunately new patches, that are flowing in, seem
> > to add coding style violations. It is better to prevent new style
> > violations than to fix them later on.
> > 
> > The kernel developers use a perl script called checkpatch.pl to
> > identify style violations in patches. We could use the same script to
> > check our patches, as well. The script uses files from the kernel to
> > do kernel specific checks. This can be disabled by using the --no-tree
> > option. So to check an LTP patch
> > 
> > $ checkpatch.pl --no-tree ltp-patch
> > 
> > If everybody is OK with it we can add the script to the LTP source
> > tree, so that everyone checks their patches against the same
> > script. And Subrata can easily check for style violations before
> > merging the patch.
> > 
> > In the future, we could also customize the script to do userspace/LTP
> > specific checks, like missing mode argument when open() is invoked
> > with O_CREAT flag.
> > 
> > Please do send in your suggestions.
> > 
> > Regards,
> > Vijay
> > 
> > ------------------------------------------------------------------------------
> > Crystal Reports - New Free Runtime and 30 Day Trial
> > Check out the new simplified licensing option that enables unlimited
> > royalty-free distribution of the report engine for externally facing 
> > server and web deployment.
> > http://p.sf.net/sfu/businessobjects
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
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
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
