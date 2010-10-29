Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PBjUZ-00053D-Aw
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 07:35:15 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBjUX-0002h1-OD
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 07:35:15 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.78])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id 8153C98042D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 07:35:07 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id D4A07114B87D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Oct 2010 07:35:06 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Oct 2010 16:35:04 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 29 Oct 2010 16:35:05 +0900
Message-ID: <000001cb773b$ce4f9950$6aeecbf0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About "realtime" build failure
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

I applied patches which are the effort of various people.
And I could overcome configuration error and keyctl01's build error.
(Thanks!!)
After that, librttest.c build failed:
------------
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101028/testcases/network/xinetd'
make[2]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases/network'
make[2]: Entering directory `/home/LTP/ltp-dev-20101028/testcases/realtime'
make -C lib -f "/home/LTP/ltp-dev-20101028/testcases/realtime/lib/Makefile"
all
make[3]: Entering directory
`/home/LTP/ltp-dev-20101028/testcases/realtime/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101028/testcases/realtime/lib/../include
-I../../../include -I../../../include  -c -o librttest.o librttest.c
librttest.c: In function `init_pi_mutex':
librttest.c:569: warning: implicit declaration of function
`pthread_mutexattr_setprotocol'
librttest.c:569: error: `PTHREAD_PRIO_INHERIT' undeclared (first use in this
function)
librttest.c:569: error: (Each undeclared identifier is reported only once
librttest.c:569: error: for each function it appears in.)
librttest.c:572: warning: implicit declaration of function
`pthread_mutexattr_getprotocol'
make[3]: *** [librttest.o] Error 1
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101028/testcases/realtime/lib'
make[2]: *** [lib/librealtime.a] Error 2
make[2]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases/realtime'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases'
make: *** [testcases-all] Error 2
------------

"realtime" became to be build by the patch of Makefile:
------------
--- a/testcases/Makefile
+++ b/testcases/Makefile
 @@ -38,7 +38,12 @@ FILTER_OUT_DIRS              := ballista kdump mce-test
open% pounder21
  # XXX (garrcoop): kdump was in this list.
  # XXX (garrcoop): open_hpi_testsuite was in this list.
  ifeq ($(UCLINUX),1)
 -FILTER_OUT_DIRS                += DOTS realtime
 +FILTER_OUT_DIRS                += realtime
 +endif
 +
 +# DOTS requires javac
 +ifeq ($(strip $(JAVAC)),)
 +FILTER_OUT_DIRS                += DOTS
  endif
  
  #
------------

"realtime" added to build.
Perhaps this revision caused this failure, I think.


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
