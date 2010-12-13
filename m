Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PS1lP-0005CF-U6
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 06:19:59 +0000
Received: from out22.sjc.mx.trendmicro.com ([216.99.131.79])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PS1lO-0003g2-3c
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 06:19:59 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.134])
	by out22.sjc.mx.trendmicro.com (Postfix) with ESMTP id 0C46698041F
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Dec 2010 06:19:52 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 077A9114B930
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Dec 2010 06:18:28 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Dec 2010 15:18:26 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 13 Dec 2010 15:18:26 +0900
Message-ID: <000001cb9a8d$8d7914e0$a86b3ea0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About POSIX "pthread_mutex_xxxxxxxx" testsets build error
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


The Build of POSIX testset "pthread_mutex_getprioceiling/1-1" failed:
------------
conformance/interfaces/pthread_mutex_getprioceiling/1-1 compile FAILED;
SKIPPING
../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c: In
function `main':
../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:46:
warning: implicit declaration of function `pthread_mutexattr_setprotocol'
../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:47:
error: `PTHREAD_PRIO_INHERIT' undeclared (first use in this function)
../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:47:
error: (Each undeclared identifier is reported only once
../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:47:
error: for each function it appears in.)
../../../conformance/interfaces/pthread_mutex_getprioceiling/1-1.c:62:
warning: implicit declaration of function `pthread_mutex_getprioceiling'
------------

Following POSIX testsets build also failed in same reason:
------------
conformance/interfaces/pthread_mutex_getprioceiling/3-2 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutex_getprioceiling/3-3 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutex_getprioceiling/1-2 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutex_getprioceiling/3-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutex_setprioceiling/1-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_getprioceiling/1-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_getprioceiling/1-2 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_getprioceiling/3-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_getprotocol/1-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_getprotocol/1-2 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_setprioceiling/1-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_setprioceiling/3-2 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_setprioceiling/3-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_setprotocol/1-1 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_setprotocol/3-2 compile FAILED;
SKIPPING
conformance/interfaces/pthread_mutexattr_setprotocol/3-1 compile FAILED;
SKIPPING
------------

The functions which cause to fail are as follows:
------------
pthread_mutex_getprioceiling()
pthread_mutexattr_setprotocol()
pthread_mutexattr_getprotocol()
pthread_mutexattr_setprioceiling()
pthread_mutexattr_getprioceiling()
------------


The failed environment is as follows:
  - RHEL4.8 --- (x86, x86_64, ia64)
  - kernel  --- kernel-2.6.9-89.EL
  - glibc   --- glibc-2.3.4-2.43

RHEL5.5 environment succeeded.


"man" of posix options says:
------------
DESCRIPTION
       The POSIX standard (the information below is from POSIX 1003.1-2001)
describes a set of
       behaviours and interfaces  for  a  compliant  system.   However,
many  interfaces  are
       optional  and  there  are feature test macros to test the
availability of interfaces at
       compile time, and functions sysconf(3), fpathconf(3),  pathconf(3),
confstr(3)  to  do
       this  at  run  time.  From  shell scripts one can use getconf(1).
For more detail, see
       sysconf(3).

       We give the name of the POSIX abbreviation, the  option,  the  name
of  the  sysconf()
       parameter  used  to  inquire  about  the option, and possibly a very
short description.
       Much more precise detail can be found in the POSIX standard itself,
versions  of  which
       can nowadays be accessed freely on the web.

[...]

   TPI - _POSIX_THREAD_PRIO_INHERIT - _SC_THREAD_PRIO_INHERIT
       Affected functions are
           pthread_mutexattr_getprotocol(),
           pthread_mutexattr_setprotocol().

   TPP - _POSIX_THREAD_PRIO_PROTECT - _SC_THREAD_PRIO_PROTECT
       Affected functions are
           pthread_mutex_getprioceiling(),
           pthread_mutex_setprioceiling(),
           pthread_mutexattr_getprioceiling(),
           pthread_mutexattr_getprotocol(),
           pthread_mutexattr_setprioceiling(),
           pthread_mutexattr_setprotocol().
[...]
------------


In failed environment, I confirmed "_POSIX_THREAD_PRIO_INHERIT" and 
"_POSIX_THREAD_PRIO_PROTECT" by "getconf" command, 
and they resulted "undefined":
------------
[root@RHEL48-LTP-EM64T open_posix_testsuite]# getconf
_POSIX_THREAD_PRIO_INHERIT
undefined
[root@RHEL48-LTP-EM64T open_posix_testsuite]# getconf
_POSIX_THREAD_PRIO_PROTECT
undefined
------------

Incidentally, they are defined in RHEL5.5 systems.
------------
[root@RHEL55-x86 ~]# getconf _POSIX_THREAD_PRIO_INHERIT
200112
[root@RHEL55-x86 ~]# getconf _POSIX_THREAD_PRIO_PROTECT
200112
------------


"_POSIX_THREAD_PRIO_INHERIT" and "_POSIX_THREAD_PRIO_PROTECT" are 
supported from RHEL5.0:
------------
<RHEL4.7 em64t>
glibc-headers-2.3.4-2.41.x86_64\usr\include\bits\posix_opt.h

/* No support for priority inheritance or protection.  */
#define _POSIX_THREAD_PRIO_INHERIT	-1
#define _POSIX_THREAD_PRIO_PROTECT	-1


<RHEL4.8 em64t>
glibc-headers-2.3.4-2.43.x86_64\usr\include\bits\posix_opt.h

/* No support for priority inheritance or protection.  */
#define _POSIX_THREAD_PRIO_INHERIT	-1
#define _POSIX_THREAD_PRIO_PROTECT	-1


<RHEL5.0 em64t>
glibc-headers-2.5-12.x86_64\usr\include\bits\posix_opt.h

/* We support priority inheritence.  */
#define _POSIX_THREAD_PRIO_INHERIT	200112L

/* We support priority protection, though only for non-robust
   mutexes.  */
#define _POSIX_THREAD_PRIO_PROTECT	200112L
------------


Cannot "build" be left out before RHEL 4?


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
