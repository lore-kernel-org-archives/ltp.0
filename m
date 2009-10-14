Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My7sA-0006HA-Au
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 17:42:50 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My7s5-0003hZ-H3
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 17:42:50 +0000
MIME-Version: 1.0
In-Reply-To: <20091014.192322.1139091462053274638.yamato@redhat.com>
References: <20091009.154445.548431512384017812.yamato@redhat.com>
	<1255445034.8438.71.camel@subratamodak.linux.ibm.com>
	<20091014.192322.1139091462053274638.yamato@redhat.com>
Date: Wed, 14 Oct 2009 10:42:39 -0700
Message-ID: <364299f40910141042j3db8f375u9ce668b55c1089e@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Masatake YAMATO <yamato@redhat.com>
Cc: ltp-list@lists.sf.net

On Wed, Oct 14, 2009 at 3:23 AM, Masatake YAMATO <yamato@redhat.com> wrote:
> Hi,
>
>> Except the Makefile part, others would apply fine:
>>
>> patching file testcases/kernel/syscalls/getuid/Makefile
>> Hunk #1 FAILED at 16.
>> 1 out of 1 hunk FAILED -- saving rejects to file
>> testcases/kernel/syscalls/getuid/Makefile.rej
>> patching file testcases/kernel/syscalls/getuid/getuid01.c
>> patching file testcases/kernel/syscalls/getuid/getuid02.c
>> patching file testcases/kernel/syscalls/getuid/getuid03.c
>
> Sorry. I forgot to update my local copy.
>
> I've just recreated the patch with newer build system.
>
> To apply getuid-20091015.patch use -p0 option.
> Put compat_uid.h =A0at testcases/kernel/syscalls/utils/compat_uid.h.
> Put compat_16.h. =A0at testcases/kernel/syscalls/getuid/compat_16.h.
>
> I've just modified Makefile since last submitting.
>
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Looks good! One question (just for my personal curiosity), is
__NR_geteuid a 16-bit syscall? I'm asking because of this code...

UID_T
GETUID(void)
{
	return syscall(__NR_getuid);
}

UID_T
GETEUID(void)
{
	return syscall(__NR_geteuid);
}

If so, what's the 32-bit syscall constant?

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
