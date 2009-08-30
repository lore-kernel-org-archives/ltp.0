Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoMP-0005nP-M8
	for Ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:37 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoMK-00050s-Ot
	for Ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:37 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHYeiv029637
	for <Ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:34:40 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHcRoj227942
	for <Ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:38:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHcQT3019215
	for <Ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:38:26 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908281125160.31615@vixen.sonytel.be>
References: <alpine.LRH.2.00.0908281125160.31615@vixen.sonytel.be>
Date: Sun, 30 Aug 2009 23:07:10 +0530
Message-Id: <1251653832.12120.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] sched_cli_serv: Wait a bit before trying
	to	connect
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Fri, 2009-08-28 at 11:25 +0200, Geert Uytterhoeven wrote: 
> The sched_cli_serv test launches the server in the background and expects
> the client to be able to connect to it immediately. Depending on (earlier)
> system load, that may fail.
> Wait a bit before starting the client.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Ok.

Regards--
Subrata

> ---
>  testcases/kernel/sched/clisrv/run_sched_cliserv.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/sched/clisrv/run_sched_cliserv.sh b/testcases/kernel/sched/clisrv/run_sched_cliserv.sh
> index 68176c4..f063ebd 100755
> --- a/testcases/kernel/sched/clisrv/run_sched_cliserv.sh
> +++ b/testcases/kernel/sched/clisrv/run_sched_cliserv.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh -x
>  
>  pthserv &
> +sleep 5
>  pthcli 127.0.0.1 $LTPROOT/testcases/bin/data
>  clientCode=$?
>  killall pthserv


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
