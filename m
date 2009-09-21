Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MpleI-000890-5F
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:21:58 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MpleA-0000i0-8O
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:21:57 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8LGHhBq028366
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 10:17:43 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8LGLRfH160010
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 10:21:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8LGLQqO002502
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 10:21:26 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090921072453.7307.96056.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
	<20090921072453.7307.96056.sendpatchset@localhost.localdomain>
Date: Mon, 21 Sep 2009 21:50:28 +0530
Message-Id: <1253550030.6736.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 2/6] To fix issue in get_sched_values
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

On Mon, 2009-09-21 at 12:54 +0530, Poornima Nayak wrote: 
> get_sched_values was returning 1 & 0 instead of max sched_mc & max sched_smt.
> This patch fixes the issue in the first version of this file.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090831/testcases/kernel/power_management/get_sched_values.c ltp-full-20090831_patched/testcases/kernel/power_management/get_sched_values.c
> --- ltp-full-20090831/testcases/kernel/power_management/get_sched_values.c	2009-08-31 10:45:45.000000000 +0530
> +++ ltp-full-20090831_patched/testcases/kernel/power_management/get_sched_values.c	2009-09-21 12:27:01.528978103 +0530
> @@ -40,14 +40,8 @@ int main(int argc, char **argv)
>  	{
>  		param = argv[1];
>  		if (strcmp(param, "sched_mc")==0)
> -			if (get_supp_sched_mc() == 0)
> -				return 0;
> -			else
> -				return 1;
> +			return (get_supp_sched_mc());
>  		if (strcmp(param, "sched_smt")==0)
> -                        if (get_supp_sched_smt() == 0)
> -                                return 0;
> -                        else
> -                                return 1;
> +                        return (get_supp_sched_smt());
>  	}
>  }
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
