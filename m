Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyLAJ-0001lQ-11
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 07:54:27 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyLAC-0005A9-Fw
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 07:54:26 +0000
MIME-Version: 1.0
In-Reply-To: <20091015.142659.457915862171492128.yamato@redhat.com>
References: <1255445034.8438.71.camel@subratamodak.linux.ibm.com>
	<20091014.192322.1139091462053274638.yamato@redhat.com>
	<364299f40910141042j3db8f375u9ce668b55c1089e@mail.gmail.com>
	<20091015.142659.457915862171492128.yamato@redhat.com>
Date: Thu, 15 Oct 2009 00:54:13 -0700
Message-ID: <364299f40910150054o62b491bcrf839428e8b70cbc7@mail.gmail.com>
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

On Wed, Oct 14, 2009 at 10:26 PM, Masatake YAMATO <yamato@redhat.com> wrote:
>> On Wed, Oct 14, 2009 at 3:23 AM, Masatake YAMATO <yamato@redhat.com> wro=
te:
>>> Hi,
>>>
>>>> Except the Makefile part, others would apply fine:
>>>>
>>>> patching file testcases/kernel/syscalls/getuid/Makefile
>>>> Hunk #1 FAILED at 16.
>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>> testcases/kernel/syscalls/getuid/Makefile.rej
>>>> patching file testcases/kernel/syscalls/getuid/getuid01.c
>>>> patching file testcases/kernel/syscalls/getuid/getuid02.c
>>>> patching file testcases/kernel/syscalls/getuid/getuid03.c
>>>
>>> Sorry. I forgot to update my local copy.
>>>
>>> I've just recreated the patch with newer build system.
>>>
>>> To apply getuid-20091015.patch use -p0 option.
>>> Put compat_uid.h =A0at testcases/kernel/syscalls/utils/compat_uid.h.
>>> Put compat_16.h. =A0at testcases/kernel/syscalls/getuid/compat_16.h.
>>>
>>> I've just modified Makefile since last submitting.
>>>
>>>
>>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>>
>> Looks good! One question (just for my personal curiosity), is
>> __NR_geteuid a 16-bit syscall? I'm asking because of this code...
>>
>> UID_T
>> GETUID(void)
>> {
>> =A0 =A0 =A0 return syscall(__NR_getuid);
>> }
>>
>> UID_T
>> GETEUID(void)
>> {
>> =A0 =A0 =A0 return syscall(__NR_geteuid);
>> }
>>
>> If so, what's the 32-bit syscall constant?
>
> I'll explain __NR_getuid32. The explanation may be applicable to __NR_get=
euid32.
> I introduce this hack to keep Makefile and runtest/syscalls simple.
>
>
> On 32 bit architecture(like i386)
> ---------------------------------
> __NR_getuid32 is hardcoded in getuid() and geteuid() implementation of
> glibc. So if you want to use newer __NR_getuid32, use getuid().
>
> This knowledge is converted to source code as:
>
> =A0 =A0UID_T
> =A0 =A0GETUID(void)
> =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0return getuid();
> =A0 =A0}
>
>
>
> If you want to use older one, here syscall is needed.
>
>
> Let's look header file:
>
> =A0 =A0$ uname -m
> =A0 =A0i686
> =A0 =A0$ cat /etc/redhat-release
> =A0 =A0Fedora release 11 (Leonidas)
> =A0 =A0$ grep getuid /usr/include/asm/unistd_32.h
> =A0 =A0#define __NR_getuid =A0 =A0 =A0 =A0 =A024
> =A0 =A0#define __NR_getuid32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 199
>
> We have found __NR_getuid is for older one.
> This knowledge is converted to source code as:
>
> =A0 =A0UID_T
> =A0 =A0GETUID(void)
> =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0return syscall(__NR_getuid);
> =A0 =A0}
>
> We can observe above macro works fine with strace:
>
> =A0 =A0$ strace ./getuid01 2>&1 | grep getuid
> =A0 =A0execve("./getuid01", ["./getuid01"], [/* 25 vars */]) =3D 0
> =A0 =A0getuid32() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D 500
> =A0 =A0write(1, "getuid01 =A0 =A01 =A0TPASS =A0: =A0getuid()"..., 47getui=
d01 =A0 =A01 =A0TPASS =A0: =A0getuid() returned 500
>
> We can know strace represent getuid() invocation on i686 "getuid32()".
>
>
> =A0 =A0$ strace ./getuid01_16 2>&1 | grep getuid
> =A0 =A0execve("./getuid01_16", ["./getuid01_16"], [/* 25 vars */]) =3D 0
> =A0 =A0getuid() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0=3D 500
> =A0 =A0write(1, "getuid01_16 =A0 =A01 =A0TPASS =A0: =A0getui"..., 50getui=
d01_16 =A0 =A01 =A0TPASS =A0: =A0getuid() returned 500
>
> strace represent syscall(__NR_getuid) invocation on i686 "getuid()".
>
>
>
>
> On 64 bit architecture(like x86_64)
> -----------------------------------
> There is only one getuid on such architecture.
> There is no variant.
>
> =A0 =A0$ uname -m
> =A0 =A0x86_64
> =A0 =A0$ grep getuid /usr/include/asm/unistd_64.h
> =A0 =A0#define __NR_getuid =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 102
> =A0 =A0__SYSCALL(__NR_getuid, sys_getuid)
>
> So
>
> =A0 =A0UID_T
> =A0 =A0GETUID(void)
> =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0return syscall(__NR_getuid);
> =A0 =A0}
>
> and
>
> =A0 =A0UID_T
> =A0 =A0GETUID(void)
> =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0return getuid();
> =A0 =A0}
>
> are the same. It means the test cases foo_16 and foo are the same on
> x86_64. Actually strace says:
>
> =A0 =A0$ strace ./getuid01_16 2>&1 | grep getuid
> =A0 =A0execve("./getuid01_16", ["./getuid01_16"], [/* 39 vars */]) =3D 0
> =A0 =A0getuid() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0=3D 500
> =A0 =A0write(1, "getuid01_16 =A0 =A01 =A0TPASS =A0: =A0getui"..., 50getui=
d01_16 =A0 =A01 =A0TPASS =A0: =A0getuid() returned 500
> =A0 =A0$ strace ./getuid01 2>&1 | grep getuid
> =A0 =A0execve("./getuid01", ["./getuid01"], [/* 39 vars */]) =3D 0
> =A0 =A0getuid() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0=3D 500
> =A0 =A0write(1, "getuid01 =A0 =A01 =A0TPASS =A0: =A0getuid()"..., 47getui=
d01 =A0 =A01 =A0TPASS =A0: =A0getuid() returned 500
>
> It is better not to build foo_16 on x86_64. But I think this is
> smaller problem.

    Fascinating. Thanks for the educational explanation Masatake-san!
Yoroshiku ^_^!
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
