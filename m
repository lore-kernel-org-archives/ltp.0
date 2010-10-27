Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PB57D-0002Vl-4j
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 12:28:27 +0000
Date: Wed, 27 Oct 2010 14:38:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101027123822.GA9127@saboteur.suse.cz>
References: <20101025205915.GD3003@saboteur.suse.cz>
	<AANLkTinUHQ6EUWi3ZhkuO0Ccd2FSSsLm6DiQpM=bZKcB@mail.gmail.com>
	<20101026161624.GA15489@saboteur.suse.cz>
	<AANLkTikO=yKXhxx7giTYBMM1uerYzEj3Uj+gWY42kg3Q@mail.gmail.com>
	<AANLkTi=2bCEpmjmikx4mUZFE_fBNEz-jP+jsK2He3QF-@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=2bCEpmjmikx4mUZFE_fBNEz-jP+jsK2He3QF-@mail.gmail.com>
Subject: Re: [LTP] aio_error/3-1.c
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
> >>> > I've been reading POSIX documentation for some time now and even re=
ading
> >>> > glibc source code and the result is that aio_error/3-1.c doesn't te=
st
> >>> > anyting and should be removed.
> >>> >
> >>> > The test is trying to assert EINVAL from aio_error accordingly to:
> >>> >
> >>> > http://www.opengroup.org/onlinepubs/009695399/functions/aio_error.h=
tml
> >>> >
> >>> > ...
> >>> >
> >>> > The aio_error() function may fail if:
> >>> >
> >>> > =A0 =A0 =A0 =A0[EINVAL]
> >>> > =A0 =A0 =A0 =A0 =A0 =A0The aiocbp argument does not refer to an asy=
nchronous
> >>> > =A0 =A0 =A0 =A0 =A0 =A0operation whose return status has not yet be=
en retrieved.
> >>> >
> >>> > ...
> >>> >
> >>> >
> >>> > As far as I understand this, it's says you may get EINVAL if you ca=
ll
> >>> > aio_error() on finished aiocb second (and more) times.
> >>> >
> >>> > This is implemented on linux as "return aiocb->__error_code" so IMHO
> >>> > there is no way to test this.
> >>>
> >>> =A0 =A0 I think that the original developers misinterpreted the test
> >>> requirements. aio_error is _always_ supposed to return errno values,
> >>> not -1 and set the global errno. Otherwise it wouldn't make sense
> >>> because asynchronous I/O would be more synchronous than anything else.
> >>
> >> This is not the only problem here. Accordinly to POSIX aio_error() out=
put is
> >> defined only when you pass correct aiocb (that means struct aiocb that=
 is
> >> already used for some aio_{write,read,fsync,...}) and the value may no=
t be
> >> stored pernamently, so if you read it once, it could return EINVAL sec=
ond time.
> >>
> >>
> >> ...
> >>
> >> memset (&aiocb, 0, sizeof (struct aiocb));
> >>
> >> aiocb.aio_fildes =3D fd;
> >> aiocb.aio_buf =3D buf;
> >> aiocb.aio_reqprio =3D -1;
> >> aiocb.aio_nbytes =3D BUF_SIZE;
> >>
> >> /*
> >> =A0* Here return from aio_error() is not defined as
> >> =A0* there was no aio operation done on aiocb.
> >> =A0*
> >> =A0* On linux you get value that is stored in struct aiocb->__error_co=
de
> >> =A0* and as aiocb is filled with zeroes on the beginning, this
> >> =A0* returns also zero.
> >> =A0*/
> >> ret =3D aio_error(&aiocb);
> >>
> >> if (aio_write(&aiocb) =3D=3D -1) {
> >> =A0 =A0 =A0 =A0/* quening write operation has failed */
> >> =A0 =A0 =A0 =A0return 1;
> >> }
> >>
> >> /*
> >> =A0* Wait for completion.
> >> =A0*/
> >> while ((ret =3D aio_error(&aiocb)) =3D=3D EINPROGRESS)
> >> =A0 =A0 =A0 =A0sleep(1);
> >>
> >> /* Here we have status from aio_write in ret */
> >>
> >> /*
> >> =A0* And here we may get EINVAL instead of status from previous
> >> =A0* aio_write()
> >> =A0*/
> >> ret =3D aio_error(&aiocb);
> >>
> >>
> >> So what I'm saying is that if you really want to write correct test fo=
r 3-1.c
> >> you need to:
> >>
> >> 1. Create aio data transfer
> >> 2. Wait for completion
> >> 3. Get aio return status by aio_error()
> >> 4. Get it once more and it should either be EINVAL or same value that =
you got first time.
> >>
> >> Which seems to be a little dumb to test to me, so I vote for removing =
3-1.c from ltp.
> >
> > =A0 =A0I'll do some comparison with other existing testcases, as well as
> > look at the requirements for 3-1 further tonight -- but my initial
> > look at your argument seems sound.
> =

>     Looking at the tort again in SUSv4, the logic that you're arguing
> seems incorrect:
> =

>     The aio_error() function may fail if:
> =

>     [EINVAL]
>         The aiocbp argument does not refer to an asynchronous
> operation whose return status has not yet been retrieved.
> =

>     It's pretty blatant that EINVAL should apply to aio_error when
> aiocbp is passed in which doesn't point to a valid file descriptor
> linked to some sort of aio operation. If Linux is improperly caching
> the aio_error, then Linux needs to be corrected to meet the POSIX
> requirements if the test is supposed to pass and the behavior isn't
> already documented in the OS specific documentation (manpages,
> whatever). Same thing applies for all OSes trying to meet the golden
> POSIX standard.
>     The ERROR clause's wording is lousy though, so I'll bring this up
> with opengroup.

I'm not native english speaker, so when arguing about wording, my
understanding may not be correct. But I personally understand this as:

aio_error() may fail =3D> it's not hard requirment and it's upon implementa=
tion what would happen

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
