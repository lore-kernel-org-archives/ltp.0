Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSGVM-0002Ju-75
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 20:27:36 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSGVG-0008Br-1N
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 20:27:36 +0000
Received: by pzk8 with SMTP id 8so1227504pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 13:27:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078E49483@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078E49483@svexch01.mvista.com>
Date: Sat, 18 Jul 2009 13:27:28 -0700
Message-ID: <364299f40907181327n23ff9364x9acb2c03ad3723e9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] network/lb6/Makefile, mips,
	mips-el toolchain needs 	explicit RANLIB call to build
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
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 16, 2009 at 3:11 PM, Henry Yei<hyei@mvista.com> wrote:
> This patch fixes the following build error on mips, mips-el toolchain: "r=
uncc.a: could not read symbols: Archive has no index; run ranlib to add one=
."
>
> Signed-off-by: Henry Yei <hyei@mvista.com>
>
> --- ltp-full-20090531/testcases/network/lib6/Makefile =A0 2009-01-22 01:2=
6:10.000000000 -0800
> +++ ltp/testcases/network/lib6/Makefile 2009-07-16 14:53:58.215774700 -07=
00
> @@ -39,3 +39,4 @@
>
> =A0runcc.a: runcc.o
> =A0 =A0 =A0 =A0ar cr runcc.a runcc.o
> + =A0 =A0 =A0 $(RANLIB) runcc.a
>
>
>
>
> Other architectures don't need this patch, if anyone who more familiar wi=
th mips and knows why, please enlighten me.
>
>
> Actual error output this patch fixes:
> make[3]: Entering directory `/ltp-full-20090531/testcases/network/lib6'
> gcc -mel -g -O2 -I../../../include -g -D_GNU_SOURCE =A0 -c -o runcc.o run=
cc.c
> ar cr runcc.a runcc.o
> gcc -mel -g -O2 -I../../../include -g -D_GNU_SOURCE =A0 =A0asapi_01.c run=
cc.a -L../../../lib runcc.a -lltp -lpthread =A0-o asapi_01
> runcc.a: could not read symbols: Archive has no index; run ranlib to add =
one
> collect2: ld returned 1 exit status

Hi Henry,
    It may be because of the compiler flags that are being passed into
the compile -- either hardcoded when the compiler was generated, or
after the fact with your folks' build system. I know that mips does
some strange things compared to other architectures (at least it does
with our in-house Cavium Networks provided compiler at Cisco). Either
way, your changes look sane so I will check it into CVS now.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
