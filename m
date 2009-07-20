Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MSyv5-0007kU-M3
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 19:53:07 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSyuw-0004ib-JK
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 19:53:07 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 20 Jul 2009 12:48:34 -0700
Message-ID: <8368651DACC1964480F951191B94A078E497D9@svexch01.mvista.com>
In-Reply-To: <364299f40907181327n23ff9364x9acb2c03ad3723e9@mail.gmail.com>
References: <8368651DACC1964480F951191B94A078E49483@svexch01.mvista.com>
	<364299f40907181327n23ff9364x9acb2c03ad3723e9@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH] network/lb6/Makefile, mips,
	mips-el toolchain needs explicit RANLIB call to build
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

Garrett,

After looking at the final committed patch for the lib6 Makefile, I saw you=
 catch the hard coded ar call that I overlooked while I was concentrating o=
n the error message I was given. Changing ar to $(AR) as you did obviates t=
he need for the explicit "$(RANLIB) runcc.a" that I added. It doesn't hurt,=
 but it looks like it is uneeded. While I was following you advice and chec=
king our toolchain, I also saw that configure was not finding our cross com=
piler version of ranlib and strip, so I need to look into that.

Thanks for the comments,



-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] =

Sent: Saturday, July 18, 2009 1:27 PM
To: Henry Yei
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] [PATCH] network/lb6/Makefile, mips, mips-el toolchain ne=
eds explicit RANLIB call to build

On Thu, Jul 16, 2009 at 3:11 PM, Henry Yei<hyei@mvista.com> wrote:
> This patch fixes the following build error on mips, mips-el toolchain: "r=
uncc.a: could not read symbols: Archive has no index; run ranlib to add one=
."
>
> Signed-off-by: Henry Yei <hyei@mvista.com>
>
> --- ltp-full-20090531/testcases/network/lib6/Makefile =A0 2009-01-22 =

> 01:26:10.000000000 -0800
> +++ ltp/testcases/network/lib6/Makefile 2009-07-16 14:53:58.215774700 =

> +++ -0700
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
> gcc -mel -g -O2 -I../../../include -g -D_GNU_SOURCE =A0 -c -o runcc.o =

> runcc.c ar cr runcc.a runcc.o gcc -mel -g -O2 -I../../../include -g =

> -D_GNU_SOURCE =A0 =A0asapi_01.c runcc.a -L../../../lib runcc.a -lltp =

> -lpthread =A0-o asapi_01
> runcc.a: could not read symbols: Archive has no index; run ranlib to =

> add one
> collect2: ld returned 1 exit status

Hi Henry,
    It may be because of the compiler flags that are being passed into the =
compile -- either hardcoded when the compiler was generated, or after the f=
act with your folks' build system. I know that mips does some strange thing=
s compared to other architectures (at least it does with our in-house Caviu=
m Networks provided compiler at Cisco). Either way, your changes look sane =
so I will check it into CVS now.
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
