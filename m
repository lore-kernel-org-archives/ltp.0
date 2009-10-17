Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mz3oO-0006f9-B8
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 07:34:48 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mz3oA-0003sK-8I
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 07:34:43 +0000
MIME-Version: 1.0
In-Reply-To: <20091016171558.GA360691@medusa.sis.pasteur.fr>
References: <20091016171558.GA360691@medusa.sis.pasteur.fr>
Date: Sat, 17 Oct 2009 00:28:43 -0700
Message-ID: <364299f40910170028q3f77657ftb78fa130ca0b5886@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Add x86_64 ppoll(2) syscall number
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sf.net>

On Fri, Oct 16, 2009 at 10:15 AM, Nicolas Joly <njoly@pasteur.fr> wrote:
>
> Hi,
>
> The attached patch add the ppoll(2) syscall number to the x86_64 list,
> and make the corresponding testcase succeed.
>
> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
>
> njoly@xxx [syscalls/ppoll]> uname -a
> Linux xxx 2.6.18-164.el5 #1 SMP Thu Sep 3 03:28:30 EDT 2009 x86_64 x86_64=
 x86_64 GNU/Linux
> njoly@xxx [syscalls/ppoll]> ./ppoll01
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) START
> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case00) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) START
> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
> RESULT: return value(ret)=3D =A0 =A0 =A0 0 errno=3D0 (Success)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case01) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case02) START
> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
> RESULT: return value(ret)=3D =A0 =A0 =A0 0 errno=3D0 (Success)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case02) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case03) START
> EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
> RESULT: return value(ret)=3D =A0 =A0 =A0 1 errno=3D0 (Success)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case03) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case04) START
> EXPECT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case04) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case05) START
> EXPECT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
> RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case05) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case06) START
> EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
> RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case06) END =3D> OK
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case07) START
> EXPECT: return value(ret)=3D-1 errno=3D14 (Bad address)
> RESULT: return value(ret)=3D-1 errno=3D14 (Bad address)
> ppoll01 =A0 =A0 0 =A0TINFO =A0: =A0(case07) END =3D> OK
> ppoll01 =A0 =A0 1 =A0TPASS =A0: =A0ppoll01 call succeeded

    Thanks for the heads up Nicolas! I added the ppoll syscall numbers
for all supported architectures (it isn't available on arm according
to my 2.6.30 kernel sources).
Cheers!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
