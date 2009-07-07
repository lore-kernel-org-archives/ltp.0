Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOKZ4-0008As-Ed
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 23:59:10 +0000
Received: from an-out-0708.google.com ([209.85.132.249])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOKYx-0007fq-Lg
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 23:59:10 +0000
Received: by an-out-0708.google.com with SMTP id c38so2109628ana.37
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 16:59:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907071026t1fe29ce9pb9e61be8374a345@mail.gmail.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
	<1246895458.4887.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
	<364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
	<f5a7b3810907071026t1fe29ce9pb9e61be8374a345@mail.gmail.com>
Date: Tue, 7 Jul 2009 16:59:02 -0700
Message-ID: <364299f40907071659w60004533iec779d402068695@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

On Tue, Jul 7, 2009 at 10:26 AM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Garrett,
>
> On Tue, Jul 7, 2009 at 10:14 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
>> On Tue, Jul 7, 2009 at 4:52 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>>> Hi Garrett Cooper,
>>>
>>> Thanks for your info.
>
>> expected errno =A0=3D EFAULT : Bad address
>> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
>> rt_sigaction02 =A0 15 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 3=
6 as
>> expected errno =A0=3D EFAULT : Bad address
>>
>> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_=
SIGINFO
>> rt_sigaction02 =A0 16 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 3=
7 as
>> expected errno =A0=3D EFAULT : Bad address
>> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
>> rt_sigaction02 =A0 17 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 3=
7 3 as
>> expected errno =A0=3D EFAULT : Bad address
>> gcooper@orangebox /scratch/ltp-vanilla/ltp $ gdb
>> testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
>> GNU gdb 6.8
>> Copyright (C) 2008 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.=
html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law. =A0Type "show copy=
ing"
>> and "show warranty" for details.
>> This GDB was configured as "x86_64-pc-linux-gnu"...
>> (gdb) r
>> Starting program:
>> /scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigac=
tion01
>> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0signal: 34
>> rt_sigaction01 =A0 =A01 =A0PASS =A0: =A0rt_sigaction call succeeded: res=
ult =3D 0
>> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_=
SIGINFO
>>
>> Program received signal SIG34, Real-time event 34.
>> 0x00007f770ba0b4f7 in kill () from /lib/libc.so.6
>> (gdb) where
>> #0 =A00x00007f770ba0b4f7 in kill () from /lib/libc.so.6
>> #1 =A00x0000000000401c3e in main ()
>> (gdb)
>>
>
> =A0/lib/libc.so.6 :
>
> This could be issue with glibc.
> Are you using 2.9 glibc?
>
> please Investigate.

    Yes, I am:

gcooper@orangebox /scratch/ltp-vanilla/ltp $ emerge -qpv glibc
[ebuild   R   ] sys-libs/glibc-2.9_p20081201-r2  USE=3D"(multilib) nls
-debug -gd -glibc-omitfp (-hardened) -profile (-selinux) -vanilla"
gcooper@orangebox /scratch/ltp-vanilla/ltp $

    Are you suggesting this might be a glibc bug?
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
