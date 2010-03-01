Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nlz7I-0007nt-SV
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 06:28:32 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nlz7H-0002Mb-QX
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 06:28:32 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o216OM7K002058
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 01:24:22 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o216SQPg1876126
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 01:28:26 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o216SP94024909
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 03:28:25 -0300
Date: Mon, 1 Mar 2010 11:58:21 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100301062821.GC3860@linux.vnet.ibm.com>
References: <20100111162256.GB19010@saboteur.suse.cz>
	<20100128041619.GB16209@malik-laptop.in.ibm.com>
	<d270b4401002202353pec0431w4a2bb947544ff444@mail.gmail.com>
	<364299f41002261213q24890454jac60233bd8f92ded@mail.gmail.com>
	<d270b4401002270505n59e448eev69b6f7b263ecd61d@mail.gmail.com>
	<d270b4401002270606y1f695cc8u3afaefb8b722528c@mail.gmail.com>
	<364299f41002271224x2aef49b0i4079babd986403e7@mail.gmail.com>
	<20100228181445.GB4850@linux.vnet.ibm.com>
	<d270b4401002281837x589df62ds4ce246066c3d9442@mail.gmail.com>
	<20100301052100.GA3860@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100301052100.GA3860@linux.vnet.ibm.com>
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

On Mon, Mar 01, 2010 at 10:51:00AM +0530, Rishikesh K Rajak wrote:
> On Mon, Mar 01, 2010 at 08:07:50AM +0530, Mohamed Naufal wrote:
> > On 28 February 2010 23:44, Rishikesh K Rajak
> > <risrajak@linux.vnet.ibm.com> wrote:
> > >>>Rishi, are we ready=A0for commit?
> > >
> > > Yes committed to next branch, let me test for any regression, and then
> > > will commit to maint/master branch.
> > >
> > >
> > =

> > [...]
> > =

> > Hi
> > =

> > The new source files in my patch doesn't appear in the next branch.
> =

> =

> Something really has got screwed with your patch can you please resend
> your patch against next branch as attachment ?

ahhh !!! got the problem. Your patch seems to be taken as wrong diff for
new source file addition, so it will never add the new source file.

For new file it should be always /dev/null , but your patch reflects
something else as(Here Makefile is newly created by you):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff -Naru ltpv/testcases/kernel/controllers/memcg/control/Makefile
ltpd/testcases/kernel/controllers/memcg/control/Makefile
--- ltpv/testcases/kernel/controllers/memcg/control/Makefile
1970-01-01 05:30:00.000000000 +0530
+++ ltpd/testcases/kernel/controllers/memcg/control/Makefile
2010-02-27 17:51:10.359555806 +0530
@@ -0,0 +1,33 @@

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Please create your patch against next tree or attach the source file
here as text, i will create a patch.

Thanks
Rishi
> =

> Thanks
> Rishi
> > =

> > Naufal
> =

> -- =

> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
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
