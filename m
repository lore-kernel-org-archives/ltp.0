Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NhxWp-0007DJ-T9
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 03:58:15 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhxWo-0004oT-Ik
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 03:58:15 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1I3ifit002725
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 22:44:41 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1I3w8kZ111204
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 22:58:08 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1I3w8ee016037
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 22:58:08 -0500
Date: Thu, 18 Feb 2010 09:27:56 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100218035756.GA13013@rishikesh.in.ibm.com>
References: <4B7BA433.3030206@linux.vnet.ibm.com>
	<364299f41002170908p302cc665g874c89a109ddfd1f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002170908p302cc665g874c89a109ddfd1f@mail.gmail.com>
Subject: Re: [LTP] [PATCH] mail_tests.sh: fix a version problem of Heirloom
 Mail
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

On Wed, Feb 17, 2010 at 09:08:39AM -0800, Garrett Cooper wrote:
> On Wed, Feb 17, 2010 at 12:09 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
> > Hi Shi,
> >
> > Thanks for your patch . It will be merged in feb 2010 release.
> >
> > Acked-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> >
> > http://marc.info/?l=ltp-list&m=126440546415559&w=2
> 
> There's a lot of noise in the patch because of if-else behavior in
> trying to determine the mail app. That's why I didn't commit this (it
> requires verification of previous mail applications as well).

Thanks Garret, Still i have not committed this to CVS repo.

Shi, can you please verify if this patch does not break with any other
mail application.

Thanks for your support.
-Rishi
> 
> The mail test should be resistant to changes like these as a lot of
> developers in the FOSS community have different opinions on how to do
> things and don't follow any particular standard. This `heirloom mailx'
> support is just one said example that needs to be fixed.
> 
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
