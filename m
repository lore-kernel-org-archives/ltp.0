Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P5lNs-0006Uy-2i
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:23:40 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5lNr-0000HI-14
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:23:40 +0000
Received: by gya1 with SMTP id 1so815851gya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 13:23:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb66a9$bb3c52b0$31b4f810$@co.jp>
References: <ActmqbqJnH8VAq0bTbe+8e3aEkHF9Q==>
	<000001cb66a9$bb3c52b0$31b4f810$@co.jp>
Date: Tue, 12 Oct 2010 13:23:33 -0700
Message-ID: <AANLkTinpiv11=xQjFue=1-N_NdqDUPD_uQ1w=owBhWJ_@mail.gmail.com>
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

    I'll respond to this sometime in the next couple of days after I
do some more investigation on the issue.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
