Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OopEE-0008I6-Q5
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 03:03:42 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OopED-0003hK-8I
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 03:03:42 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id A1ECE980433
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 03:03:34 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id EA85B3DD01E
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 03:03:33 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Aug 2010 12:03:32 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 27 Aug 2010 12:03:31 +0900
Message-ID: <001301cb4594$6e7d4190$4b77c4b0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Build of test cases using "pthread_barrierattr_getpshared"
	failed.
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


I tried to build open_posix_testsuite test cases.
But, in RHEL4.8 systems (x86, x86_64, ia64), some test cases failed to 
build as follows:
------------
[...]
conformance/interfaces/pthread_barrierattr_getpshared/1-1 compile FAILED
/tmp/cceTtlYC.o(.text+0x5c): In function `main':
: undefined reference to `pthread_barrierattr_getpshared'
collect2: ld returned 1 exit status
conformance/interfaces/pthread_barrierattr_getpshared/2-1 compile FAILED
/tmp/ccMhUJvM.o(.text+0x125): In function `main':
: undefined reference to `pthread_barrierattr_getpshared'
collect2: ld returned 1 exit status
conformance/interfaces/pthread_barrierattr_init/1-1 compile FAILED
/tmp/cc6vNdZV.o(.text+0x5c): In function `main':
: undefined reference to `pthread_barrierattr_getpshared'
collect2: ld returned 1 exit status
conformance/interfaces/pthread_barrierattr_init/2-1 compile PASSED
conformance/interfaces/pthread_barrierattr_setpshared/1-1 compile FAILED
/tmp/cc2gjFbd.o(.text+0x9c): In function `main':
: undefined reference to `pthread_barrierattr_getpshared'
/tmp/cc2gjFbd.o(.text+0x128): In function `main':
: undefined reference to `pthread_barrierattr_getpshared'
collect2: ld returned 1 exit status
conformance/interfaces/pthread_barrierattr_setpshared/2-1 compile PASSED
[...]
------------

These errors are linkage error about "pthread_barrierattr_getpshared".

I searched "pthread_barrierattr_getpshared" in libraries (*.a, *.o, *.so*).
I found it in "/usr/lib64/libpthread.a", but the name is 
"__pthread_barrierattr_getpshared":
------------
[root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find / -name \*.a
-print | xargs n
m -o | grep pthread_barrierattr_getpshared
nm: fromhost.o: no symbols
nm: tli.o: no symbols
nm: myvsyslog.o: no symbols
nm: mcst_grp.o: no symbols
[...]
nm: liblua_la-ltests.o: no symbols
nm: ptlongjmp.o: no symbols
nm: oldsemaphore.o: no symbols
/usr/lib64/libpthread.a:barrier.o:0000000000000150 T
__pthread_barrierattr_getpshared
nm: libc-tls-loc.o: no symbols
nm: ptw-lseek.o: no symbols
nm: ptw-lseek64.o: no symbols
[...]
nm: apptype.o: no symbols
nm: fromhost.o: no symbols
nm: tli.o: no symbols
nm: myvsyslog.o: no symbols
[root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
------------

This name includes "__" for prefix.
I think it is strange.

On the other hand, as indicated above, "conformance/interfaces/
pthread_barrierattr_setpshared/2-1" succeeded to build. 
This test case uses "pthread_barrierattr_setpshared", and does not use 
"pthread_barrierattr_getpshared".
I searched "pthread_barrierattr_getpshared" just in case:
------------
[root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find / -name \*.a
-print | xargs n
m -o | grep pthread_barrierattr_setpshared
nm: fromhost.o: no symbols
nm: tli.o: no symbols
nm: myvsyslog.o: no symbols
nm: mcst_grp.o: no symbols
nm: ibmcgrp.o: no symbols
[...]
nm: ptlongjmp.o: no symbols
nm: oldsemaphore.o: no symbols
nm: libc-tls-loc.o: no symbols
/usr/lib64/libpthread.a:barrier.o:0000000000000160 T
pthread_barrierattr_setpshared
nm: ptw-lseek.o: no symbols
nm: ptw-lseek64.o: no symbols
nm: ptw-pread64.o: no symbols
[...]
nm: apptype.o: no symbols
nm: fromhost.o: no symbols
nm: tli.o: no symbols
nm: myvsyslog.o: no symbols
[root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
------------

This name does not include prefix "__".


I think that this linkage error of "pthread_barrierattr_getpshared" is 
caused by the malfunction of RHEL4.8.

Therefore, "SKIPPED" is necessary for the compilation of such above 
test case, I think.
But "SKIPPED" was deleted from last month git.
Can "SKIPPED" be displayed again as before?


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
