Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxeNB-0001Cc-Pf
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:12:53 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxeN7-0003bQ-Tl
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:12:53 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DA5AgN012072
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:05:10 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DACieA255356
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:12:44 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DAChas018101
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:12:44 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091013074423.22414.52234.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
	<20091013074423.22414.52234.sendpatchset@localhost.localdomain>
Date: Tue, 13 Oct 2009 15:42:35 +0530
Message-Id: <1255428755.8438.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 6/6] Patch to fix workload installation issue
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

On Tue, 2009-10-13 at 13:14 +0530, Poornima Nayak wrote: 
> Patch to fix workload installation issue
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

This will not apply as all the LTP Makefiles has undergon huge changes.
Checkout the latest LTP and re-create this patch:

Hunk #1 FAILED at 27.
1 out of 1 hunk FAILED -- saving rejects to file utils/Makefile.rej

Regards--
Subrata

> 
> diff -uprN ltp-full-20090930/utils/Makefile ltp-full-20090930_patched/utils/Makefile
> --- ltp-full-20090930/utils/Makefile	2009-10-05 02:10:46.000000000 -0400
> +++ ltp-full-20090930_patched/utils/Makefile	2009-10-12 22:48:30.000000000 -0400
> @@ -27,6 +27,6 @@ all: configure
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
> 
>  install:
> -
> +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
>  clean:
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
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
