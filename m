Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NkXBJ-0007To-4M
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 06:26:41 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NkXBI-0005ss-45
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 06:26:41 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1P6OswU017499
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Feb 2010 23:24:54 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1P6QJSP174890
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Feb 2010 23:26:19 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1P6QJV0012007
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Feb 2010 23:26:19 -0700
Date: Thu, 25 Feb 2010 11:56:15 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100225062615.GB3377@linux.vnet.ibm.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
Subject: Re: [LTP] [patch] swapon03 cleanup v2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
> On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
> > Added clean_swap() to cleanup routine. =A0This makes sure all leftover =
swap files are removed.
> >
> > Signed-off-By: =A0Murlin Ray Wenzel mwenzel@novell.com
> =

> Committed -- thanks!
> -Garrett

Thanks Garret & Murlin.

-Rishi
> =

> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- =

Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
