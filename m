Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nhxxj-0008HW-7D
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 04:26:03 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nhxxg-0003JD-U5
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 04:26:03 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1I4FFsW002411
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 23:15:15 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1I4PjVf1732678
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 23:25:45 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1I4PjmR022090
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 23:25:45 -0500
Date: Thu, 18 Feb 2010 09:55:32 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100218042532.GC13013@rishikesh.in.ibm.com>
References: <4B7BA24F.2010705@linux.vnet.ibm.com>
	<364299f41002170910i336abf6eh72acbcbec9b72e7b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002170910i336abf6eh72acbcbec9b72e7b@mail.gmail.com>
Subject: Re: [LTP] [PATCH] sysctl03: sysctl returns EACCES after 2.6.33-rc1
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
To: Garrett Cooper <yanegomi@gmail.com>, Shi Weihua <shiwh@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Feb 17, 2010 at 09:10:48AM -0800, Garrett Cooper wrote:
> On Wed, Feb 17, 2010 at 12:01 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
> > Hi Shi,
> >
> > Thanks for your patch, still i am finding time to look into your patch.
> > Will reply you soon.
> >
> > http://marc.info/?l=ltp-list&m=126502355614857&w=2
> 
> I looked at the patch finally.

Thanks garret.
> 
> Please use TTERRNO instead of strerror(...) for the reported value.
> There's no reason why you should use strerror(...) there as that's
> already done with tst_res(3).

Shi, can you please incorporate changes which garret has suggested and
resend the patch again to ltp-list@ .

Thanks for your support.
- Rishi

> Thanks,
> -Garrett

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
