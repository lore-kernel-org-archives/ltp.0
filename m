Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTls8-0006gY-Sz
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 00:09:20 +0000
Received: from wf-out-1314.google.com ([209.85.200.168])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTlrr-0005Z3-ID
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 00:09:07 +0000
MIME-Version: 1.0
In-Reply-To: <OFC57A047B.CF64D210-ON852575FB.007EFB24-852575FB.0081AD79@us.ibm.com>
References: <OFC57A047B.CF64D210-ON852575FB.007EFB24-852575FB.0081AD79@us.ibm.com>
Date: Wed, 22 Jul 2009 17:09:01 -0700
Message-ID: <364299f40907221709y76a783e2t68edcb2add6d77e6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] eventfd2_03
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sf.net

On Wed, Jul 22, 2009 at 4:36 PM, Mark Ver<markver@us.ibm.com> wrote:
> Hi,
>
> Just recently downloaded the 20090630 version LTP. But it looks like there
> is a new testcase "eventfd2_03" included as part of default which is gett=
ing
> a compile problem and causing the LTP build to abort on s390x architectur=
e:
>
> ...
> make[4]: Entering directory
> `/root/ltp-full-20090630/testcases/kernel/syscalls/eventfd2'
> gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall
> eventfd2_03.c -L../../../../lib -lltp -o eventfd2_03
> eventfd2_03.c:48:2: error: #error Cannot detect your architecture!
> eventfd2_03.c: In function =91eventfd2=92:
> eventfd2_03.c:54: error: =91__NR_eventfd2=92 undeclared (first use in this
> function)
> eventfd2_03.c:54: error: (Each undeclared identifier is reported only once
> eventfd2_03.c:54: error: for each function it appears in.)
> eventfd2_03.c: In function =91xsem_wait=92:
> eventfd2_03.c:65: warning: format =91%llu=92 expects type =91long long un=
signed
> int=92, but argument 5 has type =91u_int64_t=92
> eventfd2_03.c: In function =91main=92:
> eventfd2_03.c:129: warning: implicit declaration of function =91waitpid=
=92
> make[4]: *** [eventfd2_03] Error 1
> make[4]: Leaving directory
> `/root/ltp-full-20090630/testcases/kernel/syscalls/eventfd2'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/ltp-full-20090630/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp-full-20090630/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-full-20090630/testcases'
> make: *** [all] Error 2
> [root@m36distro2 ltp-full-20090630]#
>
>
> Looking at the code it does:
>
> #ifndef __NR_eventfd2
> #if defined(__x86_64__)
> #define __NR_eventfd2 290
> #elif defined(__i386__)
> #define __NR_eventfd2 328
> #else
> #error Cannot detect your architecture!
> #endif
> #endif
>
> So right away it looks like this test is expecting some PC based features
> and may not work on any architecture except x86_64 and i386 compatible
> systems. Not really sure why it got included as part of the default set of
> testcases or why configure script did not weed it out as not for s390/s39=
0x.
>
> The testcase seems to be new and is not there on the 20090228 release. I'=
ve
> heard that folks were successful using the 2009 May release as well, so t=
his
> looks to be just an issue in the 20090630 release.

Mark,
    All of the issues minus the syscalls on have been solved.
As for it not compiling on x86 / x86_64, yes, it will need to be
removed from the compile list. We're not there yet though with the
Makefiles, so until then, maybe this should be yanked from the default
build?
    I can't seem to find anything that clearly states that this is
strictly an x86 specific kernel feature though, so maybe the syscalls
just need to be filled in...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
