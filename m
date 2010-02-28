Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NlnfO-0008DF-5b
	for ltp-list@lists.sourceforge.net; Sun, 28 Feb 2010 18:14:58 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NlnfM-0004ne-Uz
	for ltp-list@lists.sourceforge.net; Sun, 28 Feb 2010 18:14:58 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1SI3nAY024676
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 13:03:49 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1SIEoOF164800
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 13:14:50 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1SIEo7A017908
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 13:14:50 -0500
Date: Sun, 28 Feb 2010 23:44:45 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100228181445.GB4850@linux.vnet.ibm.com>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
	<20100111162256.GB19010@saboteur.suse.cz>
	<20100128041619.GB16209@malik-laptop.in.ibm.com>
	<d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
	<364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
	<d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
	<d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
	<364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed by
 the topmost memory cgroup
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
To: Garrett Cooper <yanegomi@gmail.com>, i@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

>>Rishi, are we ready=A0for commit?

Yes committed to next branch, let me test for any regression, and then
will commit to maint/master branch.

Thanks
-Rishi
On Sat, Feb 27, 2010 at 12:24:58PM -0800, Garrett Cooper wrote:

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
