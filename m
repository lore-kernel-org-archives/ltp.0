Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NJ1hB-0006Pi-IY
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:21:53 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-4.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NJ1h5-0001st-24
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 09:21:53 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Dec 2009 18:21:37 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 11 Dec 2009 18:21:37 +0900
Message-ID: <000001ca7a43$574a3900$05deab00$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "cgroup_fj" and "cgroup" have problems?
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

Sorry for my many many mails today.


I ran tests with "ltp-2009-12-10" cvs.

In my system (kernel 2.6.18-164.el5), kernel does not support 
control groups.
So, when I ran test of "cgroup_fj", I got following message and the
test faild by "FAIL 253".

------------
***error***:you must enable cgroup config in kernel
------------

In the investigation for above error message, I found that there may be
two problems,.

  (a) "cgroup_fj" test failed in the system not support "control groups".
  (b) "cgroup" test may passed by user-ID which isn't "root".


(a) "cgroup_fj" test
  Above message is correct message, but exiting by "FAIL" is not
  correct, I think.
  Referring to the example of other tests, I think that the tests
  for non-supported functions must be finished in "PASS 0" basically.
  (For example, "move_pages{01...11}" tests exit in "PASS 0" and with 
  "NUMA support not provided" messages.)

  I suggest following patch to resolve this problem.

============
--- run_cgroup_test_fj.sh	2009-10-26 23:49:23.000000000 +0900
+++ run_cgroup_test_fj.sh.new	2009-12-11 16:10:39.000000000 +0900
@@ -40,7 +40,7 @@
 
 if ! [ -f /proc/cgroups ]; then
 	echo "***error***:you must enable cgroup config in kernel";
-	exit -3;
+	exit 0;
 fi
 
 if [ ! -x $TESTROOT/cgroup_fj_proc ]; then

============


(b) "cgroup" test
  I watched "cgroup" test source for hints for (a), and found another
  problem.
  If this test run by user-ID non-"root", it will exit in "PASS", I think.
  But I think that it must exit in "FAIL".
  Because this test cannot be tested only by "root" user.

=========
--- cgroup_regression_test.sh	2009-11-30 17:41:37.000000000 +0900
+++ cgroup_regression_test.sh.new	2009-12-11 16:22:14.000000000 +0900
@@ -37,7 +37,7 @@
 
 if [ "$USER" != root ]; then
 	tst_brkm TBROK ignored "Test must be run as root"
-	exit 0
+	exit -1
 fi
 
 tst_kvercmp 2 6 29

=========


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
