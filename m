Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1MyIlH-0002xZ-Rg
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 05:20:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyIl9-0006pO-WE
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 05:20:27 +0000
Date: Thu, 15 Oct 2009 14:26:59 +0900 (JST)
Message-Id: <20091015.142659.457915862171492128.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <364299f40910141042j3db8f375u9ce668b55c1089e@mail.gmail.com>
References: <1255445034.8438.71.camel@subratamodak.linux.ibm.com>
	<20091014.192322.1139091462053274638.yamato@redhat.com>
	<364299f40910141042j3db8f375u9ce668b55c1089e@mail.gmail.com>
Mime-Version: 1.0
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sf.net

> On Wed, Oct 14, 2009 at 3:23 AM, Masatake YAMATO <yamato@redhat.com> wrot=
e:
>> Hi,
>>
>>> Except the Makefile part, others would apply fine:
>>>
>>> patching file testcases/kernel/syscalls/getuid/Makefile
>>> Hunk #1 FAILED at 16.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> testcases/kernel/syscalls/getuid/Makefile.rej
>>> patching file testcases/kernel/syscalls/getuid/getuid01.c
>>> patching file testcases/kernel/syscalls/getuid/getuid02.c
>>> patching file testcases/kernel/syscalls/getuid/getuid03.c
>>
>> Sorry. I forgot to update my local copy.
>>
>> I've just recreated the patch with newer build system.
>>
>> To apply getuid-20091015.patch use -p0 option.
>> Put compat_uid.h =A0at testcases/kernel/syscalls/utils/compat_uid.h.
>> Put compat_16.h. =A0at testcases/kernel/syscalls/getuid/compat_16.h.
>>
>> I've just modified Makefile since last submitting.
>>
>>
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> =

> Looks good! One question (just for my personal curiosity), is
> __NR_geteuid a 16-bit syscall? I'm asking because of this code...
> =

> UID_T
> GETUID(void)
> {
> 	return syscall(__NR_getuid);
> }
> =

> UID_T
> GETEUID(void)
> {
> 	return syscall(__NR_geteuid);
> }
> =

> If so, what's the 32-bit syscall constant?

I'll explain __NR_getuid32. The explanation may be applicable to __NR_geteu=
id32.
I introduce this hack to keep Makefile and runtest/syscalls simple.


On 32 bit architecture(like i386) =

---------------------------------
__NR_getuid32 is hardcoded in getuid() and geteuid() implementation of
glibc. So if you want to use newer __NR_getuid32, use getuid().

This knowledge is converted to source code as:

    UID_T
    GETUID(void)
    {
	    return getuid();
    }



If you want to use older one, here syscall is needed.


Let's look header file:

    $ uname -m
    i686
    $ cat /etc/redhat-release =

    Fedora release 11 (Leonidas)
    $ grep getuid /usr/include/asm/unistd_32.h =

    #define __NR_getuid		 24
    #define __NR_getuid32		199

We have found __NR_getuid is for older one.
This knowledge is converted to source code as:

    UID_T
    GETUID(void)
    {
	    return syscall(__NR_getuid);
    }

We can observe above macro works fine with strace: =


    $ strace ./getuid01 2>&1 | grep getuid
    execve("./getuid01", ["./getuid01"], [/* 25 vars */]) =3D 0
    getuid32()                              =3D 500
    write(1, "getuid01    1  TPASS  :  getuid()"..., 47getuid01    1  TPASS=
  :  getuid() returned 500

We can know strace represent getuid() invocation on i686 "getuid32()".


    $ strace ./getuid01_16 2>&1 | grep getuid
    execve("./getuid01_16", ["./getuid01_16"], [/* 25 vars */]) =3D 0
    getuid()                                =3D 500
    write(1, "getuid01_16    1  TPASS  :  getui"..., 50getuid01_16    1  TP=
ASS  :  getuid() returned 500

strace represent syscall(__NR_getuid) invocation on i686 "getuid()".




On 64 bit architecture(like x86_64) =

-----------------------------------
There is only one getuid on such architecture.
There is no variant.

    $ uname -m
    x86_64
    $ grep getuid /usr/include/asm/unistd_64.h =

    #define __NR_getuid				102
    __SYSCALL(__NR_getuid, sys_getuid)

So

    UID_T
    GETUID(void)
    {
	    return syscall(__NR_getuid);
    }

and =


    UID_T
    GETUID(void)
    {
	    return getuid();
    }

are the same. It means the test cases foo_16 and foo are the same on
x86_64. Actually strace says:

    $ strace ./getuid01_16 2>&1 | grep getuid
    execve("./getuid01_16", ["./getuid01_16"], [/* 39 vars */]) =3D 0
    getuid()                                =3D 500
    write(1, "getuid01_16    1  TPASS  :  getui"..., 50getuid01_16    1  TP=
ASS  :  getuid() returned 500
    $ strace ./getuid01 2>&1 | grep getuid
    execve("./getuid01", ["./getuid01"], [/* 39 vars */]) =3D 0
    getuid()                                =3D 500
    write(1, "getuid01    1  TPASS  :  getuid()"..., 47getuid01    1  TPASS=
  :  getuid() returned 500

It is better not to build foo_16 on x86_64. But I think this is
smaller problem.


Masatake YAMATO

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
