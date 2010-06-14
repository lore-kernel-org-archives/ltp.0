Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OO8sJ-0004Zq-H6
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:34:47 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OO8sH-0006On-1c
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:34:47 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5ECSNGc005439
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 08:28:23 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5ECYPwx113820
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 08:34:25 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o5ECbPPr015059
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:37:25 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1274440972.5471.6.camel@munipradeep-laptop>
References: <1274440972.5471.6.camel@munipradeep-laptop>
Date: Mon, 14 Jun 2010 18:04:17 +0530
Message-Id: <1276518858.4885.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for proc01 testcase
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2010-05-21 at 16:52 +0530, Munipradeep Beerakam wrote: 
> Hi,
> 
> We need to add the below entry 
> {"read", "/proc/powerpc/rtas/error_log", EINVAL},
> to the "Mapping known_issues[]" array, as the new kernels are
> having /proc/powerpc directory along with /proc/ppc64.
> 
> Attached the patch to this mail.

Thanks.

Regards--
Subrata

> 
> Please correct me if any thing is wrong.
> 
> Thanks
> Muni
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
