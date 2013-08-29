Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1VErRi-0000qx-65
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 01:54:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VErRg-00086T-GI
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 01:54:49 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r7T1seLb028562
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Aug 2013 09:54:40 +0800
Message-ID: <521EAA6B.8090308@cn.fujitsu.com>
Date: Thu, 29 Aug 2013 09:56:59 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] Wanna execute the ltp and the openposix test suite together
 by one command
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
To: LTP list <ltp-list@lists.sourceforge.net>


Hi guys,


I want to implement that running the ltp test suite and the openposix test suite
together by one command, as currently, they are performed separately.

To make it, i get two ways,

A.
1. Run configure with option "--with-open-posix-testsuite", then the openposix test
   suite can be compiled and installed to /opt/ltp together with the ltp test.
2. Create a Makefile which drives the running of the openposix test suite under /opt/ltp
   and install it to /opt/ltp.
3. Add a new option to "runltp", when it is specified, the "runltp" will run command
   "make" to execute the openposix test suite.

Or B.
1. Add a new option to "runltp", when it is specified, the "runltp" will cd to
   "tesecase/open_posix_testsuite", compile and execute it.


Or does anbody have a better idea?


Regards,
DAN LI

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
