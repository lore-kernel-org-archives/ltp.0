Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryHF-0005g5-Aa
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:17 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryH8-0001Hz-1a
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:17 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RI8pAA012824
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:08:51 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIF3Dj227192
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIF3EB024161
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:03 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4ABB2C98.4090403@redhat.com>
References: <4ABB2C98.4090403@redhat.com>
Date: Sun, 27 Sep 2009 23:44:53 +0530
Message-Id: <1254075295.10457.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] network: fix nfs testcases Makefile error
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

On Thu, 2009-09-24 at 16:23 +0800, Hushan Jia wrote: 
> Hi,
> 
> The nfslock01 and nfsstress testcases' Makefile does not link excutables to testcase/bin
> directory, and nfslock01 does not build nfs_flock_dgen excutables, which will cause test fail.
> This patch add the links and build the nfs_flock_dgen.
> 
> Thanks & Regards,
> Hushan
> 
> ---
> 
> network: fix nfslock01 and nfsstress Makefile error
> 
> Signed-off-by: Hushan Jia <hjia@redhat.com>

Thanks.

Regards--
Subrata

> 
> --- ltp/testcases/network/nfs/nfslock01/Makefile.orig	2009-09-24 15:54:24.000000000 +0800
> +++ ltp/testcases/network/nfs/nfslock01/Makefile	2009-09-24 15:58:31.000000000 +0800
> @@ -5,6 +5,7 @@ all: $(TESTS)
> 
>  install:
>  	ln -f nfslock01 ../../../bin
> +	ln -f $(TESTS) ../../../bin
> 
>  nfs_flock:
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o nfs_flock nfs_flock.c nfs_flock_func.c
> @@ -12,6 +13,9 @@ nfs_flock:
>  nfs_flock_frk:
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o nfs_flock_frk nfs_flock_frk.c
> 
> +nfs_flock_dgen:
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o nfs_flock_dgen nfs_flock_dgen.c
> +
>  clean:
>  	rm -f $(TESTS)
> 
> --- ltp/testcases/network/nfs/nfsstress/Makefile.orig	2009-09-24 15:54:12.000000000 +0800
> +++ ltp/testcases/network/nfs/nfsstress/Makefile	2009-09-24 15:59:58.000000000 +0800
> @@ -8,6 +8,7 @@ all: $(TARGETS)
> 
>  install:
>  	ln -f nfsstress ../../../bin
> +	ln -f $(TARGETS) ../../../bin
> 
>  clean:
>  	rm -f $(TARGETS)


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
