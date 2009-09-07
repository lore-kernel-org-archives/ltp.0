Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MkcaU-0003VO-0H
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:40:46 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MkcaN-000858-VR
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:40:45 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87Be7lU027198
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:40:07 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87BeYQg249250
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:40:34 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87BeY5B028413
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:40:34 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A9F8AE9.300@redhat.com>
References: <4A9F8AE9.300@redhat.com>
Date: Mon, 07 Sep 2009 17:10:08 +0530
Message-Id: <1252323623.4922.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] network: Fix iproute test case error
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

On Thu, 2009-09-03 at 17:22 +0800, Hushan Jia wrote: 
> Hello,
> 
> When I run network test case testcases/network/iproute/ip_tests.sh, some errors shown:
> ip01        0  TINFO  :  Test #1: changing mtu size of eth0:1 device.
> /mnt/ltp/ltp-full-20090731/testcases/bin/ip_tests.sh: line 198: [: -eq: unary operator expected.
> 
> The output of
> ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://"
> is like:
> 1500  Metric:1
> so should print field 1 instead of field 5.
> 
> Thanks&  Regards,
> Hushan
> 
> ---
> 
> network: Fix iproute test case error
> 
> Signed-off-by: Hushan Jia<hjia@redhat.com>

Hey, Thanks.

Regards--
Subrata

> diff -Nrup ltp-full-20090831-orig/testcases/network/iproute/ip_tests.sh ltp-full-20090831/testcases/network/iproute/ip_tests.sh
> --- ltp-full-20090831-orig/testcases/network/iproute/ip_tests.sh	2009-09-03 16:47:56.000000000 +0800
> +++ ltp-full-20090831/testcases/network/iproute/ip_tests.sh	2009-09-03 16:51:04.000000000 +0800
> @@ -194,7 +194,7 @@ test01()
>   			"Test #1: ip command failed. Reason: "
>   		return $RC
>   	else
> -		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $5}'`
> +		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $1}'`
>   		if [ $MTUSZ -eq 300 ]
>   		then
>   			tst_resm TPASS "Test #1: changing mtu size success"
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
