Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxnZC-00069S-33
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 20:01:54 +0000
Received: from mail-px0-f177.google.com ([209.85.216.177])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxnZ5-0005i3-UU
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 20:01:54 +0000
MIME-Version: 1.0
In-Reply-To: <1255445034.8438.71.camel@subratamodak.linux.ibm.com>
References: <20091009.154445.548431512384017812.yamato@redhat.com>
	<1255445034.8438.71.camel@subratamodak.linux.ibm.com>
Date: Tue, 13 Oct 2009 13:01:41 -0700
Message-ID: <364299f40910131301p41c9af75mabfd793a20698ee5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Complete the test cases for getuid16
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net

On Tue, Oct 13, 2009 at 7:43 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-10-09 at 15:44 +0900, Masatake YAMATO wrote:
>> Some of testcases for *16 and *64 system calls have not been completed y=
et
>> though my makefile trick were introduced by Suburata. *16 may not be so =
important
>> but I'd like to complete them anyway. The first one is for getuid16.
>>
>> To apply getuid16.patch use -p0 option.
>> Put compat_uid.h =A0at testcases/kernel/syscalls/utils/compat_uid.h.
>> Put compat_16.h. =A0at testcases/kernel/syscalls/getuid/compat_16.h.
>>
>>
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>
> Except the Makefile part, others would apply fine:
>
> patching file testcases/kernel/syscalls/getuid/Makefile
> Hunk #1 FAILED at 16.
> 1 out of 1 hunk FAILED -- saving rejects to file
> testcases/kernel/syscalls/getuid/Makefile.rej
> patching file testcases/kernel/syscalls/getuid/getuid01.c
> patching file testcases/kernel/syscalls/getuid/getuid02.c
> patching file testcases/kernel/syscalls/getuid/getuid03.c
>
> However, this will introduce build breaks as well:
>
> In file included from getuid01.c:119:
> compat_16.h:27:24: error: compat_uid.h: No such file or directory
> In file included from getuid01.c:119:
> compat_16.h:47: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92
> before =91GETUID=92
> compat_16.h:53: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92
> before =91GETEUID=92
> getuid01.c: In function =91main=92:
> getuid01.c:160: warning: implicit declaration of function =91GETUID=92
> getuid01.c:175: warning: format =91%d=92 expects type =91int=92, but argu=
ment 3
> has type =91long int=92
> make[4]: *** [getuid01] Error 1
>
> Can you please take into account the recent changes done by Garret, and,
> then resend this Patch ?

I'll gladly help wherever necessary.
Thanks!
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
