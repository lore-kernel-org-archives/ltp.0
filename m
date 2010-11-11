Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PGSGT-00065M-3d
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:12:13 +0000
Received: from out13.sjc.mx.trendmicro.com ([216.99.131.50])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGSGO-0007VQ-Em
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:12:13 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.135])
	by out13.sjc.mx.trendmicro.com (Postfix) with ESMTP id D8AC398042A
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 08:12:01 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 748579583A
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 08:12:01 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 17:11:59 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 11 Nov 2010 17:11:59 +0900
Message-ID: <000301cb8178$1ce4dad0$56ae9070$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] =?iso-2022-jp?b?QWJvdXQgUE9TSVgbJEIhIRsoQmJ1aWxkIGZhaWx1?=
	=?iso-2022-jp?b?cmU=?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

Build of POSIX tests failed:
------------
conformance/behavior/timers/1-1 compile FAILED; SKIPPING
conformance/behavior/timers/2-1 compile FAILED; SKIPPING
conformance/definitions/mqueue_h/1-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/8-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/9-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/7-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/12-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/5-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/1-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/13-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/20-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/22-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/18-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/21-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/23-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/25-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/4-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/24-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/6-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/11-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/14-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/2-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/17-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/15-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/16-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/19-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/10-1 compile FAILED; SKIPPING
conformance/interfaces/lio_listio/3-1 compile FAILED; SKIPPING
------------

Error message is as follows:
------------
/lib64/libpthread.so.0: undefined reference to
`__libc_malloc_pthread_startup@GLIBC_PRIVATE'
/usr/lib64/nptl/librt.so: undefined reference to
`__pthread_unwind@GLIBC_PRIVATE'
/usr/lib64/nptl/librt.so: undefined reference to
`__pthread_register_cancel@GLIBC_2.3.3'
/lib64/libpthread.so.0: undefined reference to `__on_exit@GLIBC_PRIVATE'
/lib64/libpthread.so.0: undefined reference to `_errno@GLIBC_2.2.5'
/usr/lib64/nptl/librt.so: undefined reference to
`__pthread_unregister_cancel@GLIBC_2.3.3'
/lib64/libpthread.so.0: undefined reference to `_h_errno@GLIBC_2.2.5'
/usr/lib64/nptl/librt.so: undefined reference to
`__pthread_unwind_next@GLIBC_2.3.3'
/lib64/libpthread.so.0: undefined reference to
`__libc_sigaction@GLIBC_PRIVATE'
collect2: ld returned 1 exit status
------------

Environment is as follows:
  - RHEL4.8 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)


I did the following environment setting in my systems:
------------
export LIBRARY_PATH=/usr/lib64/nptl
------------

This id for build of following tests.
These need the installing of nptl-devel package.
------------
conformance/interfaces/pthread_barrierattr_getpshared
conformance/interfaces/pthread_barrierattr_init
conformance/interfaces/pthread_barrierattr_setpshared
conformance/interfaces/pthread_cond_broadcast
conformance/interfaces/pthread_cond_destroy
conformance/interfaces/pthread_cond_init
conformance/interfaces/pthread_cond_signal
conformance/interfaces/pthread_cond_timedwait
conformance/interfaces/pthread_cond_wait
conformance/interfaces/pthread_condattr_getclock
conformance/interfaces/pthread_condattr_setclock
conformance/interfaces/pthread_getschedparam
conformance/interfaces/pthread_setschedprio
conformance/interfaces/sched_yield
------------

Therefore I added "-lpthread" to following files:
------------
testcases/open_posix_testsuite/conformance/behavior/timers/LDLIBS
testcases/open_posix_testsuite/conformance/definitions/mqueue_h/LDLIBS
testcases/open_posix_testsuite/conformance/interfaces/lio_listio/LDLIBS
------------

After this, build succeeded.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
