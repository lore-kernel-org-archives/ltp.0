Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NILmA-00010p-DL
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 12:36:14 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NILm4-00059V-Ev
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 12:36:14 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB9C9FP7028243
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Dec 2009 07:09:15 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB9CE8Ab1183964
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Dec 2009 07:14:08 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB9CE8Ru013578
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Dec 2009 10:14:08 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A07801926FEF@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A07801926FEF@svexch01.mvista.com>
Date: Wed, 09 Dec 2009 17:44:02 +0530
Message-Id: <1260360842.6958.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] math/float/thread_code.c,
	revert previous patch	which added check for NaN
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, 2009-12-08 at 11:57 -0800, Henry Yei wrote: 
> Here is a patch that reverts the previous patch applied to
> thread_cod.c. Some of the float tests were reporting a failure where
> it detected the difference between the result and expected result was
> NaN(not a number).  As some of the results and expected results
> resolved to inf(infinity), the difference calculation would result in
> NaN.
> 
>  
> 
> With the previous patch, float_power and float_bessel tests were
> consistently failing on all architectures tried 
> 
>  
> 
> Signed-off by: Henry Yei <hyei@mvista.com>

Ok. Thanks.

Regards--
Subrata

> 
> 
>  
> 
> 
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
