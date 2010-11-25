Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLhEg-0004ow-NK
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 19:12:02 +0000
Date: Thu, 25 Nov 2010 20:24:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125192420.GA10085@saboteur.suse.cz>
References: <4CDB5E53.6070604@cn.fujitsu.com> <4CDB6039.2050200@cn.fujitsu.com>
	<20101111145155.GB24599@saboteur.suse.cz>
	<4CDCA278.8080301@cn.fujitsu.com>
	<20101118182901.GC19296@saboteur.suse.cz>
	<AANLkTikbndT97R8edA769vX_JgaaawTS5htipuA3Qb0q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikbndT97R8edA769vX_JgaaawTS5htipuA3Qb0q@mail.gmail.com>
Subject: Re: [LTP] [POSIX][PATCH 1/2][v2]Use aio_error instead signal hander
 at aio_suspend/1-1
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
> >> =A0 =A0 =A0 if (ret) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 printf(TNAME " Error at lio_listio() %d: %s\=
n", errno, strerror(errno));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error at lio_listio() %d: %s=
\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno, strerror(errno));
> >
> > According to lkml coding style (that we are trying to use here), space
> > should be only between C keywords and (). Not betweeen library calls
> > like printf and so.
> =

> This is true for LTP code, but this is third party code. The
> documentation claims to conform to the LKML coding style though (even
> though I know it isn't true).

Wasn't the policy "fix everything that you touch" ?

> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D0; i<NUM_AIOCBS; i++)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (aiocbs[i]);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (bufs);
> >> @@ -165,9 +147,10 @@ main ()
> >> =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 /* Check selected request has not completed yet */
> >> - =A0 =A0 if (received_selected) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error : AIOCB %d already com=
pleted before suspend\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WAIT_FOR_AIOCB);
> >> + =A0 =A0 err =3D aio_error(aiocbs[WAIT_FOR_AIOCB]);
> >> + =A0 =A0 if (err !=3D EINPROGRESS) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error : AIOCB %d should not =
have completed "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "before suspend\n", WAIT_FOR=
_AIOCB);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D0; i<NUM_AIOCBS; i++)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (aiocbs[i]);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (bufs);
> > ....
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_FAIL);
> >>}
> >
> > Another problem lies here. The test relies that aio operation in not
> > finished when we got here. And as some linux kernels fallbacks aio as
> > synchronous IO, when we got there, it's allready finished. So I think we
> > should change this PTS_FAIL to PTS_UNRESOLVED.
> >
> > Garrett what you think?
> =

> If an operating system doesn't fully implement a set of requirements,
> it shouldn't claim to do so. If it does then that's a bug in the
> implementation.

I usually agree, but here, it could fail just because testing machine is
too fast or because whatever else happen when scheduling processes/AIO
writes. This is IMHO too fragile to be marked as FAIL.

> >> @@ -178,11 +161,9 @@ main ()
> >>
> >> =A0 =A0 =A0 /* Suspend on selected request */
> >> =A0 =A0 =A0 ret =3D aio_suspend((const struct aiocb **)plist, 2, NULL);
> >
> > Please remove useless cast to (const struct aiocb**)
> =

> Depends on whether or not this is correct. According to GCC it matters:
> =

> ../../../conformance/interfaces/aio_suspend/1-1.c:180: warning:
> passing argument 1 of 'aio_suspend' from incompatible pointer type
> =

> This should probably have the restrict c99 keyword attached to it though.

Out of curiosity, what OS/gcc version does this? I have no warnings with
all the casts removed from 1-1.c.

> >> -
> >> - =A0 =A0 /* Check selected request has completed */
> >> - =A0 =A0 if (!received_selected) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error : AIOCB %d should have=
 completed after suspend\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WAIT_FOR_AIOCB);
> >> + =A0 =A0 if (ret) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error at aio_suspend() %d: %=
s\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno, strerror (errno));
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D0; i<NUM_AIOCBS; i++)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (aiocbs[i]);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (bufs);
> >> @@ -191,9 +172,11 @@ main ()
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit (PTS_FAIL);
> >> =A0 =A0 =A0 }
> >
> > Here again with the printf.
> >
> >> -
> >> - =A0 =A0 if (ret) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error at aio_suspend() %d: %=
s\n", errno, strerror (errno));
> >> + =A0 =A0 /* Check selected request has completed */
> >> + =A0 =A0 err =3D aio_error(aiocbs[WAIT_FOR_AIOCB]);
> >> + =A0 =A0 if (err) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printf (TNAME " Error : AIOCB %d should have=
 completed after "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "suspend\n", WAIT_FOR_AIOCB);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D0; i<NUM_AIOCBS; i++)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (aiocbs[i]);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 free (bufs);
> >
> > And here.
> =

> I've cleaned up the style in this test to be more logical.
> Unfortunately the bull.net contributed tests weren't cleaned up on
> import to posix_testsuite, just like some of the syscall testcases in
> LTP proper.

That's why we are here, to fix the mess ;).

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
