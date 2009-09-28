Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MsFvw-0004aE-5J
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 13:06:28 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MsFvp-0008VP-88
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 13:06:27 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8SCun8x023450
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2009 08:56:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8SD60CB246544
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2009 09:06:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8SD2gmI002229
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2009 09:02:43 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AC070E6.8000403@bull.net>
References: <4AC070E6.8000403@bull.net>
Date: Mon, 28 Sep 2009 18:35:51 +0530
Message-Id: <1254143152.5035.5.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] resent patch for fs_di TestCase
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
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-09-28 at 10:16 +0200, Jacky Malcles wrote: 
> Hi Subrata,
> 
> this should apply (I did a try)
> 
> [root@xena3 ltp-full-20090831]# patch -p0 < patch.bis
> patching file testcases/kernel/fs/fs_di/fs_di
> [root@xena3 ltp-full-20090831]#
> 
> regards,
> 

Thanks.

Regards--
Subrata

> -------------------------------------------------------------------------
> 
> diff -uprN testcases/kernel/fs/fs_di/fs_di.orig
> testcases/kernel/fs/fs_di/fs_di
> --- testcases/kernel/fs/fs_di/fs_di.orig        2009-08-31
> 07:15:46.000000000 +0200
> +++ testcases/kernel/fs/fs_di/fs_di     2009-09-28 10:07:22.000000000 +0200
> @@ -95,7 +95,6 @@ $trace_logic
>      if [ "$CLEANUP" = "ON" ]; then
>         rm -rf $TCtmp
>         rm -rf ${TESTFS}
> -       rm -rf $TMPBASE/*
>          rm -f $TCtmp/testfile*
>      fi
> 
> 
> 


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
