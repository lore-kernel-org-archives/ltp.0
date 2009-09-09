Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MlH0Z-0000az-Ov
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 06:50:23 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MlH0M-0006c2-TF
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 06:50:18 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n896iCm8022003
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 00:44:12 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n896o5Ki198686
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 00:50:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n896o5kq018471
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 00:50:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA63CD6.2000300@redhat.com>
References: <4AA63CD6.2000300@redhat.com>
Date: Wed, 09 Sep 2009 12:19:52 +0530
Message-Id: <1252478994.5006.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] network: fix multicast testcases Makefile
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
To: Hushan Jia <hjia@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-09-08 at 19:15 +0800, Hushan Jia wrote: 
> Hi,
> The Makefile of testcases/network/multicast/mc_commo and mc_member do not link binary file and config files to ../../../bin dirs.
> This patch add the links.
> 
> Thanks&  Regards,
> Hushan
> 
> ---
> 
> network: Fix multicast testcases Makefile
> 
> Signed-off-by: Hushan Jia<hjia@redhat.com>

Sorry, they fail to apply. Please rebase against the latest CVS snapshot
and resend:

patching file testcases/network/multicast/mc_commo/Makefile
Hunk #1 FAILED at 8.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/network/multicast/mc_commo/Makefile.rej
patching file testcases/network/multicast/mc_member/Makefile
Hunk #1 FAILED at 8.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/network/multicast/mc_member/Makefile.rej

Regards--
Subrata

> 
> diff -Nrup ltp-full-20090831.orig/testcases/network/multicast/mc_commo/Makefile ltp-full-20090831/testcases/network/multicast/mc_commo/Makefile
> --- ltp-full-20090831.orig/testcases/network/multicast/mc_commo/Makefile	2009-08-31 13:16:03.000000000 +0800
> +++ ltp-full-20090831/testcases/network/multicast/mc_commo/Makefile	2009-09-08 18:45:37.000000000 +0800
> @@ -8,6 +8,8 @@ all: $(TARGETS)
> 
>   install:
>   	ln -f mc_commo ../../../bin
> +	ln -f mc_recv ../../../bin
> +	ln -f mc_send ../../../bin
> 
>   clean:
>   	rm -f $(TARGETS)
> diff -Nrup ltp-full-20090831.orig/testcases/network/multicast/mc_member/Makefile ltp-full-20090831/testcases/network/multicast/mc_member/Makefile
> --- ltp-full-20090831.orig/testcases/network/multicast/mc_member/Makefile	2009-08-31 13:16:03.000000000 +0800
> +++ ltp-full-20090831/testcases/network/multicast/mc_member/Makefile	2009-09-08 19:04:40.000000000 +0800
> @@ -8,6 +8,9 @@ all: $(TARGETS)
> 
>   install:
>   	ln -f mc_member ../../../bin
> +	ln -f member ../../../bin
> +	ln -f ManyGroups ../../../bin
> +	ln -f TooManyGroups ../../../bin
> 
>   clean:
>   	rm -f $(TARGETS)
> 
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
