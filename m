Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NlxG4-00042Q-Bt
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 04:29:28 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NlxG3-0006EO-AS
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 04:29:28 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o214QTMC005232
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 21:26:29 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o214TKQ6116080
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 21:29:20 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o214TKpk030066
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 21:29:20 -0700
Date: Mon, 1 Mar 2010 09:59:18 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100301042918.GA2758@linux.vnet.ibm.com>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
	<20100111162256.GB19010@saboteur.suse.cz>
	<20100128041619.GB16209@malik-laptop.in.ibm.com>
	<d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
	<364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
	<d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
	<d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
	<364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
	<20100228181445.GB4850@linux.vnet.ibm.com>
	<d270b4401002281837x589df62ds4ce246066c3d9442@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d270b4401002281837x589df62ds4ce246066c3d9442@mail.gmail.com>
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
To: Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Mar 01, 2010 at 08:07:50AM +0530, Mohamed Naufal wrote:
> On 28 February 2010 23:44, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> >>>Rishi, are we ready=A0for commit?
> >
> > Yes committed to next branch, let me test for any regression, and then
> > will commit to maint/master branch.
> >
> >
> =

> [...]
> =

> Hi
> =

> The new source files in my patch doesn't appear in the next branch.

HI Naufal,

can you please clone with -b <branchname> ?

e.g: git clone -b next
git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp

And let me know that your patch is in. I can see it as commit:
3bc8ecdb69b29436e2987173ffdd7244d8897942

Thanks
Rishi

> =

> Naufal

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
