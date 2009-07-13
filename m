Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MQGoE-0001kt-Mp
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 08:22:50 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MQGo9-0004aR-DN
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 08:22:50 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6D89Y4J015947
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2009 04:09:34 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6D8MiD2248912
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2009 04:22:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6D8KBsv007616
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2009 04:20:12 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A5AED18.2090201@cn.fujitsu.com>
References: <4A5AED18.2090201@cn.fujitsu.com>
Date: Mon, 13 Jul 2009 13:52:29 +0530
Message-Id: <1247473352.26478.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix "make clean"'s failure in case cpuset
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, 2009-07-13 at 16:15 +0800, Shi Weihua wrote:
> In case cpuset, the file cpuset_syscall_test.o was not deleted after "make clean".
> The following patch fixed this problem.
> 
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>

Garret,

If this is safe and does not interfere with your patches, please check
this in.

Regards--
Subrata

> ---
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile	2009-06-23 10:18:17.000000000 -0400
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile	2009-07-13 12:24:01.000000000 -0400
> @@ -8,7 +8,8 @@ all:cpuset_syscall_test
>  cpuset_syscall_test: %: %.o $(LIBOBJECTS)
> 
>  clean:
> -	rm -rf cpuset_syscall_test
> +	rm -rf cpuset_syscall_test cpuset_syscall_test.o
> +	rm -f $(LIBOBJECTS)
> 
>  install:
>  	@set -e; \
> 
> 
> 


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
