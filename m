Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxexd-0002oS-AG
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:50:33 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxexX-0007MJ-3k
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:50:33 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DAmGX5011892
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:48:16 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DAoHmE179232
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:50:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DAoHM6013713
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:50:17 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AD3F376.9080506@redhat.com>
References: <4AD3F376.9080506@redhat.com>
Date: Tue, 13 Oct 2009 16:20:12 +0530
Message-Id: <1255431012.8438.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] network: fix rpc use rsh instead of ssh
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, 2009-10-13 at 11:26 +0800, Hushan Jia wrote: 
> Hello,
> 
> rpcinfo01 testcase use ssh to run command on remote machine, which will prompt for authentication
> and password.
> I think it is a typo because all network tests use rsh.
> 
> Thanks & Regards,
> Hushan
> 
> ---
> 
> network: fix rpc use rsh instead of ssh
> 
> Signed-off-by: Hushan Jia <hjia@redhat.com>

Thanks.

Regards--
Subrata

> 
> ---
> 
> --- ltp/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.orig	2009-10-13 10:52:59.000000000 +0800
> +++ ltp/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01	2009-10-13 10:54:51.000000000 +0800
> @@ -94,8 +94,8 @@ else
>  	fi
>  fi
> 
> -ssh -n $RHOST "ps -ewf" | grep portmap | grep -v grep > /dev/null
> -[ $? -eq 0 ] || ssh -n $RHOST "ps -ewf" | grep rpcbind | grep -v grep > /dev/null
> +rsh -n $RHOST "ps -ewf" | grep portmap | grep -v grep > /dev/null
> +[ $? -eq 0 ] || rsh -n $RHOST "ps -ewf" | grep rpcbind | grep -v grep > /dev/null
>  [ $? -eq 0 ] || end_testcase "The portmap or rpcbind daemon is NOT running on $RHOST"
> 
>  echo "Test rpcinfo with default options"
> 
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
