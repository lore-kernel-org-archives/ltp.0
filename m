Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqTC-00059T-4K
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:06 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqTB-0002TW-Jb
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:06 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n66FhEbd005337
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:43:14 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n66Fosl8252820
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:50:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n66FonjM015534
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:50:49 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090702084828.GC19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
Date: Mon, 06 Jul 2009 21:20:40 +0530
Message-Id: <1246895440.4887.48.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/4] netns: Report version of iproute2 tools
	in	ver_linux
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

On Thu, 2009-07-02 at 01:48 -0700, Matt Helsley wrote: 
> Report the version of the ip route tools in ver_linux with ip -V. The
> version is important to the netns testcases for example. Since it would
> be useful for other testcases add it to the ver_linux script.
> 
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

Thanks Matt.

Regards--
Subrata

> Cc: Daniel Lezcano <daniel.lezcano@free.fr>
> Cc: Poornima Nayak <poornima.nayak@in.ibm.com>
> Cc: Sudhir Kumar <skumar@linux.vnet.ibm.com>
> Cc: Veerendra C <vechandr@in.ibm.com>
> Cc: Munipradeep <mbeeraka@in.ibm.com>
> Cc: ltp@list.sourceforge.net
> 
> ---
>  ver_linux |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: ltp/ver_linux
> ===================================================================
> --- ltp.orig/ver_linux
> +++ ltp/ver_linux
> @@ -62,6 +62,9 @@ ps --version 2>&1 | awk 'NR==1{print "Pr
>  ifconfig --version 2>&1 | grep tools | awk \
>  'NR==1{print "Net-tools             ", $NF}'
> 
> +ip -V 2>&1 | awk \
> +'NR==1{print "iproute2             ", $NF}'
> +
>  # Kbd needs 'loadkeys -h',
>  loadkeys -h 2>&1 | awk \
>  '(NR==1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
