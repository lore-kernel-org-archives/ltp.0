Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NbrhY-00019v-NY
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:32:08 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NbrhW-0008N5-HI
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:32:08 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.27])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 87F852112F0
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Feb 2010 08:31:59 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id DB2E61D7837
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Feb 2010 08:31:58 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Feb 2010 17:31:56 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 1 Feb 2010 17:31:55 +0900
Message-ID: <000001caa319$039c8660$0ad59320$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] rt_sigaction{02-03} tests validation
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

I understood that rt_sigaction01, rt_sigprocmask01 and rt_sigsuspend01 
tests failure is architecture(x86_64) specific issues. 
Sorry, I don't know how do I fix it, yet.

But when I examined these issues, I noticed that rt_sigaction's test
also has rt_sigaction{02-03} tests.
Currently, rt_sigaction{02-03} are not run.
I think that it's also necessary to run rt_sigaction{02-03} tests 
because rt_sigaction01 test well running at x86 architecture. 
How about add rt_sigaction{02-03} to the test case?

If "./runtest/syscalls" is fixed, these tests succeed as follows:

------------

Test Start Time: Mon Feb  1 16:38:37 2010
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
rt_sigaction01                 PASS       0
rt_sigaction02                 PASS       0
rt_sigaction03                 PASS       0
-----------------------------------------------
Total Tests: 3
Total Failures: 0
Kernel Version: 2.6.18-164.el5
Machine Architecture: i686
Hostname: 5-4.localdomain

------------

Index: 
./runtest/syscalls
============
--- runtest/syscalls.org        2009-12-16 04:32:18.000000000 +0900
+++ runtest/syscalls    2010-02-01 16:48:43.000000000 +0900
@@ -801,6 +801,8 @@
 rmdir05 rmdir05

 rt_sigaction01 rt_sigaction01
+rt_sigaction02 rt_sigaction02
+rt_sigaction03 rt_sigaction03
 rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
============


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
