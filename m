Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MOEQz-0002oE-MR
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 17:26:25 +0000
Received: from mail-vw0-f202.google.com ([209.85.212.202])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOEQx-0003wQ-0S
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 17:26:25 +0000
Received: by vwj40 with SMTP id 40so3744706vwj.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 10:26:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
	<1246895458.4887.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
	<364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
Date: Tue, 7 Jul 2009 22:56:19 +0530
Message-ID: <f5a7b3810907071026t1fe29ce9pb9e61be8374a345@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCHE] rt_sigaction
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
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

Garrett,

On Tue, Jul 7, 2009 at 10:14 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Tue, Jul 7, 2009 at 4:52 AM, naresh kamboju<naresh.kernel@gmail.com> w=
rote:
>> Hi Garrett Cooper,
>>
>> Thanks for your info.

> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 15 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 36=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 16 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 17 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 3 as
> expected errno =A0=3D EFAULT : Bad address
> gcooper@orangebox /scratch/ltp-vanilla/ltp $ gdb
> testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law. =A0Type "show copyi=
ng"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) r
> Starting program:
> /scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigact=
ion01
> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0signal: 34
> rt_sigaction01 =A0 =A01 =A0PASS =A0: =A0rt_sigaction call succeeded: resu=
lt =3D 0
> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
>
> Program received signal SIG34, Real-time event 34.
> 0x00007f770ba0b4f7 in kill () from /lib/libc.so.6
> (gdb) where
> #0 =A00x00007f770ba0b4f7 in kill () from /lib/libc.so.6
> #1 =A00x0000000000401c3e in main ()
> (gdb)
>

 /lib/libc.so.6 :

This could be issue with glibc.
Are you using 2.9 glibc?

please Investigate.

Best regards,
Naresh Kamboju

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have =

the opportunity to enter the BlackBerry Developer Challenge. See full prize =

details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
