Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGSWH-0007QI-AG
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:28:33 +0000
Received: from mail-ww0-f48.google.com ([74.125.82.48])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGSWG-0005Dr-5k
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:28:33 +0000
Received: by wwb17 with SMTP id 17so1751957wwb.5
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 00:28:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000301cb8178$1ce4dad0$56ae9070$@co.jp>
References: <000301cb8178$1ce4dad0$56ae9070$@co.jp>
Date: Thu, 11 Nov 2010 00:28:25 -0800
Message-ID: <AANLkTik_oRk_-u4ZtsH1UH=Ohkpv_aeBDTY+_Ch6nVeN@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About POSIX build failure
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

On Thu, Nov 11, 2010 at 12:11 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> Build of POSIX tests failed:
> ------------
> conformance/behavior/timers/1-1 compile FAILED; SKIPPING
> conformance/behavior/timers/2-1 compile FAILED; SKIPPING
> conformance/definitions/mqueue_h/1-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/8-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/9-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/7-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/12-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/5-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/1-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/13-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/20-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/22-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/18-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/21-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/23-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/25-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/4-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/24-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/6-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/11-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/14-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/2-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/17-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/15-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/16-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/19-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/10-1 compile FAILED; SKIPPING
> conformance/interfaces/lio_listio/3-1 compile FAILED; SKIPPING
> ------------
>
> Error message is as follows:
> ------------
> /lib64/libpthread.so.0: undefined reference to
> `__libc_malloc_pthread_startup@GLIBC_PRIVATE'
> /usr/lib64/nptl/librt.so: undefined reference to
> `__pthread_unwind@GLIBC_PRIVATE'
> /usr/lib64/nptl/librt.so: undefined reference to
> `__pthread_register_cancel@GLIBC_2.3.3'
> /lib64/libpthread.so.0: undefined reference to `__on_exit@GLIBC_PRIVATE'
> /lib64/libpthread.so.0: undefined reference to `_errno@GLIBC_2.2.5'
> /usr/lib64/nptl/librt.so: undefined reference to
> `__pthread_unregister_cancel@GLIBC_2.3.3'
> /lib64/libpthread.so.0: undefined reference to `_h_errno@GLIBC_2.2.5'
> /usr/lib64/nptl/librt.so: undefined reference to
> `__pthread_unwind_next@GLIBC_2.3.3'
> /lib64/libpthread.so.0: undefined reference to
> `__libc_sigaction@GLIBC_PRIVATE'
> collect2: ld returned 1 exit status
> ------------
>
> Environment is as follows:
> =A0- RHEL4.8 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)
>
>
> I did the following environment setting in my systems:
> ------------
> export LIBRARY_PATH=3D/usr/lib64/nptl
> ------------
>
> This id for build of following tests.
> These need the installing of nptl-devel package.
> ------------
> conformance/interfaces/pthread_barrierattr_getpshared
> conformance/interfaces/pthread_barrierattr_init
> conformance/interfaces/pthread_barrierattr_setpshared
> conformance/interfaces/pthread_cond_broadcast
> conformance/interfaces/pthread_cond_destroy
> conformance/interfaces/pthread_cond_init
> conformance/interfaces/pthread_cond_signal
> conformance/interfaces/pthread_cond_timedwait
> conformance/interfaces/pthread_cond_wait
> conformance/interfaces/pthread_condattr_getclock
> conformance/interfaces/pthread_condattr_setclock
> conformance/interfaces/pthread_getschedparam
> conformance/interfaces/pthread_setschedprio
> conformance/interfaces/sched_yield

    Well, yeah... the directions at the top of the build directory
specify that as well. Linux didn't have real pthreads until some time
shortly before 2.6 came out IIRC and Redhat tends to twiddle their
thumbs when it comes to new features on RHEL (or at least they did
back in the RH 7.x ~ RHEL 4.x days).

> ------------
>
> Therefore I added "-lpthread" to following files:
> ------------
> testcases/open_posix_testsuite/conformance/behavior/timers/LDLIBS

    This doesn't make sense.

> testcases/open_posix_testsuite/conformance/definitions/mqueue_h/LDLIBS

    Neither does this.

> testcases/open_posix_testsuite/conformance/interfaces/lio_listio/LDLIBS

    And neither does this!
    Redhat is a hacky OS that needed to be fixed, but since it was the
defacto standard for a long time it never was... None of the above
items are in the threading group in POSIX, so they shouldn't require a
library. Furthermore, the 2 former items are looking only for
definitions, so I don't know why a library would quiesce the compiler,
and the latter should depend on libaio (if anything) in Linux.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
