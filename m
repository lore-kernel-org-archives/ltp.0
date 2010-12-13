Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PS4Mm-0007YQ-Jo
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 09:06:44 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PS4Ml-0002Ov-8d
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 09:06:44 +0000
Received: by wwi18 with SMTP id 18so5758013wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Dec 2010 01:06:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001cb9a8d$8d7914e0$a86b3ea0$@co.jp>
References: <000001cb9a8d$8d7914e0$a86b3ea0$@co.jp>
Date: Mon, 13 Dec 2010 01:06:37 -0800
Message-ID: <AANLkTimzqyecsZDJBu+UbbT96RVhmgq3=8ZRLHSDtVdW@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About POSIX "pthread_mutex_xxxxxxxx" testsets build error
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Sun, Dec 12, 2010 at 10:18 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> The Build of POSIX testset "pthread_mutex_getprioceiling/1-1" failed:
> ------------
> conformance/interfaces/pthread_mutex_getprioceiling/1-1 compile FAILED;
> SKIPPING
> ../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c: In
> function `main':
> ../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:46:
> warning: implicit declaration of function `pthread_mutexattr_setprotocol'
> ../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:47:
> error: `PTHREAD_PRIO_INHERIT' undeclared (first use in this function)
> ../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:47:
> error: (Each undeclared identifier is reported only once
> ../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:47:
> error: for each function it appears in.)
> ../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:62:
> warning: implicit declaration of function `pthread_mutex_getprioceiling'
> ------------
>
> Following POSIX testsets build also failed in same reason:
> ------------
> conformance/interfaces/pthread_mutex_getprioceiling/3-2 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutex_getprioceiling/3-3 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutex_getprioceiling/1-2 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutex_getprioceiling/3-1 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutex_setprioceiling/1-1 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_getprioceiling/1-1 compile FAILE=
D;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_getprioceiling/1-2 compile FAILE=
D;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_getprioceiling/3-1 compile FAILE=
D;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_getprotocol/1-1 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_getprotocol/1-2 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_setprioceiling/1-1 compile FAILE=
D;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_setprioceiling/3-2 compile FAILE=
D;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_setprioceiling/3-1 compile FAILE=
D;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_setprotocol/1-1 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_setprotocol/3-2 compile FAILED;
> SKIPPING
> conformance/interfaces/pthread_mutexattr_setprotocol/3-1 compile FAILED;
> SKIPPING
> ------------
>
> The functions which cause to fail are as follows:
> ------------
> pthread_mutex_getprioceiling()
> pthread_mutexattr_setprotocol()
> pthread_mutexattr_getprotocol()
> pthread_mutexattr_setprioceiling()
> pthread_mutexattr_getprioceiling()
> ------------
>
>
> The failed environment is as follows:
> =A0- RHEL4.8 --- (x86, x86_64, ia64)
> =A0- kernel =A0--- kernel-2.6.9-89.EL
> =A0- glibc =A0 --- glibc-2.3.4-2.43
>
> RHEL5.5 environment succeeded.
>
>
> "man" of posix options says:
> ------------
> DESCRIPTION
> =A0 =A0 =A0 The POSIX standard (the information below is from POSIX 1003.=
1-2001)
> describes a set of
> =A0 =A0 =A0 behaviours and interfaces =A0for =A0a =A0compliant =A0system.=
 =A0 However,
