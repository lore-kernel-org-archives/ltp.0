Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ext-hannu.m.heikkinen@nokia.com>) id 1OwbKi-0003bL-AM
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 13:50:32 +0000
Received: from smtp.nokia.com ([192.100.122.230] helo=mgw-mx03.nokia.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OwbKd-0006z8-Mo
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 13:50:32 +0000
Date: Fri, 17 Sep 2010 16:47:45 +0000
From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Message-ID: <20100917164745.GA20627@hannu-debian.research.nokia.com>
References: <000401cb53c6$d7a16620$86e43260$@co.jp>
	<20100915134318.GD24784@hannu-debian.research.nokia.com>
	<AANLkTikYz9ppRN1FZBSnpyePoMV79GDWNA4umS7NLUn_@mail.gmail.com>
	<20100915182052.GA2750@hannu-ubuntu>
	<AANLkTik5HT2tDzaCfAU+7kgcsUNucrL6zPLZ3xdBF+kW@mail.gmail.com>
	<20100916190023.GA11397@hannu-ubuntu>
	<AANLkTi=tsb1E2nW3ZmRdMrSZ6WftPRCe3RJf90Ts3rJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=tsb1E2nW3ZmRdMrSZ6WftPRCe3RJf90Ts3rJw@mail.gmail.com>
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
To: ext Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, ext Mitani <mitani@ryobi.co.jp>

On 16/09/10 21:12 +0200, ext Garrett Cooper wrote:
> On Thu, Sep 16, 2010 at 12:00 PM, Hannu Heikkinen <hannuxx@iki.fi> wrote:
> > On 15/09/10 12:01 -0700, Garrett Cooper wrote:
> >> >
> >> > Should this posixtest.h be kind of a must include for all test cases?
> >> > Currently not all cases include this.
> >>
> >> =A0 =A0 Well, every affected testcase should include this :). Not all
> >> files need to include this (there are a number of applications that
> >> don't need what's defined here) -- so there's no sense in generating
> >> more work than necessary :).
> >> Thanks,
> >> -Garrett
> >
> > I must have been hald asleep writing that prev email. I meant that posi=
xtest
> > cases should include that, and of course not all LTP cases.
> =

> I must have doubly been so because I didn't catch that either :).
> =

> > Might be a consideration for having global ltp header file for all C te=
st
> > cases
> > so that generic functionality could be better tweaked by changing certa=
in
> > defines. Of course that needs more discussion and analysis, thoug.
> =

> Already done:
> =

> include/: http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.g=
it;a=3Dtree;f=3Dinclude;h=3D93d0ff91530c366d3af0cfc0c6b4f27c779cb866;hb=3DH=
EAD
> lib/: http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.git;a=
=3Dtree;f=3Dlib;h=3D85556e60de93da651c3ffbab56eeef2b3a68c8bf;hb=3DHEAD
> =

> The above changes mentioned only affect the open posix testsuite
> (http://sf.net/projects/posixtest/), which is a component completely
> orthogonal to the rest of the code in the LTP sourcebase, so these
> changes are only required for that section of the codebase. However,
> certain tunable features can be added in the LTP buildsystem and the
> open posix testsuite to support automatic `developer mode' if you
> will. This will take a while to do properly though.
> =

> Thanks,
> -Garrett


Thanks for the info! That's good news!

br,
Hannu

-- =

Hannu Heikkinen
+358-40-1586858
http://www.nixu.com

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
