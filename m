Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NHcAj-0002jq-6L
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 11:54:33 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NHcAb-00086Y-VX
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 11:54:33 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB7Bptvk007850
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Dec 2009 04:51:55 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB7BsFlj114390
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Dec 2009 04:54:15 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB7BsFHR015303
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Dec 2009 04:54:15 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1260121579.7556.487.camel@rado-desktop>
References: <1260121579.7556.487.camel@rado-desktop>
Date: Mon, 07 Dec 2009 17:24:04 +0530
Message-Id: <1260186844.6866.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] if4-alias-addlarge - default values
	for	IPV4_NETWORK and	IPV4_HOST
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
To: Radoslav Kolev <radoslav.kolev@rnd.bg>
Cc: ltp-list@lists.sourceforge.net

On Sun, 2009-12-06 at 19:46 +0200, Radoslav Kolev wrote: 
> The testcase code expects class A (or /8 ) network addresses to be
> assigned to the tested interfaces and fails with the default values of
> class C (or /24).
> 
> Signed-off-by: Radoslav Kolev <radoslav.kolev@rnd.bg>

Thanks.

Regards--
Subrata

> 
> --- ltp-full-20091031.orig/testcases/network/stress/interface/if4-alias-addlarge	2009-11-18 11:41:02.000000000 +0200
> +++ ltp-full-20091031/testcases/network/stress/interface/if4-alias-addlarge	2009-12-06 19:31:34.000000000 +0200
> @@ -72,7 +72,7 @@
>  LINK_NUM=0
> 
>  # Network portion of the IPv4 address
> -IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
> +IPV4_NETWORK=${IPV4_NETWORK:-"10"}
> 
>  # Netmask of for the tested network
>  IPV4_NETMASK="255.0.0.0"
> @@ -82,8 +82,8 @@
>  IPV4_BROADCAST=${IPV4_NETWORK}.255.255.255
> 
>  # Host portion of the IPv4 address
> -LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
> -RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
> +LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"0.0.2"}
> +RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"0.0.1"}
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Join us December 9, 2009 for the Red Hat Virtual Experience,
> a free event focused on virtualization and cloud computing. 
> Attend in-depth sessions from your desk. Your couch. Anywhere.
> http://p.sf.net/sfu/redhat-sfdev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
