Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PO92O-0007YI-Tt
	for ltp-list@lists.sourceforge.net; Thu, 02 Dec 2010 13:17:28 +0000
Date: Thu, 2 Dec 2010 14:13:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101202131351.GB20268@saboteur.suse.cz>
References: <20101125164008.GC2853@saboteur.suse.cz>
	<AANLkTimFfK-34NALnKWMmOUqRhVfF70KMnWup8TiEp1C@mail.gmail.com>
	<20101126142704.GA3587@saboteur.suse.cz>
	<AANLkTim4PpA-aWoW_+cbB--cC6fj9qADhJEPf69S-BpW@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTim4PpA-aWoW_+cbB--cC6fj9qADhJEPf69S-BpW@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix lchown tests
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
> > Well, the return 0; is there just to silent compiler as cleanup() calls
> > tst_exit(); The best solution is IMHO add noreturn attribute to
> > cleanup() and remove the return 0;
> =

> Eventually what will happen (if you've been watching git) is that the
> calls will become:
> =

> cleanup();
> tst_exit();
> =

> in main, and any and all references of tst_exit() elsewhere should be
> replaced / removed. I've completed about 100 or so of the syscalls and
> have about 800 to go. Whee...

Ah, okay.

> >> + =A0 =A0 if (close(fd) =3D=3D -1)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK | TERRNO, cleanup, "close(2) =
%s", TESTFILE);
> >>
> >> gcooper> Wouldn't worry about the close.
> >
> > Checking it doesn't do any harm. ;)
> =

> Yeah. It's closing before running a test not after (and that's the
> only potential exception for looking at the output of *close).
> Sorry...
> =

> >>
> >> - =A0 =A0 /* fix permissions on the tmpdir */
> >> - =A0 =A0 if (chmod(".", 0711) !=3D 0) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK | TERRNO, cleanup, "chmod() f=
ailed");
> >>
> >> gcooper> The directory mode for tst_tmpdir is different:
> >>
> >> #define DIR_MODE =A0 =A0 =A0 =A00777 =A0/* mode of tmp dir that will b=
e created */
> >
> > As far as I understand the tests, changing permissions on tmp directory
> > is not needed as the test is testing permissions on symlinks created
> > inside of it (so we only need that the content of the directory is
> > accesible). I susspect that this is some workaround that wasn't removed
> > when test was ported for LTP.
> =

> Are you sure? If you change credentials (and this test does) the
> contents of the directory are inaccessible. I'd readd this and check
> what the outcome is of the test.

The tst_tmpdir() is called after effective ids are set to TEST_USER
(user nobody) and the whole test (without one setup function, which
creates data that should result in EPERM) runs as TEST_USER then the
test is owner of the directory, so if I'm not missing something, there
is no point in changing the test directory from 0777 to 0711.

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
