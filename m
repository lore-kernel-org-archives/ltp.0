Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PVmS5-0007Rl-Fj
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 14:47:33 +0000
Date: Thu, 23 Dec 2010 16:02:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101223150221.GC24841@saboteur.suse.cz>
References: <20101217142007.GA6682@saboteur.suse.cz>
	<AANLkTikabdJaWP4bnjep2nh2B06pGvYfQXpz=GosuJ_2@mail.gmail.com>
	<AANLkTikAnDARhrLFba3-7yE5YpCRFQkvo4_Pt74DVCsm@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikAnDARhrLFba3-7yE5YpCRFQkvo4_Pt74DVCsm@mail.gmail.com>
Subject: Re: [LTP] [RFC] sysconf(_SC_ASYNCHRONOUS_IO) != 200112L
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

Hi!
> >> Hi!
> >> Newer glibc returns 200809 as a result from sysconf(_SC_ASYNCHRONOUS_I=
O)
> >> (the git commit was done on 26 Feb 2009) and the change seems to be
> >> propagated into stable glibc versions (mine is 2.11.2-r3).
> >>
> >> The problem is that nearly all aio testcases starts with
> >>
> >> if (sysconf(_SC_ASYNCHRONOUS_IO) !=3D 200112L)
> >> =A0 =A0 =A0 =A0return PTS_UNRESOLVED;
> >>
> >> So these tests are disabled with newer glibc.
> >>
> >> However the changes between posix 200112 and 200908 seems to be minimal
> >> (I haven't been able to find the full list of changes, but at least the
> >> =A0testcases seems to work.)
> >>
> >> My proposal is to do one of the following:
> >>
> >> * remove these two lines to enable the tests
> >>
> >> * change them to sysconf(_SC_ASYNCHRONOUS_IO) >=3D 200112L
> >
> > Option 2 is better than option 1.
> =

> That being said though, it would be nice if we had tests specific to
> these requirements, in addition to ones that aren't, and if glibc is
> unnecessarily bumping values then someone needs to talk to Ulrich
> about not creating unnecessary churn.

The problem is that I've been unable to find a document which sumarizes
changes between 1003.1-2002 and 1003.1-2008. And coparing the
documentation page by page is troublesome, especially when there seems
to be miminal number of changes.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, an=
d, =

should the need arise, upgrade to a full multi-node Oracle RAC database =

without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
