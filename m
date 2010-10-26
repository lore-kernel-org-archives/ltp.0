Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PAm2k-0000NO-NL
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 16:06:34 +0000
Date: Tue, 26 Oct 2010 18:16:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101026161624.GA15489@saboteur.suse.cz>
References: <20101025205915.GD3003@saboteur.suse.cz>
	<AANLkTinUHQ6EUWi3ZhkuO0Ccd2FSSsLm6DiQpM=bZKcB@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinUHQ6EUWi3ZhkuO0Ccd2FSSsLm6DiQpM=bZKcB@mail.gmail.com>
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
> > I've been reading POSIX documentation for some time now and even reading
> > glibc source code and the result is that aio_error/3-1.c doesn't test
> > anyting and should be removed.
> >
> > The test is trying to assert EINVAL from aio_error accordingly to:
> >
> > http://www.opengroup.org/onlinepubs/009695399/functions/aio_error.html
> >
> > ...
> >
> > The aio_error() function may fail if:
> >
> > =A0 =A0 =A0 =A0[EINVAL]
> > =A0 =A0 =A0 =A0 =A0 =A0The aiocbp argument does not refer to an asynchr=
onous
> > =A0 =A0 =A0 =A0 =A0 =A0operation whose return status has not yet been r=
etrieved.
> >
> > ...
> >
> >
> > As far as I understand this, it's says you may get EINVAL if you call
> > aio_error() on finished aiocb second (and more) times.
> >
> > This is implemented on linux as "return aiocb->__error_code" so IMHO
> > there is no way to test this.
> =

>     I think that the original developers misinterpreted the test
> requirements. aio_error is _always_ supposed to return errno values,
> not -1 and set the global errno. Otherwise it wouldn't make sense
> because asynchronous I/O would be more synchronous than anything else.

This is not the only problem here. Accordinly to POSIX aio_error() output is
defined only when you pass correct aiocb (that means struct aiocb that is
already used for some aio_{write,read,fsync,...}) and the value may not be
stored pernamently, so if you read it once, it could return EINVAL second t=
ime.


...

memset (&aiocb, 0, sizeof (struct aiocb));

aiocb.aio_fildes =3D fd;
aiocb.aio_buf =3D buf;
aiocb.aio_reqprio =3D -1;
aiocb.aio_nbytes =3D BUF_SIZE;

/*
 * Here return from aio_error() is not defined as
 * there was no aio operation done on aiocb.
 *
 * On linux you get value that is stored in struct aiocb->__error_code
 * and as aiocb is filled with zeroes on the beginning, this
 * returns also zero. =

 */
ret =3D aio_error(&aiocb);

if (aio_write(&aiocb) =3D=3D -1) {
	/* quening write operation has failed */
	return 1;
}

/*
 * Wait for completion.
 */
while ((ret =3D aio_error(&aiocb)) =3D=3D EINPROGRESS)
	sleep(1);

/* Here we have status from aio_write in ret */

/*
 * And here we may get EINVAL instead of status from previous
 * aio_write()
 */
ret =3D aio_error(&aiocb);


So what I'm saying is that if you really want to write correct test for 3-1=
.c
you need to:

1. Create aio data transfer
2. Wait for completion
3. Get aio return status by aio_error()
4. Get it once more and it should either be EINVAL or same value that you g=
ot first time.

Which seems to be a little dumb to test to me, so I vote for removing 3-1.c=
 from ltp.

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
