Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLhSm-0001hw-H2
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 19:26:36 +0000
Date: Thu, 25 Nov 2010 20:38:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125193857.GB10085@saboteur.suse.cz>
References: <AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
	<4CCE73A6.9020901@cn.fujitsu.com>
	<AANLkTi=TyhLVZ5OOcRduBwvkxS3-u4f7A1W+bv+WO6Y1@mail.gmail.com>
	<4CE4AD0D.1050501@cn.fujitsu.com>
	<AANLkTim5JubFxad76akVJ7YOVs1V84gY=2TUVQ1KMkJz@mail.gmail.com>
	<4CE4B2B6.4030408@cn.fujitsu.com>
	<20101119131630.GC19564@saboteur.suse.cz>
	<4CE9CAE0.2070808@cn.fujitsu.com>
	<20101125184405.GB7551@saboteur.suse.cz>
	<AANLkTim2rWksdiugWwFU_TRu44t5gqzHFwJPYLV-YdsY@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTim2rWksdiugWwFU_TRu44t5gqzHFwJPYLV-YdsY@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
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
Cc: ?c?? ???s <toza@ryobi.co.jp>, ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Hi!
> >> >>>>>> ...
> >> >>>>>>>> =A0int main()
> >> >>>>>>>> =A0{
> >> >>>>>>>> @@ -133,6 +152,12 @@
> >> >>>>>>>>
> >> >>>>>>>> =A0 =A0 =A0 =A0struct sigaction sa;
> >> >>>>>>>>
> >> >>>>>>>> + =A0 =A0 =A0 /* Checking for Kernel Version */
> >> >>>>>>>> + =A0 =A0 =A0 if ( kernel_ver_cmp(2, 6, 21) !=3D 0 )
> >> >>>>>>>> + =A0 =A0 =A0 {
> >> >>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTESTED( "sem_wait() returned =
EINTR on kernel versions
> >> >>>>>>>> lower than 2.6.22" );
> >> >>>>>>>> + =A0 =A0 =A0 }
> >> >>>>>>>> +
> >> >>>>>>>> =A0 =A0 =A0 =A0/* Initialize output */
> >> >>>>>>>> =A0 =A0 =A0 =A0output_init();
> >> >>>>>>>>
> >> >>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>>>>>>>
> >> >>>>>>>> Above patch is revision only for templates.
> >> >>>>>>>> The following procedure is necessary after applying patch:
> >> >>>>>>>> ------------
> >> >>>>>>>> #cd testcases/open_posix_testsuite/conformance/interfaces/sig=
action/
> >> >>>>>>>> #./gentests.pl
> >> >>>>>>>> ------------
> >> >>>>>>>>
> >> >>>>>>>> Similar revisions are necessary for other 25 "sigaction" test=
s.
> >> >>>>>>> =A0 =A0 Sorry, but Linux-isms can't leak into the open_posix_t=
estsuite.
> >> >>>>>>> Same with BSDisms (at least they shouldn't... if they do, then=
 slap me
> >> >>>>>>> or whoever did the commit).
> >> >>>>>> Do you mean the culprit is Linux-isms?
> >> >>>>> Mitani-san is proposing that I `fix' the testcases to work on RH=
EL
> >> >>>>> 4.8. These testcases should function with minimal change for all
> >> >>>>> versions of Unix.
> >> >>>>>
> >> >>>> =A0This open_posix_suite is the part of LTP(linux test project), =
must we
> >> >>>> make sure it can work at all versions of unix?
> >> >>> I use it in FreeBSD and others have used it in other versions of U=
nix
> >> >>> (in the past), based on the README. There's no reason why we need =
to
> >> >>> maintain something that philosophically diverges from the upstream
> >> >>> project's goal because it will make merging more painful and
> >> >>> unnecessary.
> >> >>>
> >> >> =A0 OK, i get it. Thanks. ^_^
> >> >>
> >> >> =A0 Then, whether should we remove the following case, because it i=
nvokes
> >> >> =A0 the uname that it's not exsit at 4.3 BSD.
> >> >> =A0 conformance/interfaces/pthread_mutex_init/speculative/5-2.c
> >> >>
> >> >
> >> > The uname() is part of the POSIX, for sure it's available on BSD.
> >> >
> >>
> >> =A0 Maybe i miss somethings, but the IEEE Std 1003.1-2008 said:
> >> =A0 "The uname() function originated in System III, System V, and rela=
ted implementations,
> >> =A0 and it does not exist in Version 7 or 4.3 BSD. The values it retur=
ns are set at system
> >> =A0 compile time in those historical implementations."
> >
> > Well BSD 4.3 has been released in 1986. The recent BSD systems (tested
> > on FreeBSD 8.0) should be fine.
> =

>     The uname system call is fairly standard on all versions of Unix
> (and guess what folks -- it's POSIX standard too!).
>     The point wasn't to discount the value of adding uname, but where
> do you stop in trying to ?
>     If you guys want functionality to _remove_ testcases for local
> execution, then I'm willing to help there. Otherwise, there will be no
> end to this hack mess.
> =

> >> > Thinking of it, the patch that checks for kernel version only when
> >> > sysname =3D=3D Linux should compile and work. But the question here =
is if we
> >> > want to bloat the tests with workarounds for broken systems. I would
> >> > rather see this covered by a database of known issues, so you can ea=
sily
> >> > copare results and read why your system is broken.
> >> >
> >>
> >> =A0 OK, if we have this database, it looks good to me.
> >>
> >
> > Garrett pointed out the results mailing list. I'm however not reading
> > it either.
> =

> Yes, because it's mostly spam and a support email alias nowadays
> (instead of the emails coming here they go there >:(...). I need to
> come up with a script anyhow to aggregate the results and ship them
> off via LTP (not the open_posix_testsuite because I'm not going to
> commit those bits there). IIRC there's a script in tools that can do
> that.

I'm not, in any way, for poluting tests with workarounds for broken
systems (as I stated before). I was just explaining that uname() _is_,
as a matter of fact, available on modern UNIXes.

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
