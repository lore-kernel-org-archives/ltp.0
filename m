Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PAYc0-0003Sk-DS
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 01:46:04 +0000
Received: from out22.sjc.mx.trendmicro.com ([216.99.131.79])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PAYbx-0000KH-84
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 01:46:04 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.23])
	by out22.sjc.mx.trendmicro.com (Postfix) with ESMTP id 4B49798041C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Oct 2010 01:45:54 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id CB868114B85B
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Oct 2010 01:45:53 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Oct 2010 10:45:51 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 26 Oct 2010 10:45:53 +0900
Message-ID: <000001cb74af$8658b390$930a1ab0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About POSIX "sched_yield/1-1.c" buld failure
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

I reported that build failure of POSIX test set "conformance/interfaces/
sched_yield/1-1" was still left in RHEL4.8 system:

http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10713.html

In addition, build of the following tests failed by the reason of 
"undefined reference":
------------
conformance/interfaces/pthread_barrierattr_getpshared/1-1
conformance/interfaces/pthread_barrierattr_getpshared/2-1
conformance/interfaces/pthread_barrierattr_init/1-1
conformance/interfaces/pthread_barrierattr_setpshared/1-1
conformance/interfaces/pthread_cond_broadcast/1-2
conformance/interfaces/pthread_cond_broadcast/2-3
conformance/interfaces/pthread_cond_destroy/2-1
conformance/interfaces/pthread_cond_init/1-2
conformance/interfaces/pthread_cond_init/2-2
conformance/interfaces/pthread_cond_init/4-1
conformance/interfaces/pthread_cond_init/4-2
conformance/interfaces/pthread_cond_signal/1-2
conformance/interfaces/pthread_cond_timedwait/2-4
conformance/interfaces/pthread_cond_timedwait/2-5
conformance/interfaces/pthread_cond_timedwait/2-6
conformance/interfaces/pthread_cond_timedwait/2-7
conformance/interfaces/pthread_cond_timedwait/4-2
conformance/interfaces/pthread_cond_wait/2-2
conformance/interfaces/pthread_cond_wait/2-3
conformance/interfaces/pthread_condattr_getclock/1-1
conformance/interfaces/pthread_condattr_getclock/1-2
conformance/interfaces/pthread_condattr_setclock/1-1
conformance/interfaces/pthread_condattr_setclock/1-2
conformance/interfaces/pthread_condattr_setclock/1-3
conformance/interfaces/pthread_condattr_setclock/2-1
conformance/interfaces/pthread_getschedparam/1-3
conformance/interfaces/pthread_mutex_getprioceiling/1-1
conformance/interfaces/pthread_mutexattr_getprioceiling/1-1
conformance/interfaces/pthread_mutexattr_getprioceiling/1-2
conformance/interfaces/pthread_mutexattr_getprioceiling/3-1
conformance/interfaces/pthread_mutexattr_getprotocol/1-1
conformance/interfaces/pthread_mutexattr_getprotocol/1-2
conformance/interfaces/pthread_mutexattr_setprioceiling/1-1
conformance/interfaces/pthread_mutexattr_setprioceiling/3-1
conformance/interfaces/pthread_mutexattr_setprioceiling/3-2
conformance/interfaces/pthread_mutexattr_setprotocol/1-1
conformance/interfaces/pthread_mutexattr_setprotocol/3-1
conformance/interfaces/pthread_mutexattr_setprotocol/3-2
conformance/interfaces/pthread_setschedprio/1-1
conformance/interfaces/sched_yield/1-1
------------

The environment is as follows:
  - RHEL4.8 --- (x86, x86_64, ia64)
  - kernel  --- kernel-2.6.9-89.EL
  - glibc   --- glibc-2.3.4-2.43


But I found out a method of avoidance of some of these failures.
And I succeeded to build "conformance/interfaces/sched_yield/1-1".



For example, the log of "conformance/interfaces/
pthread_barrierattr_getpshared/1-1" is as follows:
------------
conformance/interfaces/pthread_barrierattr_getpshared/1-1 compile FAILED;
SKIPPING
/tmp/cc8gB5Qj.o(.text+0x3e): In function `main':
: undefined reference to `pthread_barrierattr_getpshared'
collect2: ld returned 1 exit status
------------

