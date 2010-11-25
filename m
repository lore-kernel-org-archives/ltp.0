Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLiE4-0000Ii-Ty
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:15:28 +0000
Date: Thu, 25 Nov 2010 21:27:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125202751.GB11386@saboteur.suse.cz>
References: <AANLkTi=+oxNMPd_J8w46xXM8nwiNet9dLKHK-rLq94Ft@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=+oxNMPd_J8w46xXM8nwiNet9dLKHK-rLq94Ft@mail.gmail.com>
Subject: Re: [LTP] [RFC] Remove dumb LTP tst_res APIs and improve others
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> >>>
> >>> ...
> >>>
> >>> > You should use tst_brkm(TBROK|TERRNO, tst_exit, "mmap") here. As
> >>> > tst_brkm() exits when pointer to cleanup is not NULL.
> >>>
> >>> Actually, the exit should be dropped and the tst_brkm invocation
> >>> should be left alone. When NULL is specified as the second argument to
> >>> tst_brkm, it automatically calls tst_exit.
> >>
> >> I would disagree here.
> >>
> >> man tst_res
> >>
> >> ...
> >>
> >> If func is NULL, tst_brk() and tst_brkm return to the caller after all
> >> results have been printed.
> >>
> >> ...
> >>
> >>
> >>
> >> And the corresponding code in the lib/tst_res.c is
> >>
> >> ...
> >>
> >> =A0 =A0 =A0 =A0if (func !=3D NULL) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*func)();
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> >> =A0 =A0 =A0 =A0}
> >>
> >> }
> >>
> >>
> >> Which seems like a dump interface to me, but once used this way in who=
le
> >> LTP, we cannot easily change that.
> >
> > !!!
> >
> > Crap. I've somehow gotten it backwards this entire time >:(...
> =

>     I took a quick look around the sourcebase and there are a number
> of ways where this is done incorrectly. I know it's an API change, but
> does it make sense just to call tst_exit() at the end of tst_brkm?
>     Also, tst_brkloop* is completely unused. I vote for that to be
> removed as well.

I'm pretty sure that this is misused in many places, as a matter of
fact, I could not remember single test that played 100% nice with the
LTP api.

This however needs extensive testing. Ideally each tests gets reviewed,
but I'm pretty sure we are lacking manpower for this. =


Still I vote for that change. Good luck with testing. ;)

PS: don't forget to change the docs


And when we are at it, we should consider removing unused (and sometimes
broken) functionality from include/usctest.h

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
