Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1X2jzo-0000c6-7v
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 16:36:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X2jzm-0005jh-Bo
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 16:36:28 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s63GaJcO012150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Jul 2014 12:36:20 -0400
Received: from tarantula.localdomain (vpn-59-246.rdu2.redhat.com
	[10.10.59.246])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s63GaHhx006781
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Jul 2014 12:36:19 -0400
Date: Thu, 3 Jul 2014 11:36:17 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20140703163617.GB5081@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] sched_setparam{02,03} failures on 3.14 and newer kernels
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

I'm getting failures with the sched_setparam02 and sched_setparam03 tests on
the 3.14 and 3.15 kernels in Fedora that did not happen on 3.13.  Did something
change in the upstream kernel?  Do the tests need to be updated?


3.13 passes:
===============================================================================
[root@localhost bin]# uname -r
3.13.8-200.fc20.x86_64
[root@localhost bin]# ./sched_setparam02
sched_setparam02    1  TPASS  :  Test with policy SCHED_FIFO Passed
sched_setparam02    2  TPASS  :  Test with policy SCHED_RR Passed
sched_setparam02    3  TPASS  :  Test with SCHED_OTHER Passed
[root@localhost bin]# ./sched_setparam03
sched_setparam03    1  TPASS  :  Test Passed
===============================================================================

3.14 fails:
===============================================================================
[root@localhost bin]# uname -r
3.14.9-200.fc20.x86_64
[root@localhost bin]# ./sched_setparam02
sched_setparam02    0  TWARN  :  sched_getparam() returned priority value as 0
sched_setparam02    1  TFAIL  :  Test with policy SCHED_FIFO Failed.
                   sched_setparam() returned 0: TEST_ERRNO=SUCCESS(0): Success
sched_setparam02    0  TWARN  :  sched_getparam() returned priority value as 0
sched_setparam02    2  TFAIL  :  Test with policy SCHED_RR Failed.
                   sched_setparam() returned 0: TEST_ERRNO=SUCCESS(0): Success
sched_setparam02    3  TPASS  :  Test with SCHED_OTHER Passed
[root@localhost bin]# ./sched_setparam03
sched_setparam03    0  TWARN  :  sched_getparam() returned priority value as 0
sched_setparam03    1  TFAIL  :  Test Failed
===============================================================================

3.15 also fails:
===============================================================================
[root@localhost bin]# uname -r
3.15.3-200.fc20.x86_64
[root@localhost bin]# ./sched_setparam02
sched_setparam02    0  TWARN  :  sched_getparam() returned priority value as 0
sched_setparam02    1  TFAIL  :  Test with policy SCHED_FIFO Failed.
                   sched_setparam() returned 0: TEST_ERRNO=SUCCESS(0): Success
sched_setparam02    0  TWARN  :  sched_getparam() returned priority value as 0
sched_setparam02    2  TFAIL  :  Test with policy SCHED_RR Failed.
                   sched_setparam() returned 0: TEST_ERRNO=SUCCESS(0): Success
sched_setparam02    3  TPASS  :  Test with SCHED_OTHER Passed
[root@localhost bin]# ./sched_setparam03
sched_setparam03    0  TWARN  :  sched_getparam() returned priority value as 0
sched_setparam03    1  TFAIL  :  Test Failed
===============================================================================


Running it through strace confirms that getparam is not returning the same
value that the test sets with setparam.

3.13 getparam == setparam:
===============================================================================
[root@localhost bin]# uname -r
3.13.8-200.fc20.x86_64
[root@localhost bin]# strace \
    -e trace=sched_setscheduler,sched_setparam,sched_getparam \
    ./sched_setparam02 >/dev/null
sched_setscheduler(0, SCHED_FIFO, { 1 }) = 0
sched_setparam(0, { 5 })                = 0
sched_getparam(0, { 5 })                = 0
sched_setscheduler(0, SCHED_RR, { 1 })  = 0
sched_setparam(0, { 5 })                = 0
sched_getparam(0, { 5 })                = 0
sched_setscheduler(0, SCHED_OTHER, { 0 }) = 0
sched_setparam(0, { 0 })                = 0
sched_getparam(0, { 0 })                = 0
+++ exited with 0 +++
===============================================================================

3.14 getparam != setparam:
===============================================================================
[root@localhost bin]# uname -r
3.14.9-200.fc20.x86_64
[root@localhost bin]# strace \
    -e trace=sched_setscheduler,sched_setparam,sched_getparam \
    ./sched_setparam02 >/dev/null
sched_setscheduler(0, SCHED_FIFO, { 1 }) = 0
sched_setparam(0, { 5 })                = 0
sched_getparam(0, { 0 })                = 0
sched_setscheduler(0, SCHED_RR, { 1 })  = 0
sched_setparam(0, { 5 })                = 0
sched_getparam(0, { 0 })                = 0
sched_setscheduler(0, SCHED_OTHER, { 0 }) = 0
sched_setparam(0, { 0 })                = 0
sched_getparam(0, { 0 })                = 0
+++ exited with 5 +++
===============================================================================

3.15 getparam != setparam:
===============================================================================
[root@localhost bin]# uname -r
3.15.3-200.fc20.x86_64
[root@localhost bin]# strace \
    -e trace=sched_setscheduler,sched_setparam,sched_getparam \
    ./sched_setparam02 >/dev/null
sched_setscheduler(0, SCHED_FIFO, { 1 }) = 0
sched_setparam(0, { 5 })                = 0
sched_getparam(0, { 0 })                = 0
sched_setscheduler(0, SCHED_RR, { 1 })  = 0
sched_setparam(0, { 5 })                = 0
sched_getparam(0, { 0 })                = 0
sched_setscheduler(0, SCHED_OTHER, { 0 }) = 0
sched_setparam(0, { 0 })                = 0
sched_getparam(0, { 0 })                = 0
+++ exited with 5 +++
===============================================================================

--
Jeff

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
