Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P8tfZ-0008E4-Es
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 11:50:53 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P8tfX-0008Qc-KB
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 11:50:53 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb66a9$bb3c52b0$31b4f810$@co.jp>	<AANLkTimwwvYMxECHENzqo6tb4iVU+VCbT12aWhUagppF@mail.gmail.com>
	<AANLkTikxqHqzGGcASkgMLq2BAWxLGHxjgvSbtsguXDzb@mail.gmail.com>
In-Reply-To: <AANLkTikxqHqzGGcASkgMLq2BAWxLGHxjgvSbtsguXDzb@mail.gmail.com>
Date: Thu, 21 Oct 2010 20:50:42 +0900
Message-ID: <000001cb7116$30633ba0$9129b2e0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] POSIX "aio_return/2-1" failed.
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, October 21, 2010 6:42 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] POSIX "aio_return/2-1" failed.
> =

> On Mon, Oct 18, 2010 at 5:00 AM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> > On Thu, Oct 7, 2010 at 10:29 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> Hi,
> >>
> >>
> >> "conformance/interfaces/aio_return/2-1" failed with following
> message:
> >> ------------
> >> conformance/interfaces/aio_return/2-1: execution: FAILED: Output:
> >> aio_return/2-1.c Second call to aio_return() should return -1 : 111
> >> ------------
> >>
> >> Same problem occurs in "aio_return/3-2.c" and "aio_return/4-1".
> >>
> >> Environment is as follows:
> >> =A0- RHEL5.5 --- (x86, x86_64, ia64)
> >> =A0- RHEL4.8 --- (x86, x86_64, ia64)
> >>
> >>
> >> This testset seems to be the error root test for "aio_return()".
> >>
> >> First "aio_return()" returned with 111. This return value is the
> >> length of buffer of "aio_write()".
> >> But second "aio_return()" returned with 111, too. It's unexpected
> >> result for this test set.
> >> Therefore, this test failed.
> >>
> >> Man page says that
> >> "This function should be called only once for any given request,
> >> after
> >> aio_error(2) returns something other than EINPROGRESS.":
> >> ------------
> >> # LANG=3DC man 3 aio_return
> >>
> >> AIO_RETURN(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linux Programmer's Ma=
nual
> >> AIO_RETURN(3)
> >>
> >> NAME
> >> =A0 =A0 =A0 aio_return - get return status of asynchronous I/O operati=
on
> >>
> >> SYNOPSIS
> >> =A0 =A0 =A0 #include <aio.h>
> >>
> >> =A0 =A0 =A0 ssize_t aio_return(struct aiocb *aiocbp);
> >>
> >> DESCRIPTION
> >> =A0 =A0 =A0 The aio_return function returns the final return status for
> the
> >> asynchronous I/O
> >> =A0 =A0 =A0 request with control block pointed to by aiocbp.
> >>
> >> =A0 =A0 =A0 This =A0function =A0should =A0be =A0called =A0only =A0once=
 =A0for =A0an
> y =A0given
> >> request, =A0after
> >> =A0 =A0 =A0 aio_error(2) returns something other than EINPROGRESS.
> >>
> >> RETURN VALUE
> >> =A0 =A0 =A0 If the asynchronous I/O operation has completed, this
> function
> >> returns the value
> >> =A0 =A0 =A0 that would have been returned in case of a
> synchronous =A0read,
> >> write, or =A0fsync
> >> =A0 =A0 =A0 request. =A0Otherwise the return value is undefined. =A0On
> error,
> >> the error value is
> >> =A0 =A0 =A0 returned.
> >>
> >> ERRORS
> >> =A0 =A0 =A0 EINVAL aiocbp does not point at a control block for an
> >> asynchronous I/O =A0request
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0of which the return status has not been ret=
rieved
> yet.
> >>
> >> CONFORMING TO
> >> =A0 =A0 =A0 POSIX 1003.1-2003
> >>
> >> SEE ALSO
> >> =A0 =A0 =A0 aio_cancel(3), =A0 =A0aio_error(3), =A0 aio_fsync(3), =A0 =
aio_r
> ead(3),
> >> aio_suspend(3),
> >> =A0 =A0 =A0 aio_write(3)
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 2003-11-14
> >> AIO_RETURN(3)
> >> #
> >> ------------
> >>
> >> And, it says that
> >> "If the asynchronous I/O operation has completed, this function
> >> returns the value that would have been returned in case of a
> >> synchronous read, write, or fsync request. =A0Otherwise the return
> >> value is undefined. =A0On error, the error value is returned.".
> >>
> >>
> >> It can be supposed that the return value of second "aio_return()"
> is
> >> undefined.
> >> Therefore, it is not mistake that return value of the second
> "aio_return()"
> >> is one at success, I think.
> >> And, I think that "UNTESTED" or "UNRESOLVED" may be is more
> >> appropriate for this test.
> >
> > =A0 =A0No. POSIX clearly states:
> >
> > "If the asynchronous I/O operation has completed, then the return
> > status, as described for read(), write(), and fsync(), shall be
> > returned. If the asynchronous I/O operation has not yet completed,
> the
> > results of aio_return() are undefined.
> >
> > If the aio_return() function fails, it shall return -1 and set errno
> > to indicate the error."
> >
> > ERRORS
> >
> > "The aio_return() function may fail if:
> >
> > [EINVAL]
> > =A0 =A0The aiocbp argument does not refer to an asynchronous operation
> > whose return status has not yet been retrieved."
> >
> > =A0 =A0What the test implementers were looking to do was test out that
> -1
> > / EINVAL were returned, and maybe that fact that they were testing
> was
> > in fact implementation defined, as opposed to what's stated in the
> > standard, as the spec doesn't state that the behavior for aio_return
> > would be s.t. the state of the AIO stream is reset when aio_return
> is
> > called.
> > =A0 =A0So yes, I agree this should be fixed, but let me check with the
> > POSIX folks what the best course of action is.
> =

>     I've read into this a bit more, and I think that the aio_return
> testcases were written incorrectly. Please try out this testcase...
> if it works for you, then I'll apply necessary logic to other testcases
> as well.
>     It worked for me at least on FreeBSD.
> Thanks,
> -Garrett


I confirmed that your revision worked in my environment.
I also look forward to other testcases (2-1, 3-2, 4-1) being revised.


Thank you--

-Tomonori Mitani




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
