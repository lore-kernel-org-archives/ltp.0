Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MOulK-0004GI-W6
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 14:38:14 +0000
Received: from mail-vw0-f202.google.com ([209.85.212.202])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOulD-00069N-8G
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 14:38:14 +0000
Received: by vwj40 with SMTP id 40so152181vwj.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 07:38:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907071659w60004533iec779d402068695@mail.gmail.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
	<1246895458.4887.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
	<364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
	<f5a7b3810907071026t1fe29ce9pb9e61be8374a345@mail.gmail.com>
	<364299f40907071659w60004533iec779d402068695@mail.gmail.com>
Date: Thu, 9 Jul 2009 20:08:06 +0530
Message-ID: <f5a7b3810907090738w748254e4p8683a76110862b4b@mail.gmail.com>
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

On Wed, Jul 8, 2009 at 5:29 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Tue, Jul 7, 2009 at 10:26 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>> Garrett,
result =3D 0
>>> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA=
_SIGINFO
>>>
>>> Program received signal SIG34, Real-time event 34.
>>> 0x00007f770ba0b4f7 in kill () from /lib/libc.so.6
>>> (gdb) where
>>> #0 =A00x00007f770ba0b4f7 in kill () from /lib/libc.so.6
>>> #1 =A00x0000000000401c3e in main ()
>>> (gdb)
>>>
>>
>> =A0/lib/libc.so.6 :
>>
>> This could be issue with glibc.
>> Are you using 2.9 glibc?
>>
>> please Investigate.
>
> =A0 =A0Yes, I am:
>
> gcooper@orangebox /scratch/ltp-vanilla/ltp $ emerge -qpv glibc
> [ebuild =A0 R =A0 ] sys-libs/glibc-2.9_p20081201-r2 =A0USE=3D"(multilib) =
nls
> -debug -gd -glibc-omitfp (-hardened) -profile (-selinux) -vanilla"
> gcooper@orangebox /scratch/ltp-vanilla/ltp $
>
> =A0 =A0Are you suggesting this might be a glibc bug?

I hope... its not a bug with glibc.

please run following command
#/lib/libc.so.6

Is it generating information about glibc and gcc ??

I have tried it on 2.6.29 kernels and glibc 2.9 on X86-32 bit
These test got passed.

Because of that I could not conclude its glibc bug !!!

These test cases are PASSED on ARM/MIPS/X86
I did not check with x86- 64 bit ARCH, becz HardWare is not available.

Subrata,

Have you tested these test cases at your end.
if not please conform the results.
after applying Garrett date on

Best regards
Naresh Kamboju

> -Garrett
>

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
