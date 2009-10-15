Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MyT7Z-0007La-3f
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 16:24:09 +0000
Date: Thu, 15 Oct 2009 18:23:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091015162356.GB4152@schrodinger.suse.cz>
References: <20091014115618.7801.69877.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091014115618.7801.69877.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Re: compile fails for libcpuset.c on
	SLES-11	s390x with ltp-full-20090930
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>, Mark Ver <markver@us.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>

Hi!
> --- ltp-intermediate-20091013/testcases/kernel/include/s390x.in.orig	2009-10-14 17:14:39.000000000 +0530
> +++ ltp-intermediate-20091013/testcases/kernel/include/s390x.in	2009-10-14 17:15:26.000000000 +0530
> @@ -14,3 +14,6 @@ fchmodat (__NR_openat + 11)
>  faccessat (__NR_openat + 12)
>  eventfd 318
>  fallocate 314
> +get_mempolicy 269
> +set_mempolicy 270

This should fix it. Anyway, I have some more architectures that are broken on
sles9.  Will send patch soon.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
