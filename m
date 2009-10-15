Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MyRg9-0005kT-JY
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 14:51:45 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyRg4-0004EW-A6
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 14:51:45 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9FElnUA031734
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 10:47:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9FEpYso249420
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 10:51:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9FEpWXn011248
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 10:51:33 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910141207ucd102e5sa05d8f33e852fefa@mail.gmail.com>
References: <364299f40910141207ucd102e5sa05d8f33e852fefa@mail.gmail.com>
Date: Thu, 15 Oct 2009 20:21:15 +0530
Message-Id: <1255618275.5869.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Address a malloc failure, a typo,
	and an indent	issue in 	pan.c
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, 2009-10-14 at 12:07 -0700, Garrett Cooper wrote: 
> While trying to figure out why entries don't get entered in the exec
> log, I found the following issue with a malloc call. I also fixed a
> typo and a whacky indentation item as well.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Garret,

Please apply them directly to CVS:

patching file pan/ltp-pan.c
Hunk #1 succeeded at 337 with fuzz 2.
Hunk #2 FAILED at 402.
Hunk #3 FAILED at 748.
2 out of 3 hunks FAILED -- saving rejects to file pan/ltp-pan.c.rej

Regards--
Subrata

> 
> Index: pan/ltp-pan.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/pan/ltp-pan.c,v
> retrieving revision 1.3
> diff -u -r1.3 ltp-pan.c
> --- pan/ltp-pan.c       9 Jun 2009 16:14:40 -0000       1.3
> +++ pan/ltp-pan.c       14 Oct 2009 19:05:59 -0000
> @@ -337,6 +337,11 @@
> 
>      /* a place to store the pgrps we're watching */
>      running = (struct tag_pgrp *)malloc((keep_active + 1) *
> sizeof(struct tag_pgrp));
> +    if (running == NULL) {
> +        fprintf(stderr, "pan(%s): Failed to allocate memory: %s\n", panname,
> +                strerror(errno));
> +       exit(2);
> +    }
>      memset(running, 0, keep_active * sizeof(struct tag_pgrp));
>      running[keep_active].pgrp = -1;    /* end sentinel */
> 
> @@ -397,7 +402,7 @@
>      if (outputfilename) {
>         if (!freopen(outputfilename, "a+", stdout)) {
>             fprintf(stderr,
> -                   "pan(%s): Error %s (%d) openning output file '%s'\n",
> +                   "pan(%s): Error %s (%d) opening output file '%s'\n",
>                     panname, strerror(errno), errno, outputfilename);
>             exit(1);
>         }
> @@ -743,7 +748,7 @@
>                                                         w);
>                         }
> 
> -                               fflush(logfile);
> +                       fflush(logfile);
>                 }
> 
>                 if ((failcmdfile != NULL) && (w !=0)) {
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
