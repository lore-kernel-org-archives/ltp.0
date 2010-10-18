Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P7oO9-0004MZ-Rk
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 12:00:25 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7oO8-0000A0-94
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 12:00:25 +0000
Received: by gxk19 with SMTP id 19so361056gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 05:00:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb66a9$bb3c52b0$31b4f810$@co.jp>
References: <000001cb66a9$bb3c52b0$31b4f810$@co.jp>
Date: Mon, 18 Oct 2010 05:00:18 -0700
Message-ID: <AANLkTimwwvYMxECHENzqo6tb4iVU+VCbT12aWhUagppF@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Thu, Oct 7, 2010 at 10:29 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> "conformance/interfaces/aio_return/2-1" failed with following message:
> ------------
> conformance/interfaces/aio_return/2-1: execution: FAILED: Output:
> aio_return/2-1.c Second call to aio_return() should return -1 : 111
> ------------
>
> Same problem occurs in "aio_return/3-2.c" and "aio_return/4-1".
>
> Environment is as follows:
> =A0- RHEL5.5 --- (x86, x86_64, ia64)
> =A0- RHEL4.8 --- (x86, x86_64, ia64)
>
>
> This testset seems to be the error root test for "aio_return()".
>
> First "aio_return()" returned with 111. This return value is the length
> of buffer of "aio_write()".
> But second "aio_return()" returned with 111, too. It's unexpected
> result for this test set.
> Therefore, this test failed.
>
> Man page says that
> "This function should be called only once for any given request, =A0after
> aio_error(2) returns something other than EINPROGRESS.":
> ------------
> # LANG=3DC man 3 aio_return
>
> AIO_RETURN(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linux Programmer's Manual
> AIO_RETURN(3)
>
> NAME
> =A0 =A0 =A0 aio_return - get return status of asynchronous I/O operation
>
> SYNOPSIS
> =A0 =A0 =A0 #include <aio.h>
>
> =A0 =A0 =A0 ssize_t aio_return(struct aiocb *aiocbp);
>
> DESCRIPTION
> =A0 =A0 =A0 The aio_return function returns the final return status for t=
he
> asynchronous I/O
> =A0 =A0 =A0 request with control block pointed to by aiocbp.
>
> =A0 =A0 =A0 This =A0function =A0should =A0be =A0called =A0only =A0once =
=A0for =A0any =A0given
> request, =A0after
> =A0 =A0 =A0 aio_error(2) returns something other than EINPROGRESS.
>
> RETURN VALUE
> =A0 =A0 =A0 If the asynchronous I/O operation has completed, this function
> returns the value
> =A0 =A0 =A0 that would have been returned in case of a synchronous =A0rea=
d, =A0write,
> or =A0fsync
> =A0 =A0 =A0 request. =A0Otherwise the return value is undefined. =A0On er=
ror, the
> error value is
> =A0 =A0 =A0 returned.
>
> ERRORS
> =A0 =A0 =A0 EINVAL aiocbp does not point at a control block for an asynch=
ronous
> I/O =A0request
> =A0 =A0 =A0 =A0 =A0 =A0 =A0of which the return status has not been retrie=
ved yet.
>
> CONFORMING TO
> =A0 =A0 =A0 POSIX 1003.1-2003
>
> SEE ALSO
> =A0 =A0 =A0 aio_cancel(3), =A0 =A0aio_error(3), =A0 aio_fsync(3), =A0 aio=
_read(3),
> aio_suspend(3),
> =A0 =A0 =A0 aio_write(3)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 2003-11-14
> AIO_RETURN(3)
> #
> ------------
>
> And, it says that
> "If the asynchronous I/O operation has completed, this function returns
> the value that would have been returned in case of a synchronous read,
> write, or fsync request. =A0Otherwise the return value is undefined. =A0On
> error, the error value is returned.".
>
>
> It can be supposed that the return value of second "aio_return()" is
> undefined.
> Therefore, it is not mistake that return value of the second "aio_return(=
)"
> is one at success, I think.
> And, I think that "UNTESTED" or "UNRESOLVED" may be is more appropriate
> for this test.

    No. POSIX clearly states:

"If the asynchronous I/O operation has completed, then the return
status, as described for read(), write(), and fsync(), shall be
returned. If the asynchronous I/O operation has not yet completed, the
results of aio_return() are undefined.

If the aio_return() function fails, it shall return -1 and set errno
to indicate the error."

ERRORS

"The aio_return() function may fail if:

[EINVAL]
    The aiocbp argument does not refer to an asynchronous operation
whose return status has not yet been retrieved."

    What the test implementers were looking to do was test out that -1
/ EINVAL were returned, and maybe that fact that they were testing was
in fact implementation defined, as opposed to what's stated in the
standard, as the spec doesn't state that the behavior for aio_return
would be s.t. the state of the AIO stream is reset when aio_return is
called.
    So yes, I agree this should be fixed, but let me check with the
POSIX folks what the best course of action is.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
