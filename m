Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLrn4-0000P5-7G
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:23:42 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLrmw-0007ZD-F1
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:23:42 +0000
Received: by pxi27 with SMTP id 27so848839pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 21:23:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <op.u45xgah3u2flwt@debian>
References: <op.u45xgah3u2flwt@debian>
Date: Fri, 18 Dec 2009 21:23:28 -0800
Message-ID: <364299f40912182123u7eb00ebdif815806f5efff129@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch from 4.11.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

2009/12/18 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> Hello,
>
> in your patch from 4.11., "1. Use linux_syscall_numbers.h. 2. Fix a format
> string (use inttypes.h)....", there is:
>
>
> @@ -174,7 +177,7 @@ void test_mbind(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 printf("%lx\n", addr);
> + =A0 =A0 =A0 printf("%" __PRI64_PREFIX "x\n", (long) addr);
> =A0 =A0 =A0 =A0ret =3D mbind(addr, len, MPOL_BIND, &mask, 8 * sizeof(mask=
), 0);
> =A0}
>
> I am not happy with that, particularly:
>
> 1. You use a 64-bit format specifier, but pass a long. A long may not be
> 64-bit, in which case the code is buggy.
>
> 2. You use __PRI64_PREFIX, which, as all underscore-prefixed names is an
> implementation detail of the library.
>
> 3. Why didn't use just printf("%p\n", addr), when addr is a void* and "p"=
 is
> a format specifier for pointers.

    I just accidentally committed the -> "%p" change a second ago.
Thanks for the keen eye on the style and functional points Jiri!
Learned something new today :].
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
