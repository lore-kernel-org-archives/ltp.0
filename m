Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nm035-0006Tu-Vh
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 07:28:15 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nm034-000365-Nd
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 07:28:15 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o217OeBR012316
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 00:24:40 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o217S8L9136222
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 00:28:08 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o217S8In017395
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 00:28:08 -0700
Date: Mon, 1 Mar 2010 12:58:05 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100301072805.GG3860@linux.vnet.ibm.com>
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<364299f41002270043n3a29e299ld223bbe97f7cfd32@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002270043n3a29e299ld223bbe97f7cfd32@mail.gmail.com>
Subject: Re: [LTP] A note from Maintainer
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

On Sat, Feb 27, 2010 at 12:43:11AM -0800, Garrett Cooper wrote:
> On Fri, Feb 26, 2010 at 11:53 PM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> > Welcome to ltp community.
> >
> > We are in process of changing our sf.net host repository to
> > GIT from CVS.[ Any input/discussion on this is highly appreciable ]. If
> > possible this month end release may get delayed based on responses from
> > list or next month end (i.e: March ) release will be based on git tree.
> >
> > I usually try to read all patches posted to ltp mailing list, and follow
> > almost all discussions on list, unless the topic is about an obscure
> > corner that i do not personally use. But i am obviously not perfect.If
> > you sent a patch that you did not hear from anybody for three days,
> > that is a very good indication that it was dropped on the floor --- ple=
ase
> > do not hesitate to remind me.
> >
> > The list archive is available at:
> >
> > http://marc.info/?l=3Dltp-list&r=3D1&w=3D2
> >
> >
> > Please use this public site to point out messages in mailing list if you
> > want to remind someone or again start same thread without altering
> > subject line.
> >
> > Now coming to git transformation this month, you can find gitweb
> > interface at :
> >
> > http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.git;a=3Ds=
ummary
> >
> > There are four branches in ltp-dev.git repository that track the source=
 tree
> > of ltp: "master", "maint", "next", "pu". I may add more maintanance
> > branch if we have huge backward of incompatible feature updates in the
> > future to keep an older release alive.
> >
> > The master branch is meant to contain what are very well tested and
> > ready to be used in production environment. There could occassionaly be
> > minor breakage but they are not expected to be anything major, and more
> > importantly those will be quickly and trivially fixable.
> >
> > So if some hotfixes has gone with this branch, you can find one more
> > digit has been added to version release (e.g: YYYYMMDD.1 ), So it means
> > it is more stable than YYYYMMDD release. I may be changing this format
> > if i can see a better format or if you have some suggestion then it is
> > most welcome.
> >
> > The "maint" branch is called one step before master branch, which will
> > contain all features or patches that are going to following month end
> > release.
> > (e.g: If this month end ltp-full-YYYYMMDD is going be to released
> > then all the stable patches you can find in this branch through out the
> > month, and one important point for this branch is all the patches which
> > has gone to this branch will be well tested and make sure that there is
> > no regression or breakage and Acked/Reviewed by Someone from mailing
> > list.)
> >
> > "next" branch will contain all the patches which has been sent on
> > ltp-mailing list after getting "Acked-By" and/or "Reviewed-By" anyone
> > from list. This branch is quite unstable but user can find their
> > immediate patches over here to see the stability.You can find most
> > unstable about this branch w.r.t feature wise or may be sometime build =
wise.
> >
> >
> > NOTE:
> > =3D=3D=3D=3D=3D
> > So i always encourage testcase developer/ltp-list member to send me the
> > patches against this branch. And it will be closely reviewed and
> > acknowledged by any member from ltp-list community members. Once it gets
> > Acked/Reveiwed-By then it will promoted to maint branch for maintainer
> > testing and checking for stability, otherwise it will go to "pu" branch
> > for further discussion and decision. These pending patch can be worked
> > on following month and once it is mature enough to meet the stability
> > then it can be directly jump to maint branch, here i may ask the
> > submitter to submit the patch once again against maint branch.
> >
> > "pu" branch is basically "proposed update" branch which will contain all
> > the remainder of above branches. By the above definition of how "next"
> > works, you can tell that this branch will contain quite experimental and
> > obviosuly broken stuff.
> >
> > I would like to thanks everybody who helped me to release ltp-dev git i=
nto
> > current shape. Especially i would like to thank following:
> > =A0 =A0- git.git from where actually i picked up this branch
> > =A0 =A0 =A0identification.
> > =A0 =A0- Garret, who has worked with me step by step to release this git
> > =A0 =A0 =A0tree implementation to ltp-list@.
> > =A0 =A0- All my team member from IBM who basically gave encourageable
> > =A0 =A0 =A0input and specially Aneesh, Subrata, Iranna & kamalesh.
> > =A0 =A0- And finally to Linux kernel, who motivated me to maintain such=
 a
> > =A0 =A0 =A0testsuits with git.
> >
> > This Maintainer Note will be available under doc/MaintNotes of
> > month end release.
> >
> >
> > Usage:
> >
> > #git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev
> > (Make sure you have the latest autoconf/automake before running make
> > autotools )
> > #make autotools
> > #./configure
> > #make
> > #make install
> > #cd /opt/ltp
> > #./runltp
> >
> > Please do not hesitate to reply this mail if you have any query in your
> > mind, it may help me to generate a good FAQ :) .
> =

> Hello all,
>     I highly encourage folks to also use the testscripts/build scripts
> as well [as I have in the past] before submitting patches back to us,
> so that you can test out the three identified build and test
> scenarios:
> =

> 1. install-in-build-tree
> 2. install-out-of-build-tree
> 3. [build and install] out-of-build-tree
> =

>     Please read the README before executing the scripts though (in the
> same directory).
>     I request that folks run these scripts periodically (say once a
> month, or bi-monthly) using different distros so that we can establish
> a gauge for how stable things are across the board, as opposed to
> having an unrealistic view of how Fedora 12~ish, Gentoo Linux, RHEL [,
> SuSe?, and Ubuntu?] are faring, especially because the project in and
> of itself is complex, as-is the amount of code and flux that occurs
> due to package versioning of the underlying software between releases
> (a new API gets added, and there's a certain degree of lag between
> when the system headers get updated and the glibc headers get updated
> to accommodate the new API, etc, etc).
>     Much appreciated as always, and I have a good feeling that the
> project is starting to reach a good equilibrium state again, like it
> was pre-October '09 when I committed the Makefile infrastructure
> changes.

Yes i agree, it has come towards stablility (Thanks Garret ), but still
need to look into individual testcase/testsuits which ltp dir contains
and need to make more stable, as yesterday one of my team member has
reported filecaps is running as failure and it is reporting as pass.
This type of pain point problem is still there and it needs our attention
on high priority to make user are satisfied using ltp.

Thanks
Rishi

> Happy testing as always :),
> -Garrett
> =

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
