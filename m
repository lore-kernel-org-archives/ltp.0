Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N2yj4-0005wl-KA
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 02:57:30 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2yiy-0002tx-90
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 02:57:30 +0000
Received: by pwj6 with SMTP id 6so577915pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Oct 2009 19:57:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
Date: Tue, 27 Oct 2009 19:57:18 -0700
Message-ID: <364299f40910271957g6fc5147bgfbf3fe4c08d73b7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1,
	5: pass correct value for 	sigset_t for mips
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, Oct 27, 2009 at 6:32 PM, Henry Yei <hyei@mvista.com> wrote:
> All,
>
>
>
> The patch attached =A0for ppoll01:
>
> cleans up spacing and code style
>
> removes unneeded/broken debug option parsing
>
> if test fails, it prints out the last failed errno, rather than just the
> last errno(which may have been successful)
>
> passes in correct size of sigset_t for mips
>
>
>
> Signed-off by: Henry Yei <hyei@mvista.com>
>
>
>
> This patch was tested/passed on x86, mips(little endian), and ppc_82xx .

1. Please keep tst_exit() at the bottom.
2. Why can't we do sizeof(sigsetmask) ?

Thanks,
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