> many =A0interfaces =A0are
> =A0 =A0 =A0 optional =A0and =A0there =A0are feature test macros to test t=
he
> availability of interfaces at
> =A0 =A0 =A0 compile time, and functions sysconf(3), fpathconf(3), =A0path=
conf(3),
> confstr(3) =A0to =A0do
> =A0 =A0 =A0 this =A0at =A0run =A0time. =A0From =A0shell scripts one can u=
se getconf(1).
> For more detail, see
> =A0 =A0 =A0 sysconf(3).
>
> =A0 =A0 =A0 We give the name of the POSIX abbreviation, the =A0option, =
=A0the =A0name
> of =A0the =A0sysconf()
> =A0 =A0 =A0 parameter =A0used =A0to =A0inquire =A0about =A0the option, an=
d possibly a very
> short description.
> =A0 =A0 =A0 Much more precise detail can be found in the POSIX standard i=
tself,
> versions =A0of =A0which
> =A0 =A0 =A0 can nowadays be accessed freely on the web.
>
> [...]
>
> =A0 TPI - _POSIX_THREAD_PRIO_INHERIT - _SC_THREAD_PRIO_INHERIT
> =A0 =A0 =A0 Affected functions are
> =A0 =A0 =A0 =A0 =A0 pthread_mutexattr_getprotocol(),
> =A0 =A0 =A0 =A0 =A0 pthread_mutexattr_setprotocol().
>
> =A0 TPP - _POSIX_THREAD_PRIO_PROTECT - _SC_THREAD_PRIO_PROTECT
> =A0 =A0 =A0 Affected functions are
> =A0 =A0 =A0 =A0 =A0 pthread_mutex_getprioceiling(),
> =A0 =A0 =A0 =A0 =A0 pthread_mutex_setprioceiling(),
> =A0 =A0 =A0 =A0 =A0 pthread_mutexattr_getprioceiling(),
> =A0 =A0 =A0 =A0 =A0 pthread_mutexattr_getprotocol(),
> =A0 =A0 =A0 =A0 =A0 pthread_mutexattr_setprioceiling(),
> =A0 =A0 =A0 =A0 =A0 pthread_mutexattr_setprotocol().
> [...]
> ------------
>
>
> In failed environment, I confirmed "_POSIX_THREAD_PRIO_INHERIT" and
> "_POSIX_THREAD_PRIO_PROTECT" by "getconf" command,
> and they resulted "undefined":
> ------------
> [root@RHEL48-LTP-EM64T open_posix_testsuite]# getconf
> _POSIX_THREAD_PRIO_INHERIT
> undefined
> [root@RHEL48-LTP-EM64T open_posix_testsuite]# getconf
> _POSIX_THREAD_PRIO_PROTECT
> undefined
> ------------
>
> Incidentally, they are defined in RHEL5.5 systems.
> ------------
> [root@RHEL55-x86 ~]# getconf _POSIX_THREAD_PRIO_INHERIT
> 200112
> [root@RHEL55-x86 ~]# getconf _POSIX_THREAD_PRIO_PROTECT
> 200112
> ------------
>
>
> "_POSIX_THREAD_PRIO_INHERIT" and "_POSIX_THREAD_PRIO_PROTECT" are
> supported from RHEL5.0:
> ------------
> <RHEL4.7 em64t>
> glibc-headers-2.3.4-2.41.x86_64\usr\include\bits\posix_opt.h
>
> /* No support for priority inheritance or protection. =A0*/
> #define _POSIX_THREAD_PRIO_INHERIT =A0 =A0 =A0-1
> #define _POSIX_THREAD_PRIO_PROTECT =A0 =A0 =A0-1
>
>
> <RHEL4.8 em64t>
> glibc-headers-2.3.4-2.43.x86_64\usr\include\bits\posix_opt.h
>
> /* No support for priority inheritance or protection. =A0*/
> #define _POSIX_THREAD_PRIO_INHERIT =A0 =A0 =A0-1
> #define _POSIX_THREAD_PRIO_PROTECT =A0 =A0 =A0-1
>
>
> <RHEL5.0 em64t>
> glibc-headers-2.5-12.x86_64\usr\include\bits\posix_opt.h
>
> /* We support priority inheritence. =A0*/
> #define _POSIX_THREAD_PRIO_INHERIT =A0 =A0 =A0200112L
>
> /* We support priority protection, though only for non-robust
> =A0 mutexes. =A0*/
> #define _POSIX_THREAD_PRIO_PROTECT =A0 =A0 =A0200112L
> ------------
>
>
> Cannot "build" be left out before RHEL 4?

No. Anyone who should be building these tests should understand what
NPTL provides, what it doesn't provide, and then tailor things locally
.

No Linux hacks to build, omit building, etc are going to go into the
open_posix_testsuite in LTP. Same thing for FreeBSD, OSX, OpenBSD,
Windows, whatever. Period. Hopefully I've made myself clear this time.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, =

OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
