Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PxLDd-0000Ck-LK
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 15:22:33 +0000
Date: Wed, 9 Mar 2011 16:43:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110309154351.GB10062@saboteur.suse.cz>
References: <20110225164849.GB7142@saboteur.suse.cz>
	<AANLkTi=0c3hXb__M_fXkwYyzjwJFq_hwRvibE4zMvr=E@mail.gmail.com>
	<AANLkTimYqcKfOwqTVaA+vnVhWnXtfxg_UurKkjCf5QdF@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimYqcKfOwqTVaA+vnVhWnXtfxg_UurKkjCf5QdF@mail.gmail.com>
Subject: Re: [LTP] testcases/kernel/mem Makefile mess
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
> >> There are more than two libraries in testcases/kernel/mem/ that results
> >> in Makefile confusion. One of the sideeffects is that internal librari=
es
> >> libmem.a and liboom.a gets installed.
> >>
> >> Garrett do you care to have a look on this?
> >
> > =A0 =A0Agreed. `liboom' shouldn't be a library. It can be moved to the
> > directory, one can apply FILTER_OUT_SRCS on oom.c (might be better to

And even then the mem directory contains libmm and lib (which is source
for libmem) and that confuses the Make system too. Shouldn't we merge
these two?

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
