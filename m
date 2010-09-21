Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Oxue0-0008Hd-B6
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 04:39:52 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oxudy-0003zK-LF
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 04:39:52 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
	<20100915134318.GD24784@hannu-debian.research.nokia.com>
	<AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
	<20100915182052.GA2750@hannu-ubuntu>
	<AANLkTik5HT2tDzaCfAU+7kgcsUNucrL6zPLZ3xdBF+kW@mail.gmail.com>
	<20100916190023.GA11397@hannu-ubuntu>
	<AANLkTi=tsb1E2nW3ZmRdMrSZ6WftPRCe3RJf90Ts3rJw@mail.gmail.com>
	<20100917164745.GA20627@hannu-debian.research.nokia.com>
In-Reply-To: <20100917164745.GA20627@hannu-debian.research.nokia.com>
Date: Tue, 21 Sep 2010 13:39:41 +0900
Message-ID: <000001cb5947$0176e3f0$0464abd0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] POSIX "sched_yield/1-1.c" build failed
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
To: 'Hannu Heikkinen' <ext-hannu.m.heikkinen@nokia.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Hannu Heikkinen [mailto:ext-hannu.m.heikkinen@nokia.com]
> Sent: Saturday, September 18, 2010 1:48 AM
> To: ext Garrett Cooper
> Cc: Hannu Heikkinen; ltp-list@lists.sourceforge.net; ext Mitani
> Subject: Re: [LTP] POSIX "sched_yield/1-1.c" build failed
> =

> On 16/09/10 21:12 +0200, ext Garrett Cooper wrote:
> > On Thu, Sep 16, 2010 at 12:00 PM, Hannu Heikkinen <hannuxx@iki.fi>
> wrote:
> > > On 15/09/10 12:01 -0700, Garrett Cooper wrote:
> > >> >
> > >> > Should this posixtest.h be kind of a must include for all test
> cases?
> > >> > Currently not all cases include this.
> > >>
> > >> =A0 =A0 Well, every affected testcase should include this :). Not
> all
> > >> files need to include this (there are a number of applications
> that
> > >> don't need what's defined here) -- so there's no sense in
> generating
> > >> more work than necessary :).
> > >> Thanks,
> > >> -Garrett
> > >
> > > I must have been hald asleep writing that prev email. I meant that
> posixtest
> > > cases should include that, and of course not all LTP cases.
> >
> > I must have doubly been so because I didn't catch that either :).
> >
> > > Might be a consideration for having global ltp header file for all
> C test
> > > cases
> > > so that generic functionality could be better tweaked by changing
> certain
> > > defines. Of course that needs more discussion and analysis, thoug.
> >
> > Already done:
> >
> > include/:
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.git;a=3D
> tree;f=3Dinclude;h=3D93d0ff91530c366d3af0cfc0c6b4f27c779cb866;hb=3DHEAD
> > lib/:
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.git;a=3D
> tree;f=3Dlib;h=3D85556e60de93da651c3ffbab56eeef2b3a68c8bf;hb=3DHEAD
> >
> > The above changes mentioned only affect the open posix testsuite
> > (http://sf.net/projects/posixtest/), which is a component
> completely
> > orthogonal to the rest of the code in the LTP sourcebase, so these
> > changes are only required for that section of the codebase. However,
> > certain tunable features can be added in the LTP buildsystem and the
> > open posix testsuite to support automatic `developer mode' if you
> > will. This will take a while to do properly though.
> >
> > Thanks,
> > -Garrett
> =

> =

> Thanks for the info! That's good news!
> =

> br,
> Hannu
> =

> --
> Hannu Heikkinen
> +358-40-1586858
> http://www.nixu.com


The patch was already included in following gits:
"ltp-dev-121ad2a296f4ade04e2c2e351820df32a6c441d5.tar.gz" =

"ltp-dev-8b0ca7e9a5e7dcab8d7cbad0b6f0c808798bdc53.tar.gz"
and I tried to build with these gits instead of the patch.

POSIX "sched_yield/1-1.c" build successed in RHEL5.5 (x86, x86_64, ia64), =

but failed in RHEL4.8 (x86, x86_64, ia64):
------------(RHEL5.5 x86)
conformance/interfaces/sched_yield/1-1 compile PASSED
------------

------------(RHEL4.8 x86)
conformance/interfaces/sched_yield/1-1 compile FAILED; SKIPPING
In file included from ../../../conformance/interfaces/sched_yield/1-1.c:35:
../../../include/posixtest.h:23:2: warning: #warning "Contains GNU-isms that
need fixing."
../../../conformance/interfaces/sched_yield/1-1.c: In function
`set_thread_affinity':
../../../conformance/interfaces/sched_yield/1-1.c:91: warning: implicit
declaration of function `pthread_setaffinity_np'
/tmp/ccuhCnVY.o(.text+0x1c1): In function `set_thread_affinity':
: undefined reference to `pthread_setaffinity_np'
collect2: ld returned 1 exit status
------------

But, in all my RHEL5.5/4.8 systems, this revision brought the build
successes =

of the following testsets that were concern from the past:
 - "pthread_attr_setstack/2-1.c"
 - "pthread_attr_setstacksize/2-1.c"

Now in all my RHEL5.5 systems, all build failes were settled by this
revision.



Thank you--

-Tomonori Mitani



---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
