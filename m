Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O2Ivr-0003Co-46
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 06:52:11 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2Ivq-0001nW-7w
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 06:52:11 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3F6dwlB015497
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 02:39:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3F6q4PM053432
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 02:52:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3F6q4fm025441
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Apr 2010 03:52:04 -0300
Date: Thu, 15 Apr 2010 12:22:02 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100415065202.GB4557@linux.vnet.ibm.com>
References: <003201cadc47$a9bcec80$fd36c580$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <003201cadc47$a9bcec80$fd36c580$@co.jp>
Subject: Re: [LTP] [PATCH] fix \"ar\" test
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Thu, Apr 15, 2010 at 11:59:28AM +0900, Mitani wrote:
> Sorry.
> My patch was destroyed by e-mail.
> I attach patch for "ar01" file.

Applied to next branch. Will wait for someone to Acked/test it before merging to 
master.

Thanks
-Rishi

> 
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> 
> 
> Regards--
> 
> -Tomonori Mitani


> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