I extracted insufficient functions from these logs:
------------
pthread_barrierattr_getpshared
pthread_condattr_getclock
pthread_condattr_setcloc
pthread_condattr_setclock
pthread_mutex_getprioceiling
pthread_mutexattr_getprioceiling
pthread_mutexattr_getprotocol
pthread_mutexattr_setprioceiling
pthread_mutexattr_setprotocol
pthread_setaffinity_np
pthread_setschedprio
------------

In RHEL3.x/RHEL4.x systems, some of these functions were included in 
nptl-devel package.

I did the followings:
  1. Installed nptl-devel package.

  2. Exported LIBRARY_PATH:
       export LIBRARY_PATH=/usr/lib/nptl
       export LIBRARY_PATH=/usr/lib64/nptl       ---(in x86_64)

  3. Added "-lpthread" to "conformance/interfaces/lio_listio/LDLIBS" file.


Is the method mentioned above right?







---
postscript:

Now, build of the following tests failed even if I took the method 
mentioned above:
------------
conformance/interfaces/pthread_mutex_getprioceiling/1-1
conformance/interfaces/pthread_mutexattr_getprioceiling/1-1
conformance/interfaces/pthread_mutexattr_getprioceiling/1-2
conformance/interfaces/pthread_mutexattr_getprioceiling/3-1
conformance/interfaces/pthread_mutexattr_getprotocol/1-1
conformance/interfaces/pthread_mutexattr_getprotocol/1-2
conformance/interfaces/pthread_mutexattr_setprioceiling/1-1
conformance/interfaces/pthread_mutexattr_setprioceiling/3-1
conformance/interfaces/pthread_mutexattr_setprioceiling/3-2
conformance/interfaces/pthread_mutexattr_setprotocol/1-1
conformance/interfaces/pthread_mutexattr_setprotocol/3-1
conformance/interfaces/pthread_mutexattr_setprotocol/3-2
------------

The insufficient functions are as follows:
------------
pthread_mutex_getprioceiling
pthread_mutexattr_getprotocol
pthread_mutexattr_getprioceiling
pthread_mutexattr_setprioceiling
------------

The man-page of these functions exist, but the definitions don't exist 
in header files.
------------
[root@RHEL48-LTP-EM64T ~]# grep -r pthread_mutex_getprioceiling /usr/include
[root@RHEL48-LTP-EM64T ~]# grep -r pthread_mutexattr_getprotocol
/usr/include
[root@RHEL48-LTP-EM64T ~]# grep -r pthread_mutexattr_getprioceiling
/usr/include
[root@RHEL48-LTP-EM64T ~]# grep -r pthread_mutexattr_setprioceiling
/usr/include
[root@RHEL48-LTP-EM64T ~]# 
------------

And there aren't these functions in libraries.
------------
[root@RHEL48-LTP-EM64T ~]# nm /usr/lib/*.a | grep pthread_mutex
nm: vsnprintf_nonpic.o: no symbols
nm: mt_support.o: no symbols
nm: snprintf.o: no symbols
[...]
nm: strtol.o: no symbols
nm: strtoul.o: no symbols
nm: cmu_compat.o: no symbols

[root@RHEL48-LTP-EM64T ~]# nm /usr/lib64/*.a | grep
pthread_mutexattr_getprotocol
nm: getopt.o: no symbols
nm: getopt1.o: no symbols
nm: aesopt.o: no symbols
[...]
nm: strtol.o: no symbols
nm: strtoul.o: no symbols
nm: cmu_compat.o: no symbols

[root@RHEL48-LTP-EM64T ~]# nm /usr/lib64/nptl/*.a | grep
pthread_mutex_getprioceiling
nm: old_atexit.o: no symbols
nm: strtoll.o: no symbols
nm: strtoull.o: no symbols
[...]
nm: ptw-pwrite64.o: no symbols
nm: pthread_kill_other_threads.o: no symbols
nm: shm_unlink.o: no symbols
------------

I think that I have to investigate about these a little more.



Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
