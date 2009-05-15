Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M4sz1-0003z0-AQ
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 08:41:35 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4syz-0005XI-FQ
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 08:41:35 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4F8bEng006476
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 04:37:14 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4F8fUO5213462
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 04:41:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4F8dVPM029376
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 04:39:31 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A0D13F2.8030804@cn.fujitsu.com>
References: <4A0D13F2.8030804@cn.fujitsu.com>
Date: Fri, 15 May 2009 14:11:27 +0530
Message-Id: <1242376887.7224.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Synchronization between two processes
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
To: Serge Hallyn <serue@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-05-15 at 15:04 +0800, Gui Xiaohua wrote:
> The child-process wait SIGUSR1 which would be sended by parent-process,
> if the child-process execute sigtimedwait() after parent-process send 
> the signal, it would never receive the SIGUSR1 from parent-process.
> I cann't make sure the SIGUSR1 be sended after child-process execute 
> sigtimedwait() with 100 percent, and i try my best.
> 
> Signed-off-by: Gui Xiaohua <guixh@cn.fujitsu.com>

Over to Serge.

Regards--
Subrata

> --- testcases/kernel/containers/pidns/pidns12-old.c	2009-05-14 17:00:20.000000000 +0800
> +++ testcases/kernel/containers/pidns/pidns12.c	2009-05-15 15:15:22.000000000 +0800
> @@ -109,7 +109,7 @@ int child_fn(void *arg)
>  	}
> 
>  	/* Set timeout for sigtimedwait */
> -	timeout.tv_sec = 3;
> +	timeout.tv_sec = 10;
>  	timeout.tv_nsec = 0;
> 
>  	/* Set mask to wait for SIGUSR1 signal */
> @@ -182,6 +182,9 @@ int main(int argc, char *argv[])
>  		cleanup();
>  	}
> 
> +	/*Try best to make sure the SIGUSR1 be sended after child-process execute sigtimedwait*/
> +	sleep(5);
> +
>  	/* Send SIGUSR1 to container init */
>  	if (kill(cpid, SIGUSR1) == -1) {
>  		tst_resm(TBROK, "parent: kill() failed(%s).", strerror(errno));
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
