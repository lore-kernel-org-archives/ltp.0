Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MyRgR-0006Sp-IX
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 14:52:03 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyRgJ-0004JL-UB
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 14:52:03 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9FEoU1G018238
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 10:50:30 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9FEpox7146834
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 10:51:50 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9FEped1009723
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 08:51:40 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910141125p113a6d28va6289a10bb8574da@mail.gmail.com>
References: <364299f40910141125p113a6d28va6289a10bb8574da@mail.gmail.com>
Date: Thu, 15 Oct 2009 20:21:19 +0530
Message-Id: <1255618279.5869.18.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Move `creating ... directory' to block where
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

On Wed, 2009-10-14 at 11:25 -0700, Garrett Cooper wrote: 
> We shouldn't say that we're creating the directory unless we are
> actually creating the directory. This only leads to potential
> confusion with LTP newbies.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

This applied perfectly fine. Thanks.

Regards--
Subrata

> 
> Index: runltp
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runltp,v
> retrieving revision 1.51
> diff -u -r1.51 runltp
> --- runltp      13 Oct 2009 12:10:13 -0000      1.51
> +++ runltp      14 Oct 2009 18:23:29 -0000
> @@ -456,9 +456,9 @@
>      # If we need, create the output directory
>      [ "$ALT_DIR_OUT" -eq 1 ] && \
>      {
> -        echo "INFO: creating $LTPROOT/output directory"
>          [ ! -d $LTPROOT/output ] && \
>          {
> +           echo "INFO: creating $LTPROOT/output directory"
>             mkdir -p $LTPROOT/output || \
>             {
>                 echo "ERROR: failed to create $LTPROOT/output"
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
